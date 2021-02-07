#!/bin/bash

# A script that adds users to the same Linux system as the script is executed on.

# Make sure the script is being executed with superuser privileges.
UID_TO_TEST_FOR=0
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "You don't have superuser privileges."
  exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' USER_NAME

# Get the real name (contents for the description field).
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Get the password.
read -p "Enter the password for the ${USER_NAME} account: " PASSWORD

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The creation of user ${USER_NAME} has failed."
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The password for user: ${USER_NAME} has not been set."
  exit 1
fi

# Force password to change on first login.
passwd -e ${USER_NAME}

# Display the username, password and the host where the user was created.
echo " The ${USER_NAME} with the passwd ${PASSWORD} has been created on ${HOSTNAME}."
exit 0
