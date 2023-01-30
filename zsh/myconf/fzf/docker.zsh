#!bin/zsh

function _fzf_docker_exec() {
	BUFFER+="docker exec -it $(docker ps --format "{{.Names}}" | fzf) bash"
	zle accept-line
}
zle -N _fzf_docker_exec
bindkey '^x' _fzf_docker_exec

alias dlogs="_fzf_docker_logs"
function _fzf_docker_logs() {
	local container=$(docker ps --format "{{.Names}}" | fzf)
	docker logs -f $container
}
zle -N _fzf_docker_logs

