#/bin/sh
set -euf

## Program Tracking

program_command="sixarm-shell-style-guide-demo"
program_version="5.0.0"
program_updated="2018-06-16"
program_license="GPL"
program_contact="Alice Adams (alice@example.com)"

## Help Function

help(){
cat << EOF

SixArm shell style guide demo

Syntax:

    sixarm-shell-style-guide-demo.sh

Example:

    sixarm-shell-style-guide-demo --version


## Options

  * --foo=<value>:
      set the foo variable to a value

  * --goo=<value>:
      set the goo variable to a value

  * -h --help: 
      print helpful information

  * -v --version: 
      print the program version number

  * --log-dir:
      print the log directory path

  * --log-home:
      print the log home path

  * --data-dir:
      print the data directory path

  * --data-home:
      print the data home path

  * --cache-dir:
      print the cache directory path

  * --cache-home:
      print the cache home path

  * --config-dir:
      print the configuration directory path

  * --config-home:
      print the configuration home path

  * --runtime-dir:
      print the runtime directory path

  * --runtime-home:
      print the runtime directory path

  * --temp-dir:
      print the temporary directory path

  * --program-command:
      print the program command name

  * --program-version:
      print the program version number

  * --program-updated:
      print the program updated date

  * --program-license:
      print the program license name

  * --program-contact:
      print the program contact information for the maintainer


## Tracking

  * Command: $program_command
  * Version: $program_version
  * Updated: $program_updated
  * License: $program_license
  * Contact: $program_contact
EOF
}

out() { printf %s\\n "$*" ; }; export -f out
err() { >&2 printf %s\\n "$*" ; }; export -f err
die() { >&2 printf %s\\n "$*" ; exit 1 ; }; export -f die
big() { printf \\n###\\n#\\n#\ %s\\n#\\n###\\n\\n "$*"; }; export -f big
log() { printf '%s %s %s\n' "$( now )" $$ "$*" ; }; export -f log
now() { date -u "+%Y-%m-%dT%H:%M:%S.%N+00:00" ; }; export -f now
sec() { date "+%s" ; }; export -f sec
zid() { hexdump -n 16 -v -e '16/1 "%02x" "\n"' /dev/random ; }; export -f zid
cmd() { command -v "$1" >/dev/null 2>&1 ; }; export -f cmd
dir() { CDPATH= cd -- "$(dirname -- "$0")" && pwd -P ; }
exe() { [ -d "$1" ] && find "$1" -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \) -exec test -x {} \; -exec {} \; ; }
int() { printf -v int '%d\n' "$1" 2>/dev/null ; }; export -f int

## Number helpers
int() { awk '{ print int($1) }' ; }; export -f int
sum() { awk '{for(i=1; i<=NF; i++) sum+=$i; } END {print sum}' ; }; export -f sum

## Array helpers: array index and array number of fields
array_i() { [ $# == 3 ] && awk -F "$2" "{print \$$3}" <<< "$1" || awk "{print \$$2}" <<< "$1" ; }; export -f array_i
array_n() { [ $# == 2 ] && awk -F "$2" "{print NF}"   <<< "$1" || awk "{print NF}"   <<< "$1" ; }; export -f array_n

## Home helpers
log_home() { out "${LOG_HOME:=$HOME/.log}" ; }; export -f log_home;
data_home() { out "${XDG_DATA_HOME:=$HOME/.local/share}" ; }; export -f data_home;
cache_home() { out "${XDG_CACHE_HOME:=$HOME/.cache}" ; }; export -f cache_home;
config_home() { out "${XDG_CONFIG_HOME:-$HOME/.config}" ; }; export -f config_home;
runtime_home() { out "${XDG_RUNTIME_HOME:=$HOME/.runtime}" ; }; export -f runtime_home;
temp_home() { out $(mktemp -d -t "${1:-$(zid)}"); }; export -f temp_home;

## Directory helpers
log_dir() { out $(log_home)"/$program_command" ; };
data_dir() { out $(data_home)"/$program_command" ; };
cache_dir() { out $(cache_home)"/$program_command" ; }; 
config_dir() { out $(config_home)"/$program_command" ; }; 
runtime_dir() { out $(runtime_home)"/$program_command" ; }; 
temp_dir() { out $(temp_home "$program_command"); };

## Assert helpers
assert_empty() { [ -z "$1" ] || err $FUNCNAME "$@" ; }
assert_equal() { [ "$1" = "$2" ] || err $FUNCNAME "$@" ; }
assert_match() { [[ "$2" =~ $1 ]] || err $FUNCNAME "$@" ; }

## Verify a command executable, a script variable, and an env variable
#CURL=${CURL:-curl}; cmd "$CURL" || die_cmd "$CURL"
#foo="${1:-}"; [ -z "$foo" ] && die_var foo
#[ -z ${BAR+x} ] && die_var BAR

if [ "$#" -eq 1 ]; then
  case "$1" in
    -h|--help)
      help; exit 0
      ;;
    -v|--version)
      out $program_version; exit 0
      ;;
    --program-command)
      out $program_command; exit 0
      ;;
    --program-version)
      out $program_version; exit 0
      ;;
    --program-updated)
      out $program_version; exit 0
      ;;
    --program-license)
      out $program_license; exit 0
      ;;
    --program-contact)
      out $program_contact; exit 0
      ;;
    --log-dir)
      out "$(log_dir)"; exit 0
      ;;
    --log-home)
      out "$(log_home)"; exit 0
      ;;
    --data-dir)
      out "$(data_dir)"; exit 0
      ;;
    --data-home)
      out "$(data_home)"; exit 0
      ;;
    --cache-dir)
      out "$(cache_dir)"; exit 0
      ;;
    --cache-home)
      out "$(cache_home)"; exit 0
      ;;
    --config-dir)
      out "$(config_home)"; exit 0
      ;;
    --config-home)
      out "$(config_home)"; exit 0
      ;;
    --runtime-dir)
      out "$(config_home)"; exit 0
      ;;
    --runtime-home)
      out "$(config_home)"; exit 0
      ;;
    --temp-dir)
      out "$(temp_dir)"; exit 0
      ;;
    --*=*)
      key="${1#--}"; key="${key%%=*}";
      val="${1#*=}";
      eval "$key"=\$val
      ;;
  esac
fi
