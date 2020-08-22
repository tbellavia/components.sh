#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
DARK_GRAY='\033[1;30m'
NC='\033[0m'

_help=$(cat <<HELP
StatusMessage [--help], type, start, padding, message
	Parameters
		:type:		the status type of message, accept the following value
		:start:		the starting character
		:padding:	the space between start character and message
		:message:	the message to be printed
	Type
		- ${BLUE}primary${NC}
		- ${DARK_GRAY}secondary${NC}
		- ${YELLOW}success${NC}
		- ${RED}danger${NC}
		- ${ORANGE}warning${NC}
	Exit
		StatusMessage returns 0 if no error is encountered otherwise returns following values
			1 -> Missing parameter
			2 -> Unknown status type
			3 -> Help
			4 -> Too many parameters
HELP
)

if [[ "$#" == 1 ]]
then
	if [[ "$1" == "--help" ]]
	then
		printf "$_help\n"
	fi
	exit 3
elif [[ "$#" -gt 4 ]]
then
	printf "Too many parameters\n"
	exit 4
fi

case "$1" in
	"primary")
		_color="${BLUE}"
		;;
	"secondary")
		_color="${DARK_GRAY}"
		;;
	"success")
		_color="${YELLOW}"
		;;
	"danger")
		_color="${RED}"
		;;
	"warning")
		_color="${ORANGE}"
		;;
	*)
		exit 2
esac

printf "${_color}%s${NC} %${3}s%s\n" "${2}" "${4}"