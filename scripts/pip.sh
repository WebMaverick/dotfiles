#!/bin/bash

PIP=`which pip`
if [[ -z ${PIP} ]]; then
	curl -O https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py
	rm get-pip.py
fi
