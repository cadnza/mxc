#!/usr/bin/env sh

# Check whether parameter is a file
[[ -f $1 ]] && echo 0 || echo 1

# Exit
exit 0
