#!/usr/bin/bash

# A function to log a message.
log() {
  echo 'You called the log function!'
}

log

function logs {
  echo 'You called the logs function!'
}

logs

# Passing arguments to functions.
message() {
 # This function sends a message to syslog and to standard output
 # if VERBOSE is true.
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

readonly VERBOSE='true'
message 'Hello!'
message 'This is fun!'
