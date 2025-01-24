## Running a Windows Server 2025 VM in Proxmox VE

- [ ] Log into the Proxmox web UI
- [ ] Select a storage from the left navigation pane to download the .iso to
- [ ] Select ISO Images in the left sub-navigation pane
- [ ] If running Proxmox 6, download the Server 2025 iso Download and the VirtIO driver iso Download and upload them both to the Proxmox ISO image library
- [ ] If on Proxmox 7, click Download from URL and paste the download URLs from above > Click Query URL > Click Download
- [ ] Check the presence of the 2 ISOs in Proxmox storage  > use the link below
- [ ] Right click the Proxmox node name > Create VM
- [ ] Give the VM a unique ID and Name > Next
- [ ] Set the Type to Microsoft Windows and Version to 11/2022 and select the Server 2025 iso, Check the box for VirtIO drivers > select the VirtIO driver iso
- [ ] On the System tab, set the BIOS to SeaBIOS, Choose to enable/disable TPM and set the TPM Storage device, Check the Qemu Agent box and set the SCSI Controller to VirtIO SCSI > Next
- [ ] On the Disks tab, set the Storage device and Disk size to at least 30GB, Bus/Device to VirtIO Block and Cache to Write back > Next
- [ ] On the CPU tab, set Cores to 2 or more and the Type to host > Next
- [ ] On the Memory tab, set the Memory to 8192 or more and minimum Memory to 4096 or more > Next
- [ ] Leave the defaults on the Network tab | or use the good one (in my case i've got 2 virtual port (vmbr0 and vmbr1)) > Next
- [ ] Verify the summary and click Finish
- [ ] Select the Server 2025 VM > Hardware
- [ ] Click the Add dropdown > CD/DVD Drive
- [ ] Double click the new CD/DVD Drive > Select Use CD/DVD disc image file (iso) > Select the storage where the VirtIO driver iso was - [ ] downloaded > Select the virtio .iso file > Click OK
- [ ] Right click the Server 2025 VM in the left navigation pane > Start
- [ ] Click console in the left sub-navigation menu
- [ ] If prompted, press a key to boot to the CD/DVD drive
- [ ] Set the Language settings > Click Next
- [ ] Set the Keyboard settings > Click Next
- [ ] Click the I agree everything will be deleted checkbox > Click Next
- [ ] Enter a product key or select I don't have a product key > Click Next
- [ ] Select the desired edition > Click Next
- [ ] On the License Terms screen click Accept
- [ ] Click Load Driver > Browse > Expand the VirtIO driver disc > Navigate to amd64\2k22 > Click OK > Next
- [ ] With the Unallocated Space selected, click Next
- [ ] Click Install
- [ ] Wait for Windows to copy files, the VM will reboot several times
- [ ] If prompted, enter a Product Key or click Do this later
- [ ] Enter and confirm a password for the Administrator account > Click Finish
- [ ] Select the Keyboard icon > Ctrl-Alt-Del
- [ ] Input the administrator password and login
- [ ] Welcome to Windows Server 2025

--- 

## After Installation Steps

- [ ] Open File Explorer > Navigate into the VirtIO Disc > Right click virtio-win-guest-tools.exe > Run as administrator
- [ ] Step through the installer, accepting all the defaults
- [ ] After the installation completes shutdown the VM
- [ ] Back in the Proxmox web UI, select Hardware from the left sub-navigation menu
- [ ] Select the CD/DVD drive with the VirtIO iso attached > Remove > Yes
- [ ] Double click the remaining CD/DVD drive > Select Do not use any media > Click OK
- [ ] Click Start at the top right of the screen restart the VM
- [ ] Click console in the left sub-navigation menu
- [ ] Do Not Forget to do the Windows Update in the Settings


---

## Useful link
- [ ] Windows 2025 fr iso : https://go.microsoft.com/fwlink/?linkid=2273506 or https://www.microsoft.com/fr-fr/evalcenter/evaluate-windows-server-2025
- [ ] VirtIo Win iso : https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers or https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso 