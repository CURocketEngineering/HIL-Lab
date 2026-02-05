#!/bin/bash

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use sudo."
   exit 1
fi

echo "Creating a new user account..."

# Loop until a valid username is entered
while true; do
    read -rp "Enter a username (letters, numbers, underscores, dashes): " newuser

    # Validate username
    if [[ ! "$newuser" =~ ^[A-Za-z_][A-Za-z0-9_-]*$ ]]; then
        echo "Invalid username. Use only letters, numbers, underscores, or dashes."
        continue
    fi

    # Check if user already exists
    if id "$newuser" &>/dev/null; then
        echo "User '$newuser' already exists!"
        continue
    fi

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
        echo "Passwords do not match. Try again."
    fi
done

# Create the user with home directory and groups
useradd -m -s /bin/bash -G plugdev,dialout,video,audio,input "$newuser"


# Set the password safely
echo "$newuser:$password" | chpasswd

# Verify password was set
if [ $? -eq 0 ]; then
    echo "Password set successfully."
else
    echo "Failed to set password! You may need to run 'sudo passwd $newuser'"
fi

# Completion messages
echo "User '$newuser' has been created."
echo "Home directory: /home/$newuser"
echo "You can now SSH using: ssh $newuser@curehil.duckdns.org"

exit 0
