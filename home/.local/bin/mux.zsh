# zsh completion for mux
_mux() {
  local MUX_CONFIG_DIR="${MUX_CONFIG_DIR:-$HOME/.config/mux}"
  local WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/workspace}"

  local -a sessions configs workspace_dirs

  sessions=(${(f)"$(tmux ls -F '#{session_name}' 2>/dev/null)"})

  [[ -d "$MUX_CONFIG_DIR" ]] && configs=(${MUX_CONFIG_DIR}/*.sh(N:t:r))

  [[ -d "$WORKSPACE_DIR" ]] && workspace_dirs=(${WORKSPACE_DIR}/*(N/:t))

  case $CURRENT in
    2)
      case $words[2] in
        -k|--kill)
          _describe 'running session' sessions
          return
          ;;
      esac

      local -a opts
      opts=(
        '-l:list sessions and configs'
        '--list:list sessions and configs'
        '-k:kill a session'
        '--kill:kill a session'
        '-h:show help'
        '--help:show help'
      )

      local -a all_names
      [[ ${#sessions}       -gt 0 ]] && all_names+=("${sessions[@]}")
      [[ ${#configs}        -gt 0 ]] && all_names+=("${configs[@]}")
      [[ ${#workspace_dirs} -gt 0 ]] && all_names+=("${workspace_dirs[@]}")
      all_names=(${(u)all_names})

      _describe 'option'  opts       -- \
               'session' sessions   -- \
               'config'  configs    -- \
               'workspace' workspace_dirs
      ;;
    3)
      case $words[2] in
        -k|--kill)
          _describe 'running session' sessions
          ;;
      esac
      ;;
  esac
}

compdef _mux mux
