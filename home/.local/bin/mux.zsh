# zsh completion for mux
_mux() {
  local MUX_CONFIG_DIR="${MUX_CONFIG_DIR:-$HOME/.config/mux}"

  local -a sessions configs

  sessions=(${(f)"$(tmux ls -F '#{session_name}' 2>/dev/null)"})
  [[ -d "$MUX_CONFIG_DIR" ]] && configs=(${MUX_CONFIG_DIR}/*.sh(N:t:r))

  case $CURRENT in
    2)
      if [[ $words[2] == -* ]]; then
        _alternative 'flags:flag:((-l\:"list sessions and configs" --list\:"list sessions and configs" -k\:"kill a session" --kill\:"kill a session" -h\:"show help" --help\:"show help"))'
      else
        _alternative \
          'sessions:running session:($sessions)' \
          'configs:config:($configs)'
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
