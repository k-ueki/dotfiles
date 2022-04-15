#function is_exists() { type "$1" >/dev/null 2>&1; return $?;}
#function is_osx() { [[ $OSTYPE == darwin* ]]; }
#function is_screen_running() { [ ! -z "$STY" ]; }
#function is_tmux_running() { [ ! -z "$TMUX" ]; }
#function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
#function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
#function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
#
#function tmux_automatically_attach_session()
#{
#    if is_screen_or_tmux_running; then
#        ! is_exists 'tmux' && return 1
#    else
#        if shell_has_started_interactively && ! is_ssh_running; then
#            if ! is_exists 'tmux'; then
#                echo 'Error: tmux command not found' 2>&1
#                return 1
#            fi
#
#			if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
#                # detached session exists
#                tmux list-sessions
#                echo -n "Tmux: attach? (y/N/num) "
#                read
#                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
#                    tmux attach-session
#                    if [ $? -eq 0 ]; then
#                        echo "$(tmux -V) attached session"
#                        return 0
#                    fi
#                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
#                    tmux attach -t "$REPLY"
#                    if [ $? -eq 0 ]; then
#                        echo "$(tmux -V) attached session"
#                        return 0
#                    fi
#                fi
#            fi
#
#			if is_osx && is_exists 'reattach-to-user-namespace'; then
#                # on OS X force tmux's default command
#                # to spawn a shell in the user's namespace
#                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
#                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
#            else
#                tmux new-session && echo "tmux created new session"
#            fi
#        fi
#    fi
#}

# For Dynalyst
sessions=(
	"conv-apps"
	"conv-form"
	"conv-dig"
	
	"sbt"
	
	"work"
)
function start_session() { 
	tmux new -s $1
	tmux detach -s $1
}
# for session in $sessions; do
# 	start_session $session
# done


# if [[ -z $(pgrep tmux) ]]; then
# 	echo false
# 	for session in $sessions; do
# 		start_session $session
# 	done
# else
# 	echo true
# fi
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
