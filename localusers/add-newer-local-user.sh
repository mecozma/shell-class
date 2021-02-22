#!/usr/bin/bash

# This script adds new users to the local linux system.

# The script needs to be executed with root privileges.
UID_TO_CHECK=0
if [[ "${UID}" -ne "${UID_TO_CHECK}" ]]
then
  echo "You need to execute this script as root!" >&2
  exit 1
fi

# Check if the number of arguments is less than 1.
if [[ "${#}" -lt 1 ]]
then
  echo "USAGE:" >&2
  echo "${0} USER_NAME [COMMENT]..." >&2
  exit 1
fi

# Capture the parameters.
USER_NAME="${1}"
shift
COMMENT="${@}"

# Generate the password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)
# Append a special char to the password.
ONE_CHAR=$(echo '!@#$%^&*()-_' | fold -w1 | shuf | head -c1)
PASSWORD="${PASSWORD}${ONE_CHAR}"

# Create a new user.
useradd -c "${COMMENT}" -m ${USER_NAME}
# Check if the useradd command succedded.
if [[ "${?}" -ne 0 ]]
then
  echo "The creation of the user ${USER_NAME} has failed." >&2
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
# Check if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The password for the user ${USER_NAME} has failed." >&2
  exit 1
fi

Enforce first login password change.
passwd -e ${USER_NAME}

# Display the user, the password and the host where the user has been created.
echo -e "username:\n${USER_NAME}"
echo
echo -e "password:\n${PASSWORD}"
echo
echo -e "host:\n${HOSTNAME}"
exit 0

