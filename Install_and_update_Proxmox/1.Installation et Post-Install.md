# **Guide d'installation et de configuration d'un serveur Proxmox**

Proxmox VE (Virtual Environment) est une plateforme de virtualisation de serveurs open-source qui combine KVM (Kernel-based Virtual Machine) pour les machines virtuelles et LXC (Linux Containers) pour la virtualisation légère basée sur les conteneurs.

---

## **1. Prérequis**
Avant de commencer, assurez-vous d'avoir les éléments suivants :
- Un serveur dédié ou un PC avec support de virtualisation matérielle (Intel VT-x/AMD-V).
- Au moins 4 Go de RAM (8 Go ou plus recommandés pour une utilisation en production).
- Un CPU multi-cœur (plus il y a de cœurs, mieux c'est pour exécuter plusieurs VM/conteneurs).
- Un minimum de 50 Go de stockage (SSD recommandé pour de meilleures performances).
- Une connexion Internet stable.
- Une clé USB (pour le support d'installation de Proxmox).
- Un moniteur et un clavier (pour la configuration initiale, sauf si vous utilisez IPMI ou un accès à distance).

---

## **2. Télécharger l'ISO de Proxmox VE**
1. Visitez le site officiel de Proxmox : [https://www.proxmox.com/en/downloads](https://www.proxmox.com/en/downloads).
2. Téléchargez le dernier fichier ISO de Proxmox VE.
3. Utilisez un outil comme [Rufus](https://rufus.ie/) (Windows) ou `dd` (Linux) pour créer une clé USB bootable avec l'ISO.

---

## **3. Installer Proxmox VE**
1. **Démarrer à partir de l'USB** :
   - Insérez la clé USB dans votre serveur.
   - Démarrez le serveur et entrez dans les paramètres du BIOS/UEFI pour définir la clé USB comme périphérique de démarrage principal.
   - Sauvegardez les modifications et redémarrez.

2. **Démarrer l'installation** :
   - Sélectionnez "Install Proxmox VE" dans le menu de démarrage.
   - Acceptez le Contrat de Licence Utilisateur Final (EULA).

3. **Configurer le disque** :
   - Sélectionnez le disque cible pour l'installation.
   - Choisissez un système de fichiers (ext4, XFS ou ZFS). ZFS est recommandé pour des fonctionnalités avancées comme les snapshots et la redondance, mais il nécessite plus de RAM.

4. **Configurer le réseau** :
   - Configurez le nom d'hôte (par exemple, `proxmox.example.com`).
   - Entrez l'adresse IP, le masque de sous-réseau, la passerelle et le serveur DNS. Assurez-vous que l'IP est statique pour un accès fiable.

5. **Définir le mot de passe** :
   - Créez un mot de passe fort pour l'utilisateur `root`.

6. **Terminer l'installation** :
   - Confirmez les paramètres d'installation et procédez.
   - Une fois installé, retirez la clé USB et redémarrez le serveur.

---

## **4. Accéder à l'interface web de Proxmox**
1. Après le redémarrage, notez l'URL affichée à l'écran (par exemple, `https://<IP>:8006`).
2. Ouvrez un navigateur web et accédez à l'URL fournie.
3. Connectez-vous avec le nom d'utilisateur `root` et le mot de passe que vous avez défini lors de l'installation.

---

## **5. Configuration initiale**
### **5.1. Mettre à jour Proxmox**
1. Ouvrez l'interface web et accédez au shell (via l'onglet "Shell" ou SSH).
2. Exécutez les commandes suivantes pour mettre à jour le système :
   ```bash
   apt update
   apt upgrade -y
   apt dist-upgrade -y
   ```
3. Redémarrez le serveur si nécessaire.

### **5.2. Configurer le stockage**
1. Ajoutez du stockage supplémentaire (si disponible) :
   - Allez dans "Datacenter" > "Storage" > "Add".
   - Choisissez le type de stockage (par exemple, Directory, LVM, ZFS, NFS, etc.).
   - Suivez les instructions pour configurer le stockage.

2. Configurez un emplacement de sauvegarde (optionnel mais recommandé).

### **5.3. Configurer le réseau**
1. Ajoutez des interfaces réseau ou des VLAN supplémentaires si nécessaire :
   - Allez dans "Datacenter" > "Network" > "Create".
   - Configurez les ponts, les liaisons ou les VLAN selon les besoins.

2. Assurez-vous que le pare-feu est correctement configuré :
   - Allez dans "Datacenter" > "Firewall" > "Options".
   - Activez ou désactivez le pare-feu selon les besoins.

### **5.4. Ajouter une clé d'abonnement (Optionnel)**
- Proxmox est gratuit, mais un abonnement donne accès au dépôt d'entreprise et au support.
- Pour ajouter une clé d'abonnement, allez dans "Datacenter" > "Subscription" > "Enter Key".

### **5.5. Désactiver l'abonnement de mise à jour (Optionnel)**
1. Dans l'onglet "Shell", pour désactiver l'abonnement, exécutez les commandes suivantes :
``` bash
sed -i 's/^deb/#deb/g' /etc/apt/sources.list.d/pve-enterprise.list
```
2. Pour ajouter le dépôt sans abonnement, exécutez les commandes suivantes :
```bash
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
apt update && apt upgrade -y
```

---

## **6. Créer des machines virtuelles (VM) et des conteneurs**
### **6.1. Créer une VM**
1. Allez sur le bouton "Create VM" en haut à droite.
2. Suivez l'assistant pour :
   - Sélectionner un ISO de système d'exploitation (téléchargez-le dans le stockage au préalable si nécessaire).
   - Allouer CPU, RAM et espace disque.
   - Configurer les paramètres réseau.
3. Démarrez la VM et installez le système d'exploitation.

### **6.2. Créer un conteneur LXC**
1. Allez sur le bouton "Create CT" en haut à droite.
2. Suivez l'assistant pour :
   - Sélectionner un modèle (téléchargez-le depuis la section "Templates" si nécessaire).
   - Allouer des ressources.
   - Configurer les paramètres réseau.
3. Démarrez le conteneur et configurez-le selon les besoins.

---

## **7. Sauvegarde et restauration**
1. Configurez des sauvegardes régulières :
   - Allez dans "Datacenter" > "Backup" > "Add".
   - Configurez la planification des sauvegardes et l'emplacement de stockage.
2. Testez la restauration d'une VM ou d'un conteneur pour vous assurer que les sauvegardes fonctionnent.

---

## **8. Configuration avancée (Optionnel)**
### **8.1. Haute disponibilité (HA)**
- Configurez un cluster Proxmox pour la HA :
  1. Allez dans "Datacenter" > "Cluster" > "Create Cluster".
  2. Ajoutez des nœuds supplémentaires au cluster.
  3. Configurez la HA pour les VM/conteneurs critiques.

### **8.2. Configuration ZFS**
- Si vous utilisez ZFS, configurez RAID-Z ou le miroir pour la redondance :
  1. Allez dans "Datacenter" > "Storage" > "Add" > "ZFS".
  2. Suivez les instructions pour configurer le pool ZFS.

### **8.3. Certificats SSL**
- Remplacez le certificat auto-signé par défaut par un certificat de confiance :
  1. Allez dans "Datacenter" > "Certificates" > "Upload".
  2. Téléchargez votre certificat et votre clé privée.

---

## **9. Maintenance et surveillance**
- Vérifiez régulièrement les mises à jour et appliquez-les.
- Surveillez l'utilisation des ressources via l'interface web ou des outils comme Grafana.
- Configurez des notifications par email pour les alertes critiques :
  - Allez dans "Datacenter" > "Notifications" > "Add".

---

## **10. Dépannage**
- **Impossible d'accéder à l'interface web ?** Vérifiez la configuration IP et les paramètres du pare-feu.
- **La VM/conteneur ne démarre pas ?** Vérifiez l'allocation des ressources et les journaux.
- **Problèmes de réseau ?** Assurez-vous que les configurations de pont et de VLAN sont correctes.

---

En suivant ce guide, vous devriez avoir un serveur Proxmox entièrement fonctionnel prêt à héberger des VM et des conteneurs. Proxmox est un outil puissant, alors prenez le temps d'explorer ses fonctionnalités et de l'optimiser pour votre cas d'utilisation spécifique. Bonne virtualisation !