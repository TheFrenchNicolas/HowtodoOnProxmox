#!/usr/bin/env bash

# Copyright (c) 2025
# Author: Nicolas (TheFrenchNicolas)
# License: MIT | https://github.com/TheFrenchNicolas/HowtodoOnProxmox/raw/main/LICENSE


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