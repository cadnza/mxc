#!/usr/bin/env sh

# Set prefix
pre="mxc: "

# Check whether parameter is a file
[[ -f $1 ]] || {
	echo $pre"Buffer not saved"
	exit 1
}

# Check whether parameter is executable
[[ -x $1 ]] || {
	echo $pre"$1 is not executable"
	exit 1
}

# Exit
exit 0
