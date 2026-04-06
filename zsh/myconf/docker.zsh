#!/bin/zsh
# @default-category docker

# @desc 実行中コンテナを fzf で選択して docker exec でシェルを起動する
# @key ^x
function _fzf_docker_exec() {
	BUFFER+="docker exec -it $(docker ps --format '{{.Names}}' | fzf) bash"
	zle accept-line
}
zle -N _fzf_docker_exec
bindkey '^x' _fzf_docker_exec

# @desc 実行中コンテナを fzf で選択して docker logs -f する
alias dlogs="_fzf_docker_logs"
function _fzf_docker_logs() {
	local container=$(docker ps --format '{{.Names}}' | fzf)
	[ -n "$container" ] && docker logs -f "$container"
}
