
---

# Remote Access Setup Using DuckDNS and Clemson VPN

This guide explains how to set up remote SSH access to your local server using a Dynamic DNS (DDNS) service such as DuckDNS. It also includes instructions to automatically update your public IP address so you can reliably connect even if it changes.

---

## Overview

1. **DuckDNS** (or another DDNS provider) assigns your home server a persistent domain name (for example, `example.duckdns.org`).
2. **Cron** and **curl** automatically keep your DuckDNS record updated with your current public IP address.
3. **Clemson VPN** allows secure remote access when off-campus.
4. **SSH** provides a secure connection to the server 

---

## Step 1: Set Up a DuckDNS Domain

1. Go to [https://www.duckdns.org](https://www.duckdns.org)
2. Log in using a supported account (GitHub, Google, etc.).
3. Create a new subdomain, for example:

   ```
   example.duckdns.org
   ```
4. Copy your **token** — you will need it for the update script.

---

## Step 2: Install Dependencies

Make sure both `curl` and `cron` are installed on your server:

```bash
sudo apt update
sudo apt install curl cron -y
```

---

## Step 3: Set Up DuckDNS Update Script

1. Create a new directory for DuckDNS:

   ```bash
   mkdir -p ~/duckdns
   cd ~/duckdns
   ```

2. Create the update script:

   ```bash
   nano duck.sh
   ```

3. Paste the following code (replace with your DuckDNS domain and token):

   ```bash
   echo "url=https://www.duckdns.org/update?domains=example&token=YOUR_TOKEN&ip=" | curl -k -o ~/duckdns/duck.log -K -
   ```

4. Save and make it executable:

   ```bash
   chmod 700 ~/duckdns/duck.sh
   ```

---

## Step 4: Schedule Automatic Updates with Cron

Edit your crontab to run the update automatically:

```bash
crontab -e
```

Add these lines at the bottom:

```
*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
@reboot ~/duckdns/duck.sh >/dev/null 2>&1
```

This will:

* Run the DuckDNS update every 5 minutes.
* Run it once at boot to immediately refresh your IP.

To verify it’s running:

```bash
cat ~/duckdns/duck.log
```

---

## Step 5: Connect via SSH

Once set up, you can SSH into your server using your DuckDNS address:

```bash
ssh user@example.duckdns.org
```

Replace `user` with your server’s username.

---

## Step 6: Remote Access via Clemson VPN

When off-campus, use Clemson’s Cisco VPN (the same one used for iRoar and other Clemson services):

1. Connect to the Clemson VPN using Cisco AnyConnect.
2. After connecting, SSH into your server the same way as before:

   ```bash
   ssh user@example.duckdns.org
   ```

---

## Optional: Use DuckDNS Docker Container Instead of the Script

DuckDNS also provides an official Docker container that handles automatic IP updates.
You can find the docker image here:
[DuckDNS Docker Image](https://hub.docker.com/r/linuxserver/duckdns)

---
