resetfile() {
	git checkout origin/master -- $1
}
_resetfile() { # Autocomplete function definition
  _arguments \
    '1: :_files'  # Use _files to autocomplete arbitrary strings as file/directory names
}
compdef _resetfile resetfile