#!/usr/bin/env sh

# Check whether parameter is executable
[[ -x $1 ]] && echo 0 || echo 1

# Exit
exit 0
