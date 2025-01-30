Voici un script Bash (update.sh) pour automatiser la mise à jour des paquets sur un serveur Proxmox via une tâche cron. Ce script met à jour les paquets et enregistre les logs pour un suivi.  

```bash
#!/bin/bash

# Définition du fichier de log
LOGFILE="/var/log/proxmox_update.log"

# Mise à jour des paquets
echo "[$(date)] Début de la mise à jour des paquets" >> $LOGFILE
apt update && apt dist-upgrade -y >> $LOGFILE 2>&1
echo "[$(date)] Mise à jour terminée" >> $LOGFILE

# Nettoyage des paquets inutiles
apt autoremove -y >> $LOGFILE 2>&1
apt autoclean -y >> $LOGFILE 2>&1
echo "[$(date)] Nettoyage terminé" >> $LOGFILE
```

### Téléchargement du scipt
1. Se connecter via le Shell de l'interface Web de votre Proxmox
2. Pour télécharger le script:
 ```bash
 mkdir -p ~/script && wget -O ~/script/update.sh https://raw.githubusercontent.com/TheFrenchNicolas/HowtodoOnProxmox/refs/heads/main/Install_and_update_Proxmox/update.sh
```



### Ajout au Cron
1. Ouvrir le fichier cron :  
   ```bash
   crontab -e
   ```
2. Ajouter cette ligne pour exécuter le script chaque jour à 3h du matin :  
   ```bash
   0 3 * * * ~/script/update.sh
   ```
3. Sauvegarder et quitter.

