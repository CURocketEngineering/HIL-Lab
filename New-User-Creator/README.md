## Login User Setup

This guide explains how to set up a special user named **`login`** that automatically runs a user-creation script whenever it is accessed.

---

### 1. Create the `login` User

```bash
sudo adduser login
```

Make the `login` user a sudoer:

```bash
sudo usermod -aG sudo login
```

Then run:

```bash
sudo visudo
```

Add the following line at the bottom, replacing `user` with the name of the user that is running the GitHub runner:

```bash
user ALL=(ALL) NOPASSWD: /usr/bin/cp, /usr/bin/chmod
```

---

### 2. Edit the `.bashrc` File

Open the file:

```bash
sudo nano /home/login/.bashrc
```

At the **bottom** of the file, paste the code from the **bashrc.sh** script:

```bash
echo "Type 'create' to create a new user account, or 'exit' to log out."
read input
if [ "$input" == "create" ]; then
    /usr/local/bin/create_user.sh
    exit
else
    echo "Goodbye!"
    exit
fi
```

Save and exit.

---

### 3. Install the `create_user.sh` Script

Place your script in:

```bash
sudo nano /usr/local/bin/create_user.sh
```

Make it executable:

```bash
sudo chmod +x /usr/local/bin/create_user.sh
```

---

### 4. Grant Permissions

Allow the `login` user to run the script and user-management commands without a password:

```bash
sudo visudo
```

Add the following line at the bottom:

```bash
login ALL=(root) NOPASSWD: /usr/local/bin/create_user.sh, /usr/sbin/adduser, /usr/sbin/chpasswd
```

Save and exit.

---

### 5. How to Delete a User if Needed

To remove a user and their home directory:

```bash
sudo deluser --remove-home username
```

---

### 6. Access the `login` User

Switch to the `login` account:

```bash
sudo -i
cd /home/login
```

Whenever the `login` user is accessed, the `create_user.sh` script will run automatically.

---
