## Go

# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"
go env -w GOPRIVATE=github.com/ajainc,ghe.ca-tools.org


## JVM
eval "$(scalaenv init -)"
eval export PATH="/Users/s11308/.jenv/shims:${PATH}"
unset JAVA_HOME

source '/usr/local/Cellar/jenv/0.5.4/libexec/libexec/../completions/jenv.zsh'
jenv rehash 2>/dev/null
jenv refresh-plugins
jenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}
