---
name: mux-orchestrator
description: The user's tmux + opencode multi-session workflow (mux layouts, `oc` for launching and driving opencode sessions, shared opencode server on :4096). Use when the user mentions mux, oc, tmux panes, opencode sessions, `opencode attach`, or asks "what am I running" / "what sessions are open" / "send a prompt to session X" / "kill session" / "take over". Covers the oc subcommand surface, launching TUIs, directory-header routing, and port-collision probes.
---

# mux + opencode workflow

The user runs a single shared `opencode serve --port 4096` and **every** opencode TUI on the machine is an `opencode attach` client pinned to a session on that server. Operations are done through the `oc` command — not raw `curl`. Use `oc` in scripts, automations, and when answering questions about the user's opencode state.

## Invariants

- **One server on `:4096`** (configurable via `$OPENCODE_BASE`). Never start additional `opencode serve` instances; `oc` bootstraps and reuses the shared one.
- **Every TUI is `opencode attach --session ses_... --dir <path>`**. No random-port TUIs, no integrated-mode TUIs. `oc tuis` only lists these.
- **The real binary `/opt/homebrew/bin/opencode` is untouched.** `oc` is a separate command — use the real one directly when you need `opencode serve`, `opencode attach` with custom flags, `opencode -s ses_...`, `opencode export`, etc.

## Commands

Run `oc -h` for the authoritative, current usage. High level:

