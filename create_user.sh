#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Prompt for username
read -p "Enter the username: " username

# Check if the username already exists
if id "$username" >/dev/null 2>&1; then
    echo "User $username already exists."
    exit 1
fi

# Prompt for password
echo -n "Enter the password: "
stty -echo
read password
stty echo
echo

# Create the user
useradd -m -s /bin/bash "$username"

# Set the password for the user
echo "$username:$password" | chpasswd

# Display the created user details
echo "User $username has been created successfully."
echo "Username: $username"
echo "Password: (hidden)"

exit 0

