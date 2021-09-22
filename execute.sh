#!/usr/bin/env sh

# Display message
echo "\033[1;36m$1\033[0m"

# Run script
$1 # This is erroring when dealing with an irregular filepath; still needs fixed. #TEMP

# Exit
exit 0