| | |
|---|---|
| `oc` / `oc <dir>` | Launch a TUI (shared server + pre-created session + attach). |
| `oc tuis` | List live attach-mode TUIs (PID, session id, title, dir). |
| `oc history [--dir <d>] [-n N]` | List past sessions on the server (all or filtered by dir). |
| `oc send <sid> "<text>"` | Send a prompt to a session; print the assistant's final reply. |
| `oc send --dir <d> "<text>"` | Resolve the sid from the live TUI in `<d>`, then send. Fails if zero or multiple TUIs are in that dir. |
| `oc show <sid> [-n N]` | Dump the last N messages in a session (roles, text, tool calls). |
| `oc rm <sid>` | Delete a session from the server (TUI, if attached, keeps running but can't post new messages). |
| `oc attach <sid>` | Take over a session in a new terminal/tmux pane. Full live sync with any other TUI on the same session. |
| `oc watch [--dir <d>]` | Tail the SSE event stream from the server. |
| `oc server status` | Report the shared server's port, PID, health, default model. |
| `oc server restart` | Kill and relaunch the shared server (needed after editing `~/.config/opencode/opencode.json` — config is cached at startup). |

`mux` / `spike` / `opencode` (real) commands remain as-is — see their own `-h` for details. `mux`'s default workspace layout calls `mux_opencode` internally, which is the same machinery as `oc`.

## Reading `oc tuis` / `oc history` output

Titles are rendered with a `[label]` prefix derived from the session's directory:

- Spike dirs (`~/spikes/2026-04-19_foo`) → `[foo]` (the date is stripped).
- Generic leaves (`repos`, `src`, `work`, `projects`, `code`, `dev`) → `[<parent>/<leaf>]` for context.
- Everything else → `[<leaf>]`.

Default opencode titles (`"New session - <ISO ts>"`, `"Child session - <ISO ts>"`) are replaced by just the label. Real titles are prepended with the label. This is display-only — the server stores the opencode title unchanged, so opencode's auto-title pass still runs after the first user message, and external clients (the opencode TUI itself, web UI) see the original title.

## Mental model

Two orthogonal axes:

| | **Live** (has a TUI attached now) | **History** (stored but no TUI) |
|---|---|---|
| `oc tuis` shows it | ✓ | ✗ |
| `oc history` shows it | ✓ (if server still has it) | ✓ |
| `oc send` / `oc show` / `oc rm` accept its id | ✓ | ✓ |
| `oc attach <sid>` works | ✓ (creates a 2nd concurrent TUI, live-synced with the first) | ✓ (resurrects it into a new TUI) |

**"Am I done with session X?"** — check `oc tuis`: if listed, there's an open TUI; if not, it's history. Either way, `oc rm <sid>` safely discards it.

## Typical flows

### "What do I have running and what is each doing?"
```
oc tuis                             # which TUIs are alive
oc show <sid> -n 3                  # last few messages for any of them
```

### "Drive session X from here"
```
oc send ses_abc... "please do thing"            # explicit sid
oc send --dir ~/workspace/foo "please do thing" # auto-resolve from the TUI in that dir
```

### "Take over what another session is working on"
```
oc attach ses_abc...                # opens a new TUI on that session
```
Both TUIs see the same state; messages and streaming sync live.

### "Clean up an old session"
```
oc rm ses_abc...
```

### "Config changed — restart"
```
oc server restart
```

### "Something isn't landing where I expected"
```
oc server status                    # is the server healthy? which default model?
oc watch                            # watch events in real time while you reproduce
```

## Concepts worth knowing (not commands)

### The `x-opencode-directory` header
Opencode runs every request under an "instance directory" set from this header (or `?directory=` query). It controls:
- Where `bash`/`read`/`edit` tool invocations execute.
- Which TUI receives `tui.*` broadcast events (opencode.nvim relies on this to route `<leader>oq` prompts to the right TUI).

`oc send` sets this header automatically (to the session's stored directory). If you ever write a raw `curl` call against the API, set the header explicitly.

### Session metadata ≠ tool execution directory
A session object has a `directory` field (set at creation via `?directory=`), but it's **metadata only**. What actually controls where tools run is the `x-opencode-directory` header on the request that sends the message. `oc send` handles this correctly; naive `curl` to `/session/:id/message` without the header will run tools in the server's ambient cwd instead.

### Config is cached per server at startup
Editing `~/.config/opencode/opencode.json` has no effect on the running server. Use `oc server restart`. This is why an `oc` invocation might hang with "0 bytes returned" if you set an invalid default model between server restarts — see Gotchas below.

### `opencode.nvim` integration
Config in `~/.config/nvim/lua/plugins/opencode.lua`:
```lua
vim.g.opencode_opts = {
  server = { port = 4096, start = false },
}
```
The plugin talks to `:4096`, and `<leader>oq` etc. publish `tui.*` events that — thanks to our local patch on branch `jp/directory-header` in `~/.local/share/nvim/lazy/opencode.nvim/` — carry nvim's `getcwd()` as the directory header, so events route to the TUI in that directory.

## Gotchas

### G1. Silent 0-byte responses after a config change
If you edit `~/.config/opencode/opencode.json` and change the default `model` to something the running server can't resolve (e.g. rename a provider without restarting), every `oc send` that relies on the default will return nothing. Fix: `oc server restart`.

### G2. `oc send` returns only the final text message
Tool invocations happen in *separate* assistant messages not shown by `oc send`. Use `oc show <sid>` afterwards to see bash/read/edit tool calls and their outputs.

### G3. Sessions are cheap; TUIs are not
Session rows accumulate in the server's SQLite; `oc rm` or leaving them are both fine. TUIs are OS processes — closing a tmux pane cleanly terminates the `opencode attach` child (which keeps the session intact, just unsubscribed).

### G4. `oc tuis` is "live TUIs" not "sessions in use"
A session with no TUI attached won't appear in `oc tuis`. That's normal. Use `oc history` to see everything the server knows about.

### G5. Port 4096 collision
If something else grabs 4096, `oc` refuses cleanly with the owner PID and suggests setting `$OPENCODE_BASE` to an alternate port. Change it in your shell init and the nvim plugin config together (`port = N`). The `_opencode_common.sh` helper distinguishes "stuck opencode on port" from "other process owns port" and prints an actionable message.

### G6. `oc history` lists up to 500 sessions by default
Use `--dir <d>` to filter. Sessions include subagent spawns unless filtered (history uses `?roots=true` internally, so subagent forks are already excluded).

## File layout

| File | Purpose |
|---|---|
| `~/.local/bin/oc` | Launcher + subcommand dispatcher. |
| `~/.local/bin/_opencode_common.sh` | Shared helpers: server bootstrap, session create, dir→sid resolution, URL-encode. |
| `~/.local/bin/mux` | tmux session manager (unchanged except for `mux_opencode` layout primitive). |
| `~/.local/bin/spike` | Dated spike dirs + `mux`. |
| `~/.config/mux/*.sh` | Per-project tmux layouts (call `mux_opencode`). |
| `~/.config/opencode/opencode.json` | Opencode config (restart server after edits). |
| `~/.config/nvim/lua/plugins/opencode.lua` | opencode.nvim config (port=4096, start=false). |
| `/tmp/opencode-server.log` | Shared server's log (volatile, OS cleans up). |

## Reference

Design notes and validation experiments live in:
`~/spikes/2026-04-19_create-my-own-orchestrator/`
- `FINDINGS.md` — API surface, what was tested, gotchas discovered.
- `INTEGRATION.md` — why the current shape exists; what's parked.

Read those when making non-trivial changes (new subcommand, port migration, upstream plugin PR).
