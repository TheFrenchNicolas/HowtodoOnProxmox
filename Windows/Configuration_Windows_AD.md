# Guide de Configuration d'un Serveur Windows 2025 avec Active Directory

## Prérequis
- Une installation fonctionnelle de **Windows Server 2025**.
- Un accès administrateur au serveur.
- Une adresse IP statique configurée.
- Un nom de domaine complet (FQDN) pour le domaine Active Directory.

## 1. Configuration Initiale du Serveur
1. **Configurer une IP statique** :
   - Aller dans **Paramètres réseau** > **Modifier les options d’adaptateur**.
   - Sélectionner la carte réseau, puis **Propriétés**.
   - Choisir **Protocole Internet Version 4 (TCP/IPv4)** et définir :
     - IP : `192.168.1.10` (exemple)
     - Masque : `255.255.255.0`
     - Passerelle : `192.168.1.1`
     - DNS : `127.0.0.1` (pour pointer vers lui-même après l’installation d’AD).
2. **Renommer le serveur** :
   - Aller dans **Paramètres** > **Système** > **À propos**.
   - Changer le nom et redémarrer le serveur.

## 2. Installation des Services Active Directory
1. **Ouvrir le Gestionnaire de Serveur**.
2. Aller dans **Ajouter des rôles et fonctionnalités**.
3. Sélectionner **Installation basée sur un rôle ou une fonctionnalité**.
4. Choisir **Active Directory Domain Services (AD DS)**.
5. Ajouter les fonctionnalités requises et cliquer sur **Suivant** jusqu’à l’installation.
6. Une fois l’installation terminée, cliquer sur **Fermer**.

## 3. Promotion du Serveur en Contrôleur de Domaine
1. Retourner dans le **Gestionnaire de Serveur**.
2. Cliquer sur **Promouvoir ce serveur en contrôleur de domaine**.
3. Sélectionner **Ajouter une nouvelle forêt** et entrer un nom de domaine (ex. `mondomaine.local`).
4. Définir un mot de passe pour le **Mode de Restauration des Services d’annuaire (DSRM)**.
5. Laisser les options par défaut et poursuivre l’installation.
6. Redémarrer le serveur après la configuration.

## 4. Configuration du DNS et Vérifications
1. **Vérifier le service DNS** :
   - Ouvrir **Gestionnaire DNS** (`dnsmgmt.msc`).
   - Vérifier la présence de la zone DNS du domaine.
2. **Tester la résolution DNS** :
   - Ouvrir **Invite de commandes** et exécuter :
     ```powershell
     nslookup mondomaine.local
     ```
3. **Ajouter un enregistrement DNS si nécessaire** :
   - Aller dans **Gestionnaire DNS** > **Zone de recherche directe**.
   - Ajouter un **Nouvel hôte A** pointant vers l’adresse IP du serveur AD.

## 5. Création des Utilisateurs et Groupes
1. Ouvrir **Utilisateurs et Ordinateurs Active Directory** (`dsa.msc`).
2. Dans le domaine, créer des **Unités d’Organisation (OU)** pour organiser les utilisateurs.
3. Créer des **groupes de sécurité** et **utilisateurs** :
   - Clic droit sur l’OU > **Nouveau** > **Utilisateur**.
   - Remplir les informations et définir un mot de passe.
   - Assigner les utilisateurs aux groupes appropriés.

## 6. Configuration des Politiques de Groupe (GPO)
1. Ouvrir **Gestion des stratégies de groupe** (`gpmc.msc`).
2. Créer une **nouvelle GPO** et la lier à une OU spécifique.
3. Modifier la GPO pour appliquer des règles (ex. interdiction d’accès au Panneau de Configuration).
4. Appliquer la stratégie en exécutant :
   ```powershell
   gpupdate /force
   ```

## 7. Vérification et Tests
1. Joindre un client Windows au domaine :
   - Aller dans **Paramètres** > **Système** > **Informations système**.
   - Cliquer sur **Modifier les paramètres** > **Domaine** et entrer `mondomaine.local`.
   - Saisir les identifiants administrateur AD.
   - Redémarrer la machine.
2. Tester l’authentification avec un utilisateur AD.

## 8. Liens Utiles
- Documentation officielle Microsoft : [Microsoft Docs](https://docs.microsoft.com/en-us/windows-server/)
- Configuration avancée d’Active Directory : [AD DS Guide](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/)
