#!/bin/bash

# Generates a list of random passwords.

# A random number as a password.
PASSWORD="${RANDOM}"
echo "Random: ${PASSWORD}"

# Three random numbers together.
PASSWORD="${PASSWORD}${PASSWORD}${PASSWORD}"
echo "Random X3: ${PASSWORD}"

# Generate a password using the current date/time to act as randomization.
PASSWORD=$(date +%s)
echo "Date: ${PASSWORD}"

# Generate a pasword using the nanoseconds to act as randomization.
PASSWORD=$(date +%s%N)
echo "Date + Nanoseconds: ${PASSWORD}"

# Generate a pssword containing the first 8 characters of the date encripted
# with sha256sum.
PASSWORD=$(date +"%s%N" | sha256sum | head -c 32)
echo "Sha256: ${PASSWORD}"

# An even better password.
PASSWORD=$(date +%s%N ${RANDOM}${RANDOM}${RANDOM} | sha256sum | head -c 48)
echo "Sha256 + RANDOM: ${PASSWORD}"

# Append a special character to the password.
ONE_CHAR=$(echo '!@#$%^&*()-_' | fold -w1 | shuf | head -c1)
echo "Special char: ${PASSWORD}${ONE_CHAR}"
