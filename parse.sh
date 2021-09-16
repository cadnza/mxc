#!/usr/bin/env sh

# Get buffer address
f=$(readlink -n $1)

# Check if buffer addresss is a directory and return it if find .mxc isn't specified
[[ -d $f ]] && [[ $2 -ne 1 ]] && {
	echo $f
	exit 0
}

# Look for .mxc if specified
m=".mxc"
[[ $2 = 1 ]] && {
	# Get containing directory if buffer address is a file (or use buffer address if it's a directory)
	[[ -d $f ]] && d=$f || d=$(dirname $f)
	# Check for .mxc in immediate directory
	[[ -f "$d/$m" ]] && {
		echo "$d/$m"
		exit 0
	}
	# Parse git repo back to root for .mxc if in a git repo
	dGit=$(git rev-parse --show-toplevel 2> /dev/null)
	[[ -d $dGit ]] && {
		while [[ $d != $dGit ]]
		do
			d=$(dirname $d)
			[[ -f "$d/$m" ]] && {
				echo "$d/$m"
				exit 0
			}
		done
	}
}

# Return original buffer address
echo $f
