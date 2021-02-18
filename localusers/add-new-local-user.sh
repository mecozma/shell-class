#!/bin/bash

# Simple script to create local users.

# Enforces to be executed as root.
UID_TO_CHECK=0
if [[ "${UID}" -ne "${UID_TO_CHECK}" ]]
then
echo "You need to run this script as root."
exit 1
fi

# Check if the user passed the right number of arguments.
if [[ "${#}" -lt 1 ]]
then
echo "${0} USER_NAME [COMMENT]..."
exit 1
fi

## Capture the parameters.
USER_NAME="${1}"
# Capture the rest of the parameters.
shift
COMMENT="${@}"

### Generate the password.
# Concat the date with random number, encript with sha256sum and return
# first 32 characters.
PASSWORD=$(date +%s%N ${RANDOM}${USER_NAME}${RANDOM} | sha256sum | head -c 32)

# Append a special character to the password.
ONE_CHAR=$(echo '!@#$%^&*()_-"' | fold -w1 | shuf | head -c1)
PASSWORD="${PASSWORD}${ONE_CHAR}"
echo "${PASSWORD}"

## Create a new user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The creation of user ${USER_NAME} has failed."
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The password for user ${USER_NAME} has failed."
  exit 1
fi

# Enforce first login password change.
passwd -e ${USER_NAME}

## Display the user, password and the host where the user has been creates.
echo -e "username:\n${USER_NAME}"
echo
echo -e "password:\n${PASSWORD}"
echo
echo -e "host:\n${HOSTNAME}"
exit 0
