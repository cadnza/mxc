#!/usr/bin/env sh

# Get buffer address
f=$(realpath $1)

# Go to buffer directory
[[ -d $f ]] && cd $f || cd "${f%/*}"

# Check if buffer address is a directory and return it if find .mxc isn't specified
[[ -d $f ]] && [[ $2 -ne 1 ]] && {
	echo $f
	exit 0
}

# Look for .mxc if specified
m=".mxc"
[[ $2 = 1 ]] && {
	# Get containing directory if buffer address is a file (or use buffer address if it's a directory)
	[[ -d $f ]] && d=$f || d="${f%/*}"
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
			d="${d%/*}"
			[[ -f "$d/$m" ]] && {
				echo "$d/$m"
				exit 0
			}
		done
	}
	# Exit with error if .mxc not found
	exit 1
}

# Return original buffer address
echo $f
