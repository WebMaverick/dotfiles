#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$(tput setaf 1)This will overwrite your current profile!$(tput sgr0)  Do you wish to proceed? [y/n]"
read input

copyFiles () {
	if [[ -d ${SCRIPT_DIR}/${1} ]]; then
		local DIR=~/${1}

		if [[ ! -d ${DIR} ]]; then
			# echo "Creating directory ${DIR}"
			mkdir ${DIR}
		fi

		DOTFILES=${SCRIPT_DIR}/${1}/.*
		FILES=${SCRIPT_DIR}/${1}/*
		for f in $FILES
		do
			if [[ -f ${f} ]]; then
				# echo "Copying ${f} to ${DIR}"
				cp ${f} ${DIR}
			elif [[ -d ${f} ]]; then
				SUBDIR=${f/${SCRIPT_DIR}\//}
				copyFiles ${SUBDIR}
			fi
		done
		for f in $DOTFILES
		do
			if [[ -f ${f} ]]; then
				# echo "Copying ${f} to ${DIR}"
				cp ${f} ${DIR}
			fi
		done
	fi
}



if [[ $input == "Y" || $input == "y" || $input == "yes" ]]; then
	PROCEED="YES"
else
	echo "Maybe next time '⌢'"
	exit 1
fi

cd ~
copyFiles dotfiles
copyFiles bin

# Make aliases
cd ~/bin
if [[ ! -h d ]]; then
	ln -s diffmerge-any d
fi
if [[ ! -h p ]]; then
	ln -s playSound p
fi
if [[ ! -h s ]]; then
	ln -s ~/git/WebMaverick/5498884/s.sh s
fi
if [[ ! -h subl ]]; then
	ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl subl
fi

cp ${SCRIPT_DIR}/.profile ~/.profile
source ~/.profile

cd ${SCRIPT_DIR}
source scripts/pip.sh
source scripts/pygmentize.sh


echo "Now run: source ~/.profile"
