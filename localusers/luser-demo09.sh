#!/usr/bin/bash

# This script demonstrates the case statement.

# if [[ "${1}" = 'Start' ]]
# then
#   echo 'It is starting!'
# elif [[ "${1}" = 'Stop' ]]
# then
#   echo "It is stopping."
# elif [[ "${1}" = 'Status' ]]
# then
#   echo 'Status:'
# else
#  echo 'Supply a valid option.' >&2
#  exit 1
# fi

# case "${1}" in
#   start)
#   echo 'Starting.'
#   ;;
#   stop)
#   echo 'Stopping.'
#   ;;
#   status|state|--status|--state)
#   echo 'Status:'
#   ;;
#   *)
#   echo 'Supply a valid option.' >&2
#   exit 1
#   ;;
# esac

case "${1}" in
  start) echo 'Starting.' ;;
  stop) echo 'Stopping.' ;;
  status) echo 'Status:' ;;
  *)
  echo 'Supply a valid option.' >&2
  exit 1
  ;;
esac
