#!/bin/bash

echo "Creating a new user account..."

# Loop until a valid username is entered
echo "Enter a username (only letters, numbers, underscores, or dashes):"
while true; do
    read -rp "Please Enter a new username: " newuser

    # Check username (allowing lowercase, uppercase, numbers, underscores, and dashes)
    if [[ ! "$newuser" =~ ^[A-Za-z_][A-Za-z0-9_-]*$ ]]; then
        echo "Invalid username. Use only letters, numbers, underscores, or dashes."
        continue
    fi

    # Check if user already exists
    if id "$newuser" &>/dev/null; then
        echo "User '$newuser' already exists!"
        continue
    fi

    # If both checks pass, break out of loop
    break
done

# Loop until passwords match
while true; do
    read -rsp "Enter a password for $newuser: " password
    echo
    read -rsp "Confirm password: " password2
    echo

    if [[ "$password" == "$password2" ]]; then
        break
    else
        echo "Passwords do not match. Please try again."
    fi
done

# Create user with USB-related group access
sudo adduser --disabled-password --gecos "" \
  --groups plugdev,dialout,video,audio,input \
  "$newuser" &>/dev/null

# Set the entered password
echo "$newuser:$password" | sudo chpasswd

# Completion messages
echo "User '$newuser' has been created."
echo "Password has been set by the user."
echo "Home directory: /home/$newuser"
echo "You can now SSH using: ssh $newuser@clemsoncure.duckdns.org"

exit
