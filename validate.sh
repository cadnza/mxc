#!/usr/bin/env sh

# Set prefix
pre="mxc: "

# Trim whitespace from path
f=$(echo $1 | sed "s/ *$//g" | sed "s/^ *//g")

# Check whether parameter is a file
[[ -f $f ]] || {
	echo $pre"Buffer not saved"
	exit 1
}

# Check whether parameter is executable
[[ -x $f ]] || {
	echo $pre"$1 is not executable"
	exit 1
}

# Exit
exit 0
