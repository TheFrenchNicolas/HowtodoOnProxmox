# Guide d'Installation et Configuration Basique de pfSense en VM sous Proxmox

## Prérequis
- Un serveur Proxmox VE fonctionnel.
- Une image ISO de pfSense (téléchargeable depuis [le site officiel](https://www.pfsense.org/download/)).
- Un accès à l'interface web de Proxmox.
- Deux interfaces réseau (WAN et LAN) pour la VM.

## 1. Téléchargement et Ajout de l’ISO pfSense
1. Accéder à l’interface web de Proxmox : `https://<adresse-IP>:8006`.
2. Aller dans **Datacenter** > **Node** > **Local (pve)** > **ISO Images**.
3. Cliquer sur **Upload** et sélectionner l’ISO de pfSense téléchargé.

## 2. Création de la Machine Virtuelle
1. Aller dans **Datacenter** > **Node** > **Create VM**.
2. Donner un **Nom** à la VM.
3. Dans l’onglet **OS** :
   - Sélectionner "Use ISO image" et choisir l’ISO de pfSense.
   - Laisser "Other" comme type de système.
4. Dans **Systeme** :
   - Activer **Q35**.
   - Désactiver "Use EFI" si activé par défaut.
5. Dans **Disque** :
   - Sélectionner un stockage et définir la taille (ex. 10 Go).
6. Dans **CPU** :
   - Définir 2 cœurs minimum.
7. Dans **Mémoire** :
   - Allouer au moins 2048 Mo de RAM.
8. Dans **Réseau** :
   - Ajouter deux interfaces réseau :
     - **vmbr0** pour le WAN (externe, vers Internet).
     - **vmbr1** pour le LAN (réseau interne).
9. Finaliser la création de la VM.

## 3. Installation de pfSense
1. Démarrer la VM et ouvrir la **Console**.
2. Suivre l’installation en sélectionnant les options par défaut.
3. Une fois l’installation terminée, retirer l’ISO et redémarrer.

## 4. Configuration Basique de pfSense
1. Se connecter à la console pfSense et vérifier l’attribution des interfaces :
   - WAN : IP obtenue en DHCP (ou à configurer manuellement).
   - LAN : Adresse IP par défaut `192.168.1.1/24`.
2. Accéder à l’interface web via `http://192.168.1.1`.
3. Se connecter avec :
   - **Utilisateur** : `admin`
   - **Mot de passe** : `pfsense`
4. Lancer l’assistant de configuration :
   - Définir un mot de passe administrateur.
   - Configurer l’interface WAN (DHCP ou IP statique).
   - Vérifier l’interface LAN (IP locale et DHCP activé par défaut).

## 5. Finalisation et Tests
- Tester la connectivité Internet depuis un client sur le LAN.
- Mettre à jour pfSense via `System > Update`.
- Configurer des règles de pare-feu si nécessaire (`Firewall > Rules`).

## 6. Liens Utiles
- Documentation officielle pfSense : [Netgate Docs](https://docs.netgate.com/pfsense/en/latest/)
- Wiki Proxmox : [Proxmox Wiki](https://pve.proxmox.com/wiki/Main_Page)

