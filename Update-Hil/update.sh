#!/bin/bash

echo "Updating package lists..."
sudo -S apt update -y > /dev/null 2>&1 && echo "Package lists updated."

echo "Upgrading system packages..."
sudo -S apt upgrade -y > /dev/null 2>&1 && echo "System packages upgraded."

echo "Performing full upgrade..."
sudo -S apt full-upgrade -y > /dev/null 2>&1 && echo "Full upgrade done."

echo "Removing unnecessary packages..."
sudo -S apt autoremove -y > /dev/null 2>&1 && echo "Unnecessary packages removed."

