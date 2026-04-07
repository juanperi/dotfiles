# AGENTS.md — dotfiles

Personal dotfiles managed by [homeshick](https://github.com/andsens/homeshick).

## Repo structure

```
home/           → symlinked into $HOME by homeshick (every file here is a dotfile)
install.sh      → bootstrap script (homeshick + vim plugins + zsh)
modify_keys.sh  → keyboard remapping helper
```

Files under `home/` map 1:1 to `~/`:
- `home/.config/nvim/` → `~/.config/nvim/` (Neovim — lazy.nvim, Lua)
- `home/.config/tmux/tmux.conf` → tmux config
- `home/.config/mux/` → `mux` session configs (bash scripts)
- `home/.local/bin/` → custom CLI tools on `$PATH`
- `home/.zshrc`, `home/.gitconfig`, etc.

## How to apply changes

```sh
# Re-link all dotfiles (safe to re-run)
homeshick -f link dotfiles

# Reload tmux config
tmux source ~/.config/tmux/tmux.conf
# Or inside tmux: prefix + r  (prefix = C-Space)
```

Do **not** edit files in `~/` directly — edit the source in `home/` and re-link.

## Adding or removing dotfiles

**To track a new file** (e.g. `~/.foo`): homeshick moves it into the castle and symlinks it back.
```sh
homeshick track dotfiles ~/.foo
# ~/.foo is now home/.foo in this repo, and ~/.foo is a symlink
```

**To stop tracking a file**: remove it from `home/`, delete the symlink in `~/`, and restore the real file manually. homeshick has no `untrack` command.

**Never** create files directly inside `home/` without running `homeshick track` — the symlink in `~/` won't exist and the file won't be live.

## Neovim

- Plugin manager: **lazy.nvim** (auto-installed on first start)
- Config entrypoint: `home/.config/nvim/init.lua`
- Plugins live in: `home/.config/nvim/lua/plugins/` (one file per plugin)
- `lazy-lock.json` is committed — update plugins with `:Lazy update` then commit the lock file
- LSP managed by mason + mason-lspconfig. Configured servers: `lua_ls`, `expert` (Elixir, local binary at `~/.local/bin/expert`)
- Installed formatter: `stylua` (via mason-tool-installer)

## tmux

- Prefix: **C-Space** (not the default C-b)
- `prefix + t` — toggle broadcast to all panes (synchronize-panes)
- `prefix + r` — reload config
- TPM auto-installs on first start; plugins in `~/.config/tmux/plugins/`

## mux — tmux session manager

Custom script at `~/.local/bin/mux`. Source loaded automatically in zsh if tmux is available.

```sh
mux                  # fzf picker (sessions + configs + workspace dirs)
mux <name>           # attach or create session
mux -l               # list sessions and configs
mux -k <name>        # kill session
```

Resolution order for `mux <name>`:
1. Running tmux session → attach
2. Config at `~/.config/mux/<name>.sh` → create from config
3. Directory at `~/workspace/<name>` → default layout (nvim left 75% + 2 terminals right)
4. Fallback → bare session in cwd

**Session config files** (`~/.config/mux/<name>.sh`) use exported helpers:
```bash
w=$(mux_new_session "$ROOT")     # create session, returns window index
mux_split_editor "$w" "$ROOT"    # vim (75%) + 2 terminals
mux_split_tiled "$w" "$ROOT"     # 2×2 tiled shells
tw=$(mux_new_window "$ROOT" name)
mux_focus_window "$w"
```

Defined configs: `dotfiles`, `workspace`, `showoff`.

## Utility scripts in `~/.local/bin/`

- `to_ts <date> [ms|s]` — date string → unix timestamp (requires GNU `gdate`)
- `from_ts` — unix timestamp → date string
- `mux` / `mux.zsh` — tmux session manager + zsh completions

## Git config (non-obvious settings)

- `branch.autosetuprebase = always` — all new branches rebase by default (no merge commits on pull)
- GPG signing key configured: `37D50ECCF189A98F`
- `git rerere` enabled
- `[include] path = ./.gitconfig.local` — local overrides (not in repo)
- URL rewrites: `github.com:gartner-digital-markets/`, `capterra/`, `software-advice/` → redirect through `git@github.com-gartner:` SSH alias
- Useful aliases: `git lol` (full graph log), `git delete-squash` (delete squash-merged branches)

## zsh

- Shell: oh-my-zsh, theme `amuse`, plugins: `git z vi-mode`
- `~/.zshrc.local` is sourced at end — use for machine-specific config (not in repo)
- `direnv` hooked in if installed
- `asdf` loaded from `/opt/homebrew/opt/asdf/libexec/asdf.sh`
- `EDITOR`/`VISUAL` = nvim; `GOPATH` = `~/workspace/go`; `KEYTIMEOUT=15` (for vi-mode responsiveness)

## Hammerspoon (macOS)

- `hyper` = Ctrl+Alt+Cmd
- `hyper + a` — mic mute toggle
- VimMode spoon: `jj` enters normal mode system-wide (disabled in: Code, Alacritty, iTerm, Terminal, Zoom, Obsidian)

## Adding a new plugin to neovim

Create `home/.config/nvim/lua/plugins/<plugin-name>.lua` returning a lazy.nvim spec table. Run `:Lazy sync` inside nvim, then commit `lazy-lock.json`.

## Install from scratch

```sh
cd ~
source <(curl -fsSL https://raw.githubusercontent.com/epilgrim/dotfiles/master/install.sh)
# Then install optional deps:
brew install the_silver_searcher   # ag
brew install ctags
```

Dependencies checked by install.sh: `git`, `curl` (hard required); `ag`, `ctags` (warnings only).
