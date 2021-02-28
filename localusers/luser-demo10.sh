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
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

readonly VERBOSE='true'
message 'Hello!'
message 'This is fun!'
