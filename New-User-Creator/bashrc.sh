echo "Type 'create' to create a new user account, or 'exit' to log out."
read input
if [ "$input" == "create" ]; then
    sudo /usr/local/bin/create_user.sh
    exit
else
    echo "Goodbye!"
    exit
fi