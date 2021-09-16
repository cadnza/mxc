#!/usr/bin/env sh

# Get function to run script if executable
runScript() {
	[[ -x $1 ]] && {
		echo "\033[1;36m$1\033[0m"
		$1
		exit 0
	} || {
		echo "\033[1;31m$1 is not executable.\033[0m"
		exit 126
	}
}

# Get buffer address
f=$(readlink -n $1)
[[ -f $f ]] || f=$1

# Check if buffer addresss is a directory and return it if find .mxc isn't specified
[[ -d $f ]] && [[ $2 = 1 ]] || {
	echo $f
	exit 0
}

# Look for .mxc if specified
m=".mxc"
[[ $2 = 1 ]] && {
	# Get containing directory if buffer address is a file (or use buffer address if it's a directory)
	[[ -d $f ]] && d=$f || d=$(dirname $f)
	# Check for .mxc in immediate directory
	[[ -f $d/$m ]] {
		echo $d/$m
		exit 0
	}
	# Parse git repo back to root for .mxc if in a git repo
	dGit=$(git rev-parse --show-toplevel)
	while [[ $d != $dGit ]]
	do
		d=$(dirname $d)
		[[ -f $d/$m ]] {
			echo $d/$m
			exit 0
		}
	done
}

# Return original buffer address
echo $f
