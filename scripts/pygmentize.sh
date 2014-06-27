#!/bin/bash

PYG=`which pygmentize`
if [[ -z ${PYG} ]]; then
	sudo pip install Pygments
fi
