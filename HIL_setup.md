## Tunnel Setup Instructions

### 1. Raspberry Pi Initial Setup

#### 1.1. Connect Raspberry Pi to internet  
#### 1.2. Enable ssh

```bash
sudo raspi-config
```

### 2. Installations

#### 2.1. Install updates

```bash
sudo apt update
sudo apt upgrade
```

#### 2.2. Install Cloudflared

```bash
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb -o cloudflared.deb
sudo dpkg -i cloudflared.deb
```

### 3. Tunnel Initialization

#### 3.1. Authenticate Cloudflare Tunnel
```bash
cloudflared tunnel login
```

#### 3.2. Create New Tunnel
```bash
cloudflared tunnel create HILx
```

#### 3.3 Configure Tunnel
```bash
sudo mkdir -p /etc/cloudflared
sudo nano /etc/cloudflared/config.yml
```

Add the following content to the `config.yml`
```yaml
tunnel: HIL2
credentials-file: /home/pi/.cloudflared/<tunnelID>.json

ingress:
  - hostname: hilx.ethananderson.dev
    service: ssh://localhost:22
  - service: http_status:404

```

#### 3.4 Add a CNAME entry to the DNS

- Visit [dash.cloudflare.com](https://dash.cloudflare.com/)
- Navigate to **DNS** on the left-hand sidebar
- Click "Add Record"
- Set Type as "CNAME"
- Set Name as "hilx"
- Set Target as `<tunnelID>.cfargotunnel.com`



### 4. Running the Tunnel

#### 4.1. Run the Tunnel
```bash
cloudflared tunnel run HILx
```

#### 4.2. Set up Automatic Tunnel on Boot
```bash
sudo cloudflared service install
sudo systemctl enable cloudflared
```

#### 4.3. Add another SSH Config Entry on Host Device
```bash
Host hilx.ethananderson.dev
  ProxyCommand /usr/bin/cloudflared access ssh --hostname %h

```

### 5 Configuring the login Setup

How to configure the `login` user for easily creating account on the HIL. 

### 5.1 Create account when connecting as login 

Add the following to `/home/login/.bashrc`

```bash
echo "Type 'create' to create a new user account, or 'exit' to log out."
read input
if [ "$input" == "create" ]; then
    /usr/local/bin/create_user.sh
else
    echo "Goodbye!"
    exit
fi
```

### 5.2 Add the `create_user.sh` script

Put the following into a file at `/usr/local/bin/create_user.sh`

```bash
#!/bin/bash

echo "Creating a new user account..."
read -p "Enter a username: " newuser
if id "$newuser" &>/dev/null; then
    echo "User $newuser already exists!"
else
    sudo adduser --disabled-password --gecos "" $newuser
    echo "$newuser:clemson" | sudo chpasswd
    echo "User $newuser has been created with a home directory."
    echo "You can now SSH using $newuser@hil1"
fi
```
