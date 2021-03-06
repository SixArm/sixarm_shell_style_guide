# Help: use a function and HERE document

Provide help using a function and HERE document syntax such as:

    help(){
    cat << HERE
    This is my script.

    This is a good place for an explanation of the syntax,
    and examples, and explanations of any options, etc.
    HERE
    }

To show the help, one way is like this:

    if [ "$#" -ge 1 ]; then
      case "$1" in
        -h|--help)
          help; exit 0
          ;;
      esac
    fi


## Markdown

We prefer help text to use markdown formatting.

Examples:

  * For code, indent 4 spaces.

  * For options, use a bullet list: indent 2 spaces and use an asterisk,
    and use a blank line between each list item.

  * For a section headline, start a line with two hash signs "##".


## Syntax and example

If a script is a typical command, then we prefer to show the syntax and an example, like this:

    Syntax:

        foo <text> [...]

    Example:

        $ foo hello

        $ foo hello world

Note:

  * We prefer using a "$" dollar sign to indicate a typical command line prompt.


## Options

If a script has command line options, then we prefer to show them using a bullet list, like this:

    Options:

      * -h --help: 
        show this help information

      * -v --version: 
        show the command name, version number, and updated date.


## Tracking

If a script is intended for the public, then we prefer to show tracking metadata using a bullet list, like this:

    Tracking:

      * Command: my-foo-script
      * Version: 1.0.0
      * Updated: 2018-01-01
      * License: GPL
      * Contact: Alice Adams (alice@example.com)


## Tracking varaibles

If a script is intended for the public, and we want it to be professional, then we prefer to set tracking variables and print the variables in the help, like this:

    program_command="my-foo-script"
    program_version="1.0.0"
    program_updated="2016-01-11"
    program_license="GPL"
    program_contact="Alice Adams (alice@example.com)"

    help(){
    cat << EOF
    ...

    ## Tracking

      * Command: $program_command
      * Version: $program_version
      * Updated: $program_updated
      * License: $program_license
      * Contact: $program_contact

    EOF
    }

To show the help, we parse the command line options; one way is this simple code:

    if [ "$#" -ge 1 ]; then
      case "$1" in
        -h|--help)
          help; exit 0
          ;;
        -v|--version)
          out "$program_version"; exit 0
          ;;
      esac
    fi
