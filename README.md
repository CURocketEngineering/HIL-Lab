# SETUP INSTRUCTIONS FOR HIL

## 1. Install Ubuntu on the server

1. Download the latest **Ubuntu LTS** version. It can be either the **Desktop** or **Server** version.
2. Install Ubuntu on the server.
   **Make sure to enable SSH.**
3. Create a user account for the server which will be the main account.
4. Update the server by running the following commands:

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

## 2. Setup remote access to the server

1. Follow the instructions in the [Remote Access file](Remote-Access/README.md).

## 3. Setup GitHub Actions runner

**You will need admin access in GitHub to do this.**

1. Go to the **Settings** of the organization, then go to **Actions → Runners**, and click on the **"Add New Runner"** button.
2. Follow the instructions to add a new runner.
3. Once the runner is added, go to the **Settings** of the organization, click on **Configure**, and enable it to run on **all repositories** and on **public repositories**.
4. Make the runner start automatically after a system restart by running the following commands:

   ```bash
   ./svc.sh install
   ./svc.sh start
   ```
5. Check the status of the runner by running:

   ```bash
   ./svc.sh status
   ```

## 4. Setup the scripts

1. Go to the **Actions** tab on the repository and click on the workflows that correspond to the scripts you want to add to the server.
2. Click on the **"Run workflow"** button and wait for the workflow to complete.
3. Once it is completed, the scripts will be added to the server.
4. Finally, go into the [Show-Active-Users](Show-Active-Users/README.md) and [New-User-Creator](New-User-Creator/README.md) folders and follow the instructions in the `README.md` files to finalize the setup.

# Maintaining the server

1. To update the server, run the following command in your home directory. This will run the `update.sh` script:

   ```bash
   ./update.sh
   ```
2. Any updates to the scripts will be automatically pushed to the server upon a push to the **main** branch.

---
