#!/bin/zsh

# Go
go env -w GOPRIVATE=github.com/ajainc,ghe.ca-tools.org

# JVM (scalaenv / jenv)
eval "$(scalaenv init -)"
eval export PATH="$HOME/.jenv/shims:${PATH}"
unset JAVA_HOME
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
    eval $(command jenv "sh-$command" "$@") ;;
  *)
    command jenv "$command" "$@" ;;
  esac
}
