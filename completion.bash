# Copyright (c) 2023 Michael Federczuk
# SPDX-License-Identifier: MPL-2.0 AND Apache-2.0

__copy_latex_template_completion__print_xdg_data_home_pathname() {
	# <https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html>

	if [[ "${XDG_DATA_HOME-}" =~ ^'/' ]]; then
		# only absolute pathnames are valid
		printf '%s' "$XDG_DATA_HOME"
		return
	fi

	if [[ "${HOME-}" =~ ^'/' ]]; then
		printf '%s/.local/share' "$HOME"
		return
	fi
}

__copy_latex_template_completion__print_valid_standard_templates_dir_pathname() {
	local xdg_data_home_pathname || return
	xdg_data_home_pathname="$(__copy_latex_template_completion__print_xdg_data_home_pathname && printf x)" || return
	xdg_data_home_pathname="${xdg_data_home_pathname%"x"}" || return
	readonly xdg_data_home_pathname || return

	if [ -z "$xdg_data_home_pathname" ]; then
		return
	fi

	standard_templates_dir_pathname="$xdg_data_home_pathname/latex-templates/templates"
	readonly standard_templates_dir_pathname

	if [ -e "$standard_templates_dir_pathname" ] && [ ! -d "$standard_templates_dir_pathname" ]; then
		return
	fi

	printf '%s' "$standard_templates_dir_pathname"
}

_copy_latex_template_completion() {
	compopt +o default || return
	COMPREPLY=() || return

	case $COMP_CWORD in
		(1)
			local standard_templates_dir_pathname || return
			standard_templates_dir_pathname="$(__copy_latex_template_completion__print_valid_standard_templates_dir_pathname)" || return
			readonly standard_templates_dir_pathname || return

			if [ -z "$standard_templates_dir_pathname" ]; then
				return
			fi

			local -a template_names || return
			template_names=() || return

			local template_file_pathname || return
			for template_file_pathname in "$standard_templates_dir_pathname/"*'.tex'; do
				local template_name || return
				template_name="$template_file_pathname" || return
				template_name="$(basename -- "$template_name")" || return
				template_name="${template_name%".tex"}" || return

				template_names+=("$template_name") || return

				unset -v template_name || return
			done
			unset -v template_file_pathname || return

			mapfile -t COMPREPLY < <(compgen -W "--help --list ${template_names[*]}" -- "${COMP_WORDS[COMP_CWORD]}")

			unset -v template_names || return
			;;
		(2)
			case "${COMP_WORDS[1]}" in
				('--help'|'--list') ;;
				(*)
					# <https://stackoverflow.com/a/19062943/9581962>
					compopt -o default
					;;
			esac
			;;
	esac
}

# since the script name 'copy-template' is rather generic, it is recommended to name it something
# like 'copy-latex-template' when installing it into your $PATH and then manually register the completion by
# doing something like this in your '.bashrc':
#
#     . /path/to/this/completion.bash
#     complete -F _copy_latex_template_completion copy-latex-template
#
