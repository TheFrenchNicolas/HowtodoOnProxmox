
# Guide d'Installation d'une VM Windows 2025 sous Proxmox

## Prérequis
- Un serveur Proxmox VE fonctionnel.
- Une image ISO de Windows 2025 (téléchargeable depuis le site officiel de [Microsoft](https://www.microsoft.com/fr-fr/evalcenter/evaluate-windows-server-2025)).
- Une image ISO des drivers VirtIO (téléchargeable depuis [ici](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/)).
- Un stockage suffisant pour la VM.
- Un accès à l'interface web de Proxmox.
- Documentation officielle Proxmox : [Proxmox Wiki](https://pve.proxmox.com/wiki/Main_Page).

## 1. Téléchargement et Ajout des ISOs
1. Accéder à l’interface web de Proxmox : `https://<adresse-IP>:8006`.
2. Aller dans **Datacenter** > **Node** > **Local (pve)** > **ISO Images**.
3. Cliquer sur **Upload** et sélectionner l’ISO de Windows 2025.
4. Répéter l'opération pour l’ISO des drivers VirtIO.

## 2. Création de la Machine Virtuelle
1. Aller dans **Datacenter** > **Node** > **Create VM**.
2. Renseigner un **Nom** pour la VM.
3. Dans l’onglet **OS** :
   - Sélectionner "Use ISO image" et choisir l’ISO de Windows 2025.
   - Choisir **Microsoft Windows** comme type de système.
4. Dans **Systeme** :
   - Activer **Q35** et **UEFI (OVMF)** si nécessaire.
   - Ajouter un TPM, Windows 2025 l'exige.
5. Dans **Disque** :
   - Sélectionner un stockage.
   - Définir la taille du disque (ex. 50 Go).
   - Choisir **VirtIO SCSI** comme contrôleur disque.
6. Dans **CPU** :
   - Choisir le nombre de cœurs (ex. 4).
7. Dans **Mémoire** :
   - Définir la RAM (ex. 8192 Mo pour 8 Go).
8. Dans **Réseau** :
   - Choisir **VirtIO (paravirtualisé)**.
9. Ajouter un second CD/DVD drive et sélectionner l’ISO des drivers VirtIO.
10. Valider la création de la VM.

## 3. Installation de Windows 2025
1. Sélectionner la VM et cliquer sur **Start**.
2. Aller dans **Console** pour suivre l’installation.
3. Lancer l’installation de Windows 2025 et choisir **Personnalisée**.
4. À l’étape de sélection du disque, cliquer sur **Charger un pilote**.
5. Sélectionner le lecteur CD VirtIO et installer le driver nécessaire pour l'installation sur le disque:
    - vioscsi\2k25\amd64
6. Poursuivre l’installation de Windows normalement.
7. Une fois installé, retirer l’ISO Windows et redémarrer.

## 4. Installation des autres Drivers VirtIO
1. Aller dans **Ce PC** > **Lecteur VirtIO**.
2. Exécuter `virtio-win-guest-tools.exe` pour installer tous les drivers nécessaires.
3. Redémarrer la VM après l’installation.

## 5. Configuration Post-Installation
1. Mettre à jour Windows via Windows Update.
2. Activer le bureau à distance et le serveur SSH si nécessaire.
3. Installer les logiciels et outils souhaités.

## 6. Finalisation
- Démonter l’ISO depuis l’onglet **Hardware** > **CD/DVD Drive** > **Do not use any media**.
- Redémarrer la VM pour appliquer toutes les modifications.
- La VM Windows 2025 est maintenant prête à l'emploi !

## 7. Liens Utiles
- Documentation officielle Proxmox : [Proxmox Wiki](https://pve.proxmox.com/wiki/Main_Page)
- Téléchargement VirtIO Drivers : [VirtIO Drivers](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/)
