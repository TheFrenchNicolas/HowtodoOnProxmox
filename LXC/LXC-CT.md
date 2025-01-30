# Guide d'Installation d'un Conteneur LXC sous Proxmox

## Prérequis
- Un serveur Proxmox VE fonctionnel.
- Un accès à l'interface web de Proxmox.
- Une connexion Internet pour télécharger un template de conteneur.

## 1. Téléchargement d'un Template LXC
1. Accéder à l’interface web de Proxmox : `https://<adresse-IP>:8006`.
2. Aller dans **Datacenter** > **Node** > **Local (pve)** > **CT Templates**.
3. Cliquer sur **Templates** et sélectionner l’image souhaitée (ex. Debian, Ubuntu, Alpine, etc.).
4. Cliquer sur **Download** pour récupérer le template.

## 2. Création du Conteneur LXC
1. Aller dans **Datacenter** > **Node** > **Create CT**.
2. Renseigner un **Nom** pour le conteneur.
3. Sélectionner le template téléchargé précédemment.
4. Définir les ressources :
   - **Disque** : Choisir un stockage et une taille adaptée (ex. 8 Go).
   - **CPU** : Définir le nombre de cœurs (ex. 2).
   - **Mémoire** : Définir la RAM (ex. 2048 Mo).
5. Configurer le réseau :
   - Choisir un mode (Bridge, NAT, etc.).
   - Attribuer une adresse IP manuellement ou via DHCP.
6. Définir un mot de passe root pour l’accès au conteneur.
7. Cliquer sur **Finish** pour créer le conteneur.

## 3. Démarrage et Accès au Conteneur
1. Sélectionner le conteneur nouvellement créé.
2. Cliquer sur **Start** pour démarrer la LXC.
3. Aller dans **Console** pour accéder au terminal du conteneur.
4. Se connecter avec l’utilisateur `root` et le mot de passe défini.

## 4. Configuration Post-Installation
1. Mettre à jour le système :
   ```bash
   apt update && apt upgrade -y  # Pour Debian/Ubuntu
   apk update && apk upgrade  # Pour Alpine
   ```
2. Installer les paquets nécessaires :
   ```bash
   apt install sudo vim -y  # Exemple pour Debian/Ubuntu
   ```
3. Configurer le réseau si nécessaire (ex. fichiers `/etc/network/interfaces` ou `/etc/netplan/`).

## 5. Gestion et Maintenance
- **Arrêter le conteneur** : `pct stop <ID>`
- **Redémarrer** : `pct reboot <ID>`
- **Suppression** : `pct destroy <ID>`
- **Sauvegarde** : `vzdump <ID>`

## 6. Liens Utiles
- Documentation officielle Proxmox : [Proxmox Wiki](https://pve.proxmox.com/wiki/Main_Page)
- Gestion des Conteneurs LXC : [LXC Documentation](https://linuxcontainers.org/)
- CheatSheet Vim : [Devhints Vim](https://devhints.io/vim)

