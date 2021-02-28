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

backup_file() {
  # This function creates a backupf of a file. Returns non-zero status on error.
  local FILE="${1}"

  # Make sure the file exists.
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    message "Backing up ${FILE} to ${BACKUP_FILE}."

  # The exit status of the function will be the status of the cp command. 
    cp -p ${FILE} ${BACKUP_FILE}
  else
    # The file does not exist, so return a non-zero exit status.
    return 1
  fi
}

readonly VERBOSE='true'
message 'Hello!'
message 'This is fun!'

backup_file '/etc/passwd'


# Make a decision based on the exit status of the function.
if [[ "${?}" -eq '0' ]]
then
  message 'File backup succeeded!'
else
  message 'File backup failes!'
  exit 1
fi
