
---

## System Update Script

You can place this script anywhere on the server, but it’s recommended to keep it in your home directory for easy access.

The script may take some time to run. It’s designed to show minimal output and will only print messages when each step is complete.

### Make the script executable

```bash
sudo chmod +x ~/update.sh
```

### Run the script

```bash
sudo ./update.sh
```

Wait for the script to finish. It will:

* Update all packages
* Apply updates
* Remove old or unnecessary packages

---

## Schedule Automatic Updates with Cron

To make the script run automatically, edit your crontab:

```bash
crontab -e
```

Add one of the following lines depending on how often you want it to run:

* **Daily at midnight**

  ```
  0 0 * * * ~/update.sh >/dev/null 2>&1
  ```
* **Weekly (every Sunday at midnight)**

  ```
  0 0 * * 0 ~/update.sh >/dev/null 2>&1
  ```

Save and exit the editor. Cron will now automatically run the update script on the chosen schedule.

---
