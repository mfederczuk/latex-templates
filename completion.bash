# Copyright (c) 2022 Michael Federczuk
# SPDX-License-Identifier: MPL-2.0 AND Apache-2.0

# we need to define the variable outside the completion function since the function could be called from any working
# directory
__copy_latex_template_completion_templates_location_dir_path="${BASH_SOURCE[0]}"
__copy_latex_template_completion_templates_location_dir_path="$(realpath -- "$__copy_latex_template_completion_templates_location_dir_path")"
__copy_latex_template_completion_templates_location_dir_path="$(dirname -- "$__copy_latex_template_completion_templates_location_dir_path")"
__copy_latex_template_completion_templates_location_dir_path="$(realpath -- "$__copy_latex_template_completion_templates_location_dir_path/templates")"

_copy_latex_template_completion() {
	compopt +o default
	COMPREPLY=()

	case $COMP_CWORD in
		(1)
			local -a template_names=()

			local template_file_path
			for template_file_path in "$__copy_latex_template_completion_templates_location_dir_path/"*'.tex'; do
				template_names+=("$(basename -s '.tex' -- "$template_file_path")")
			done
			unset -v template_file_path

			mapfile -t COMPREPLY < <(compgen -W "--help --list ${template_names[*]}" -- "${COMP_WORDS[COMP_CWORD]}")

			unset -v template_names
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

# since the script name 'copy-template' is rather generic, it is recommended to create a symlink called something like
# 'copy-latex-template' in your '$HOME/bin' that points to the script and then manually register the completion by
# doing something like this in your '.bashrc':
#
#     . /path/to/this/completion.bash
#     complete -F _copy_latex_template_completion copy-latex-template
#
