#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$(tput setaf 1)This will overwrite your current profile!$(tput sgr0)  Do you wish to proceed? [y/n]"
read input

if [[ $input == "Y" || $input == "y" || $input == "yes" ]]; then
	PROCEED="YES"
else
	echo "Maybe next time '⌢'"
	exit 1
fi

cd ~
if [[ ! -d dotfiles ]]; then
	mkdir dotfiles
fi

FILES=${SCRIPT_DIR}/dotfiles/.*
for f in $FILES
do
	if [[ -f ${f} ]]; then
		cp ${f} dotfiles
	fi
done
ls -la dotfiles

cp ${SCRIPT_DIR}/.profile .profile
