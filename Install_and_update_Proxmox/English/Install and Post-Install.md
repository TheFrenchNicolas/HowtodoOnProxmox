

# **Guide to Installing and Configuring a Proxmox Server**

Proxmox VE (Virtual Environment) is an open-source server virtualization platform that combines KVM (Kernel-based Virtual Machine) for virtual machines and LXC (Linux Containers) for lightweight container-based virtualization.

---

## **1. Prerequisites**
Before you begin, ensure you have the following:
- A dedicated server or PC with hardware virtualization support (Intel VT-x/AMD-V).
- At least 4GB of RAM (8GB or more recommended for production use).
- A multi-core CPU (the more cores, the better for running multiple VMs/containers).
- A minimum of 50GB of storage (SSD recommended for better performance).
- A stable internet connection.
- A USB drive (for the Proxmox installation media).
- A monitor and keyboard (for initial setup, unless you’re using IPMI or remote access).

---

## **2. Download Proxmox VE ISO**
1. Visit the official Proxmox website: [https://www.proxmox.com/en/downloads](https://www.proxmox.com/en/downloads).
2. Download the latest Proxmox VE ISO file.
3. Use a tool like [Rufus](https://rufus.ie/) (Windows) or `dd` (Linux) to create a bootable USB drive with the ISO.

---

## **3. Install Proxmox VE**
1. **Boot from USB**:
   - Insert the USB drive into your server.
   - Boot the server and enter the BIOS/UEFI settings to set the USB drive as the primary boot device.
   - Save changes and reboot.

2. **Start Installation**:
   - Select "Install Proxmox VE" from the boot menu.
   - Accept the End User License Agreement (EULA).

3. **Configure Disk**:
   - Select the target disk for installation.
   - Choose a file system (ext4, XFS, or ZFS). ZFS is recommended for advanced features like snapshots and redundancy, but it requires more RAM.

4. **Set Up Network**:
   - Configure the hostname (e.g., `proxmox.example.com`).
   - Enter the IP address, subnet mask, gateway, and DNS server. Ensure the IP is static for reliable access.

5. **Set Password**:
   - Create a strong password for the `root` user.

6. **Complete Installation**:
   - Confirm the installation settings and proceed.
   - Once installed, remove the USB drive and reboot the server.

---

## **4. Access the Proxmox Web Interface**
1. After reboot, note the URL displayed on the screen (e.g., `https://<IP>:8006`).
2. Open a web browser and navigate to the provided URL.
3. Log in with the username `root` and the password you set during installation.

---

## **5. Initial Configuration**
### **5.1. Update Proxmox**
1. Open the web interface and navigate to the shell (via the "Shell" tab or SSH).
2. Run the following commands to update the system:
   ```bash
   apt update
   apt upgrade -y
   apt dist-upgrade -y
   ```
3. Reboot the server if necessary.

### **5.2. Configure Storage**
1. Add additional storage (if available):
   - Go to "Datacenter" > "Storage" > "Add".
   - Choose the type of storage (e.g., Directory, LVM, ZFS, NFS, etc.).
   - Follow the prompts to configure the storage.

2. Set up a backup location (optional but recommended).

### **5.3. Configure Networking**
1. Add additional network interfaces or VLANs if needed:
   - Go to "Datacenter" > "Network" > "Create".
   - Configure bridges, bonds, or VLANs as required.

2. Ensure the firewall is configured properly:
   - Go to "Datacenter" > "Firewall" > "Options".
   - Enable or disable the firewall as needed.

### **5.4. Add a Subscription Key (Optional)**
- Proxmox is free to use, but a subscription provides access to the enterprise repository and support.
- To add a subscription key, go to "Datacenter" > "Subscription" > "Enter Key".

### **5.5. Disable Update Subscription (Optional)**
1. In the "Shell" tab, to disable subscription, run the following commands:
``` bash
sed -i 's/^deb/#deb/g' /etc/apt/sources.list.d/pve-enterprise.list
```
2. To add the non-subsription repository, run the following commands:
```bash
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
apt update && apt upgrade -y
```


---

## **6. Create Virtual Machines (VMs) and Containers**
### **6.1. Create a VM**
1. Go to the "Create VM" button in the top-right corner.
2. Follow the wizard to:
   - Select an OS ISO (upload it to the storage first if needed).
   - Allocate CPU, RAM, and disk space.
   - Configure network settings.
3. Start the VM and install the OS.

### **6.2. Create an LXC Container**
1. Go to the "Create CT" button in the top-right corner.
2. Follow the wizard to:
   - Select a template (download from the "Templates" section if needed).
   - Allocate resources.
   - Configure network settings.
3. Start the container and configure it as needed.

---

## **7. Backup and Restore**
1. Set up regular backups:
   - Go to "Datacenter" > "Backup" > "Add".
   - Configure the backup schedule and storage location.
2. Test restoring a VM or container to ensure backups are working.

---

## **8. Advanced Configuration (Optional)**
### **8.1. High Availability (HA)**
- Set up a Proxmox cluster for HA:
  1. Go to "Datacenter" > "Cluster" > "Create Cluster".
  2. Add additional nodes to the cluster.
  3. Configure HA for critical VMs/containers.

### **8.2. ZFS Configuration**
- If using ZFS, configure RAID-Z or mirroring for redundancy:
  1. Go to "Datacenter" > "Storage" > "Add" > "ZFS".
  2. Follow the prompts to set up the ZFS pool.

### **8.3. SSL Certificates**
- Replace the default self-signed certificate with a trusted one:
  1. Go to "Datacenter" > "Certificates" > "Upload".
  2. Upload your certificate and private key.

---

## **9. Maintenance and Monitoring**
- Regularly check for updates and apply them.
- Monitor resource usage via the web interface or tools like Grafana.
- Set up email notifications for critical alerts:
  - Go to "Datacenter" > "Notifications" > "Add".

---

## **10. Troubleshooting**
- **Can’t access the web interface?** Check the IP configuration and firewall settings.
- **VM/Container not starting?** Verify resource allocation and logs.
- **Network issues?** Ensure the bridge and VLAN configurations are correct.

---

By following this guide, you should have a fully functional Proxmox server ready to host VMs and containers. Proxmox is a powerful tool, so take time to explore its features and optimize it for your specific use case. Happy virtualizing!