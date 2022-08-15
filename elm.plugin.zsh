# Elm completition plugin for zsh.
# https://github.com/kraklin/elm-plugin-zsh
# v0.1.0
# Copyright (c) 2022 Tomas Latal
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

#---------------------------------------------------------------
# SETTINGS
#---------------------------------------------------------------
# this is a path where to save package names. 
# By default it uses .elm folder
ELM_PACKAGES_LIST=$HOME/.elm/packages-list

#---------------------------------------------------------------
# COMPLETION OF ELM COMMAND
#---------------------------------------------------------------

_elm_completion() {
	local si=$IFS

  if [[ -f $ELM_PACKAGES_LIST && (${words} =~ 'install' || ${words} =~ 'diff') ]] then

		# add the result of `cat packages` (npm cache) as completion options
		compadd -- $(COMP_CWORD=$((CURRENT-1)) \
			COMP_LINE=$BUFFER \
			COMP_POINT=0 \
			cat $ELM_PACKAGES_LIST -- "${words[@]}" \
			2>/dev/null)
    return
	fi

  local -a _1st_arguments
  _1st_arguments=(
    "init":"The \`init\` command helps start Elm projects"
    "repl":"The \`repl\` command opens up an interactive programming session"
    "reactor":"The \`reactor\` command starts a local server on your computer"
    "make":"The \`make\` command compiles Elm code into JS or HTML"
    "install":"The \`install\` command fetches packages from <https://package.elm-lang.org> for use in your project"
    "bump":"The \`bump\` command figures out the next version number based on API changes"
    "diff":"The \`diff\` command detects API changes"
    "publish":"The \`publish\` command publishes your package on <https://package.elm-lang.org> so that anyone in the Elm community can use it."
  )

  _arguments '*:: :->command'

  if (( CURRENT == 1 )); then
    _describe -t commands "elm commands" _1st_arguments
    return
  fi

  local -a _command_args
  case "$words[1]" in
    repl)
      _command_args=(
        '--interpreter=-[Path to a alternate JS interpreter, like node or nodejs]' \
        '--no-colors[Turn off the colors in the REPL]' \
      )
      ;;
    reactor)
      _command_args=(
        '--port=-[The port of the server (default:8000)]' \
      )
      ;;
    make)
      _command_args=(
        '--debug[turn on time-traveling debugger]' \
        '--optimize[turn on optimizations]' \
        '--report=-[specify report type]::(json)' \
        '--docs=-[generate JSON file of documentation for package]' \
        '--output=-[name of resulting JS file]:::_files' \
        '*:Elm file:_files -g "*.elm"'

      )
      ;;

    esac

  _arguments \
    $_command_args \
    '--help[print help]' \
    &&  return 0

	IFS=$si
}

compdef _elm_completion 'elm'

#---------------------------------------------------------------
# CUSTOM FUNCTIONS
#---------------------------------------------------------------


# elm-completion-update
#  
# This function updates local list of available packages

elm-completion-update(){
    curl --compressed https://package.elm-lang.org/search.json | grep -o '\"name\":\"\([A-Za-z\/\-]*\)\"' | sed -e 's/\"//g; s/\(name\:\)//' > $ELM_PACKAGES_LIST
}

