# Guide d'Installation d'une VM Debian sous Proxmox

## Prérequis
- Un serveur Proxmox VE fonctionnel.
- Une image ISO de Debian (téléchargeable sur [ce lien](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso)).
- Un stockage suffisant pour la VM.
- Un accès à l'interface web de Proxmox.

## 1. Téléchargement et Ajout de l'ISO
1. Accéder à l’interface web de Proxmox : `https://<adresse-IP>:8006`.
2. Aller dans **Datacenter** > **Node** > **Local (pve)** > **ISO Images**.
3. Cliquer sur **Upload** et sélectionner l’ISO Debian téléchargé.

## 2. Création de la Machine Virtuelle
1. Aller dans **Datacenter** > **Node** > **Create VM**.
2. Renseigner un **Nom** pour la VM.
3. Dans l’onglet **OS** :
   - Sélectionner "Use ISO image" et choisir l’ISO Debian précédemment importé.
   - Choisir **Linux 6.x - 5.x - 4.x (kernel)** comme type de système.
4. Dans **Systeme** :
   - Laisser les options par défaut.
5. Dans **Disque** :
   - Sélectionner un stockage.
   - Définir la taille du disque (ex. 20 Go).
6. Dans **CPU** :
   - Choisir le nombre de cœurs (ex. 2).
7. Dans **Mémoire** :
   - Définir la RAM (ex. 2048 Mo pour 2 Go).
8. Dans **Réseau** :
   - Laisser l’option par défaut **VirtIO (paravirtualisé)**.
9. Valider la création de la VM.

## 3. Installation de Debian
1. Sélectionner la VM et cliquer sur **Start**.
2. Aller dans **Console** pour suivre l’installation.
3. Suivre les étapes de l’installation Debian :
   - Choisir la langue, le fuseau horaire et la disposition du clavier.
   - Configurer le réseau (nom d’hôte, domaine, etc.).
   - Créer un utilisateur et un mot de passe.
   - Partitionner le disque (choisir **Utilisation guidée – disque entier** si recommandé).
   - Installer le système de base.
   - Installer GRUB sur le disque principal.
4. Redémarrer la VM après l’installation.

## 4. Configuration Post-Installation
1. Mettre à jour le système :
   ```bash
   apt update && apt upgrade -y
   ```
2. Installer **qemu-guest-agent** pour améliorer l’intégration avec Proxmox :
   ```bash
   apt install qemu-guest-agent -y
   systemctl enable qemu-guest-agent --now
   ```
3. Configurer SSH (si nécessaire) :
   ```bash
   systemctl enable ssh --now
   ```

## 5. Finalisation
- Démonter l’ISO depuis l’onglet **Hardware** > **CD/DVD Drive** > **Do not use any media**.
- Redémarrer la VM pour appliquer toutes les modifications.
- La VM Debian est maintenant prête à l'emploi !