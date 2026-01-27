
---

## Active Sessions Script Setup

This script displays a custom welcome message when users log in, showing:

* Who is connected
* When they connected
* How long they’ve been connected
* Whether they are idle

It replaces the default **message of the day (MOTD)** with custom information.

---

### 1. Copy the Script

Copy the script from GitHub into:

```bash
sudo nano /etc/profile.d/active-sessions.sh
```

Paste the script, then save and exit.

---

### 2. Make It Executable

```bash
sudo chmod +x /etc/profile.d/active-sessions.sh
```

---

### 3. Disable the Default MOTD

To hide the default login message:

```bash
sudo chmod -x /etc/update-motd.d/*
```

To re-enable it later if needed:

```bash
sudo chmod +x /etc/update-motd.d/*
```

---

### 4. Set the Time Zone

Set your system to the Eastern Time zone:

```bash
sudo timedatectl set-timezone America/New_York
```

---

### 5. Edit or Remove the Script

To edit:

```bash
sudo nano /etc/profile.d/active-sessions.sh
```

To delete:

```bash
sudo rm /etc/profile.d/active-sessions.sh
```

---
