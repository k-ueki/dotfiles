#source ${Z_PATH}/abbr/alias.zsh

for f in ${Z_PATH}/abbr/*; do
	if [ -f $f ]; then
		source $f
	fi
done
