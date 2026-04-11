# zsh completion for mux
_mux() {
  local MUX_CONFIG_DIR="${MUX_CONFIG_DIR:-$HOME/.config/mux}"
  local WORKSPACE_DIRS="${WORKSPACE_DIRS:-$HOME/workspace:$HOME/spikes}"

  local -a sessions configs dirs

  sessions=(${(f)"$(tmux ls -F '#{session_name}' 2>/dev/null)"})
  [[ -d "$MUX_CONFIG_DIR" ]] && configs=(${MUX_CONFIG_DIR}/*.sh(N:t:r))

  local wdir
  for wdir in ${(s.:.)WORKSPACE_DIRS}; do
    [[ -d "$wdir" ]] && dirs+=(${wdir}/*(N/:t))
  done

  case $CURRENT in
    2)
      if [[ $words[2] == -* ]]; then
        _alternative 'flags:flag:((-l\:"list sessions and configs" --list\:"list sessions and configs" -k\:"kill a session" --kill\:"kill a session" -h\:"show help" --help\:"show help"))'
      else
        _alternative \
          'sessions:running session:($sessions)' \
          'configs:config:($configs)' \
          'dirs:directory:($dirs)'
      fi
      ;;
    3)
      case $words[2] in
        -k|--kill)
          _alternative 'sessions:running session:($sessions)'
          ;;
      esac
      ;;
  esac
}

compdef _mux mux
