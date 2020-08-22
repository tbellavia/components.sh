#!/bin/sh

# Create new bin folder
# Change mod of all scripts in bin mod
# Copy all the file into the binary directory
# Export env variable

target="$HOME/.bin"
components="srcs/components"

if [[ ! -d "$target" ]]
then
	echo "> Bin directory doesn't exists, creating it"
	mkdir "${target}"
fi

printf "%-20s %-20s\n" "SRC" "DEST"

for script in $(find -L ${components})
do
	if [ -f "${script}" ]
	then
		printf "%-20s %-20s\n" "$(basename ${script})" "$(basename ${target})"
		cp "${script}" "${target}"
	fi
done

echo ""
echo ""
echo "> Changing components mode"
chmod -R 755 "${target}"
shell="$(basename $SHELL)"

case "$(basename ${SHELL})" in
	"zsh")
		shell_path="$HOME/.zshrc"
		;;
	"bash")
		shell_path="$HOME/.bashrc"
		;;
	*)
		echo "Unknown shell"
		exit 1
		;;
esac

echo "> Adding custom bin directory to path"
echo "export PATH=\$PATH:$target" >> "$shell_path"
echo ""
echo ""
printf "> Run following command to make changes effective : \n\tsource $shell_path\n\n"
