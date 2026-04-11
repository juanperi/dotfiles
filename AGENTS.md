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

Two workflows depending on where you create the file:

**Workflow A — File already exists in `~/`** (preferred):
```sh
homeshick track dotfiles ~/.foo
# Moves ~/.foo → home/.foo, symlinks ~/.foo → castle, and git-adds it
```

**Workflow B — Create directly in the castle**:
```sh
# 1. Create the file inside the castle
vim ~/.homesick/repos/dotfiles/home/.foo

# 2. Stage it in git (REQUIRED — homeshick link ignores untracked files)
git -C ~/.homesick/repos/dotfiles add home/.foo

# 3. Create the symlink
homeshick link dotfiles
```

> `homeshick link` uses `git ls-files` internally — files must be at least staged (`git add`) to be linked. Untracked files are invisible to it. Use `--force` to overwrite existing files in `~/` without prompting.

**To stop tracking a file**: remove it from `home/`, delete the symlink in `~/`, and restore the real file manually. homeshick has no `untrack` command.

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

Custom script at `~/.local/bin/mux`. Zsh completions via `~/.local/bin/mux.zsh` (auto-sourced).

```sh
mux                  # fzf picker (sessions + configs + workspace dirs)
mux <name>           # attach or create session
mux -l               # list sessions, configs, and all workspace dirs
mux -k <name>        # kill session
```

Resolution order for `mux <name>`:
1. Running tmux session → attach
2. Config at `~/.config/mux/<name>.sh` → create from config
3. First match across `WORKSPACE_DIRS`:
   - If git worktree with parent config → inherit parent config (session-per-worktree)
   - Otherwise → default layout (nvim left 75% + opencode + terminal right)
4. Fallback → bare session in cwd

**`WORKSPACE_DIRS`** — colon-separated list of directories to scan (default: `~/workspace:~/spikes`). Each dir's basename is used as the fzf label, so typing `workspace` or `spikes` filters the picker.

**Session config files** (`~/.config/mux/<name>.sh`) use exported helpers:
```bash
ROOT="${MUX_ROOT:-$HOME/workspace/myproject}"  # supports worktree inheritance
w=$(mux_new_session "$ROOT")     # create session, returns window index
mux_split_editor "$w" "$ROOT"    # vim (75%) + 2 terminals
mux_split_tiled "$w" "$ROOT"     # 2×2 tiled shells
tw=$(mux_new_window "$ROOT" name)
mux_focus_window "$w"
```

**Worktree inheritance**: if a directory is a git worktree and its parent repo has a mux config, the config is reused with `MUX_ROOT` pointing to the worktree. All configs must use `ROOT="${MUX_ROOT:-...}"` to support this. Example: `mux martech-traffic_analytics` runs `martech.sh` but rooted at the worktree path.

Defined configs: `dotfiles`, `workspace`, `showoff`.

## spike — dated scratch workspaces

Script at `~/.local/bin/spike`. Creates `~/spikes/YYYY-MM-DD_description/` and opens it with `mux`.

```sh
spike                        # prompts for description
spike "test redis caching"   # skip prompt
```

tmux hotkey: `prefix + N` — opens a popup that runs `spike`.

## Utility scripts in `~/.local/bin/`

- `to_ts <date> [ms|s]` — date string → unix timestamp (requires GNU `gdate`)
- `from_ts` — unix timestamp → date string
- `mux` / `mux.zsh` — tmux session manager + zsh completions
- `spike` — create dated scratch workspaces in `~/spikes/`

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
source <(curl -fsSL https://raw.githubusercontent.com/juanperi/dotfiles/master/install.sh)
```

install.sh auto-installs: homeshick, oh-my-zsh. It warns about missing optional tools.

### Dependencies

**Hard required** (bootstrap won't work without):
- `git`, `curl` — checked by install.sh
- `zsh` — primary shell
- `tmux` — session management, mux
- `nvim` (neovim) — editor

**Core tools** (things break without these):
- `fzf` — mux picker, telescope, shell history
- `rg` (ripgrep) — telescope live grep (hardcoded in vimgrep_arguments)
- `make` — telescope-fzf-native build, LuaSnip build
- `gcc` or `clang` — treesitter parser compilation
- `tree-sitter` — treesitter parser compilation
- `node` — copilot.lua, markdown-preview

**Utility tools** (used by scripts and keymaps):
- `gdate` (GNU coreutils) — `to_ts` / `from_ts` scripts (`brew install coreutils`)
- `jq` — nvim `fj` keymap (format JSON), awshelp script
- `python3` — nvim URL encode/decode keymaps
- `base64` — nvim base64 encode/decode keymaps (ships with macOS)
- `ag` (silver searcher) — code search
- `git-lfs` — configured in .gitconfig
- `opencode` — launched by mux default layout and keymaps

**Optional (conditional in .zshrc)**:
- `direnv` — auto-loads `.envrc` files if installed
- `asdf` — version manager, loaded from `/opt/homebrew/opt/asdf/libexec/asdf.sh`
- `gcloud` SDK — loaded if present at `~/google-cloud-sdk/`

**macOS-specific**:
- `Homebrew` — path setup in .zshrc for `/opt/homebrew`
- `Hammerspoon` — for `.hammerspoon/init.lua` (hyper keys, mic mute, VimMode)
- `Alacritty` — terminal emulator config provided
- `Hack Nerd Font Mono` — font for Alacritty and nvim-web-devicons
- `terminal-notifier` — `notifyDone` alias

**Work tools** (for awshelp script):
- `aws` CLI v2 — SSO auth, RDS token generation
- `psql` — database connections (fallback)
- `pgcli` — enhanced PostgreSQL client (preferred over psql)
- `k9s` — Kubernetes TUI

**Neovim LSPs** (auto-installed by mason):
- `lua-language-server`, `stylua` — via mason-tool-installer
- `expert`, `dexter` — Elixir LSPs, custom binaries (must install manually)

**tmux plugins** (auto-installed by tpm on first run):
- tmux-yank, tmux-sessionist, tmux-copycat, tmux-logging, vim-tmux-navigator

### Quick brew install

```sh
# Core
brew install tmux neovim fzf ripgrep make gcc tree-sitter node

# Utilities
brew install coreutils jq python3 the_silver_searcher git-lfs

# Optional
brew install direnv asdf pgcli k9s

# Font
brew install --cask font-hack-nerd-font

# macOS apps
brew install --cask hammerspoon alacritty
```
