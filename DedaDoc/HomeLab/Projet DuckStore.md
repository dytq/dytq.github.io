---

title: Projet DuckStore 
author: Taariq Dedarally 
date: December 2025 

tags:
- réseau
- infrastructure
- virtualisation
- Active Directory
- PfSense
- Proxmox
- VLAN
- sécurité
- DMZ
- documentation type: projet statut: fonctionnel

---
---

> ⚠️ **AVERTISSEMENT — UTILISATION RESTREINTE**
> 
> Ce document est la propriété de **Taariq Dedarally**. Tout usage, reproduction, distribution, modification ou diffusion de ce document, même partielle, est strictement interdit sans autorisation préalable écrite de son auteur. 
> Toute ressemble à une entreprise existante est purement fortuite. Ce document présente une entreprise purement fictive.
> 
> Pour toute demande d'autorisation, veuillez contacter : **[taariq.deda@gmail.com](mailto:taariq.deda@gmail.com)**
---
# Projet DuckStore

## Remerciements

Je tiens à remercier toutes les personnes qui ont contribué de près ou de loin à ce projet et à cette formation POEC.

J'adresse mes sincères remerciements à tous les formateurs et toutes les personnes qui, par leurs paroles, leurs écrits, leurs conseils et leurs critiques, ont guidé mon apprentissage et ont accepté de me rencontrer et de répondre à mes questions durant la formation.

Je tiens aussi à souligner l'accueil chaleureux de l'école et de notre groupe d'élèves, qui ont pu témoigner d'une grande solidarité et d'un esprit d'équipe indéniable.

---

# 1. Introduction

## 1.1 Présentation du candidat

Je m'appelle Taariq et je suis passionné par l'informatique depuis le lycée. Je possède une formation solide en ingénierie des réseaux et systèmes, ayant récemment été diplômé d'un master à l'université Paris-Saclay.

Durant ce master, j'ai eu l'occasion de réaliser un stage chez Naval Group. J'ai ainsi pu concevoir un plugin en Python pour le logiciel Wireshark afin d'analyser finement le réseau. Ce plugin était destiné aux développeurs, afin qu'ils puissent analyser le réseau en temps réel et ainsi gagner un temps de débogage non négligeable. J'ai conçu cette solution de manière à garantir une grande flexibilité et une facilité d'édition.

À la fin de ce stage, j'ai eu l'occasion de mener différents projets, comme des hackathons organisés par des entreprises telles que XPRL, Huawei, ainsi qu'à l'école IPI. J'en ai également profité pour me former en autonomie et obtenir plusieurs certifications.

Actuellement en formation professionnelle à l'IPI dans l'objectif d'acquérir davantage de pratique, je suis motivé à engager mes compétences et mon expertise au service d'une équipe en administration système.

## 1.2 Contacts

Ce projet a été réalisé en travail individuel. Pour toute amélioration et suggestion :

- **Mail** : taariq.deda@gmail.com
- **LinkedIn** : https://www.linkedin.com/in/tq-dy/
- **GitHub** : https://github.com/dytq
- **SiteWeb**: [https://dytq.github.io/src/index.html](https://dytq.github.io/src/index.html)

## 1.3 Présentation du projet

### 1.3.1 Présentation de l'entreprise DuckStore

DuckStore est une entreprise basée en France, avec un site situé dans la région parisienne. Son objectif est de contribuer positivement à la Responsabilité Sociétale et Environnementale (RSE) des entreprises et des établissements publics. Consciente des enjeux écologiques, DuckStore s'engage sur un marché en pleine expansion.

On sait que **40% des émissions de CO₂** sont liées aux transports, dont une partie non négligeable provient des déplacements de véhicules motorisés.

Pour amortir le coût lié aux transports polluants, DuckStore propose une solution clé en main pour l'installation et la maintenance d'équipements électriques. DuckStore est spécialisée dans :

- L'installation et la gestion de parcs électriques pour la recharge des voitures électriques
- L'installation de bornes de recharge pour les VAE (Vélos à Assistance Électrique)

DuckStore vous accompagne dans la transition écologique et s'adapte aux villes en pleine transformation. Avec DuckStore, vous bénéficiez d'un devis clair et d'un accompagnement adapté aux besoins des utilisateurs.

### 1.3.2 Scénario d'une entreprise en expansion

DuckStore est une entreprise de petite et moyenne taille, comptant une centaine d'employés. En raison d'une augmentation du nombre de salariés, il est souhaité de refaire l'intégralité du réseau dans de nouveaux locaux. Il est exigé de garantir la même qualité de sécurité et de fiabilité que l'ancien réseau, tout en prenant en compte l'augmentation du nombre d'employés.

En qualité d'ingénieur réseau, je suis donc amené à proposer une solution d'architecture réseau pour DuckStore. Il s'agit d'une maquette de base, dans laquelle je présente ma solution ainsi que le lancement de nouveaux projets concernant certaines parties spécifiques de l'architecture.

### 1.3.3 Problématique

> **Comment assurer le bon fonctionnement du réseau interne de l'entreprise ? Quelles sont les solutions, technologies et architectures proposées ?**

### 1.3.4 Objectif

Le tableau suivant résume les différents départements présents chez DuckStore :
![[departement_desc.png]]
> Description Figure:_Tableau représentant l'ensemble des employés_

### 1.3.5 Plan d'action

Le plan d'action est le suivant :

1. **Interconnexion et isolation des départements** — Mise en place de VLAN pour réduire les coûts et rendre l'accès réseau plus modulable. Un équipement permettant l'inter-VLAN sera également requis.
2. **Blocage des intrusions** — Mise en place d'un firewall avec une évolution régulière des règles pour renforcer la sécurité.
3. **DMZ** — Isoler le site web de l'entreprise dans une zone démilitarisée.
4. **Annuaire** — Gérer les postes des employés à l'aide d'un annuaire et définir les politiques associées (GPO).
5. **Imprimantes** — Mettre en place l'accès aux imprimantes.
6. **Stockage partagé** — Isoler et permettre l'accès à un système de stockage partagé.

> [!NOTE] L'ensemble du réseau doit permettre une facilité de déploiement et de maintenance. Il a donc été choisi de s'orienter vers des hyperviseurs de type 1.

---

# 2. Développement Technique du Projet

## 2.1 Infrastructure et technologies utilisées

### 2.1.1 Schéma directeur

Le schéma directeur est concentré dans les locaux de DuckStore. Chaque employé dispose d'un poste, et il doit être possible de se connecter à n'importe quel compte depuis n'importe quel poste.

La maquette représentée ci-dessous est un exemple si l'on souhaite implémenter le réseau en physique avec les cinq départements.

`maquette_cisco.png`

> Description Figure:_Maquette Cisco représentant le schéma physique du projet_

> [!WARNING] **Coquille :** Il manque un serveur Proxmox de redondance dans le schéma.

Dans ce schéma, la **DMZ doit être séparée du réseau local** pour des raisons de sécurité. Des switchs L2 seront connectés aux différents départements et dimensionnés selon les besoins, en termes de disponibilité de ports et de redondance, afin d'assurer une meilleure fiabilité.

Concernant la sécurité, deux serveurs physiques sont prévus pour la gestion de l'annuaire, ainsi qu'un serveur firewall dédié au filtrage des flux au niveau du NAT. Le firewall intègre des outils **IDS et IPS**.

### 2.1.2 Système d'Information

La solution implémentée est basée intégralement sur la **virtualisation**. Cela permet d'obtenir une meilleure modularité ainsi qu'une évolution plus flexible du réseau. Le parc informatique est ainsi contrôlable et l'ensemble des machines est dûment identifié, classé, dimensionné et pilotable selon les besoins.

L'ensemble du système d'information est référencé dans un fichier Excel composé de différentes feuilles (chaque feuille représente une fonction).

### 2.1.3 Couche de Virtualisation
![[virtualisation.png]]
> Description Figure:_Résumé des couches de virtualisation_

#### Machine Hôte

| Composant | Détails                                    |
| --------- | ------------------------------------------ |
| OS        | Linux                                      |
| RAM       | 16 GB                                      |
| CPU       | 12th Gen Intel® Core™ i5-12400F × 12 cœurs |

> [!NOTE] Dans l'idéal, il aurait fallu ajouter une seconde barrette de 16 GB afin d'obtenir une configuration plus stable.

#### Couche 0 — KVM (Hyperviseur de type 1)

KVM a été utilisé comme hyperviseur de type 1. Il est basé sur le Kernel Linux et est optimisé pour fonctionner sur des machines hôtes Linux. Il a été choisi car il correspondait à l'environnement et aux contraintes de consommation RAM.

> [!TIP] **Alternative :** On aurait par exemple pu substituer KVM par l'équivalent sur Windows, **Hyper-V**.

KVM peut être utilisé en ligne de commande ou via une interface graphique.
![[kvm.png]]
> Description Figure:_Capture d'écran du fonctionnement du logiciel KVM_

#### Couche 1 — Proxmox

Proxmox a été utilisé pour la gestion des machines, une solution proche de VMware ESXi. N'ayant pas de contrainte forte d'intégrité, une solution **open-source** a été préférée.

Pour une petite entreprise comme DuckStore, Proxmox est une solution adaptée selon différents critères :

- Absence de licences coûteuses
- Pilotage via interface web
- Possibilité de souscrire à un support
![[proxmox.png]]
> Description Figure:_Capture d'écran montrant le fonctionnement de Proxmox. À gauche, le datacenter ; au centre, un résumé graphique des ressources ; en bas, les logs principaux._

#### Couche 2 — Machines virtuelles déployées dans Proxmox

|Machine|Rôle|
|---|---|
|2× Windows Server (AD DS)|Gestion des comptes, DHCP, DNS|
|PfSense|Routage, inter-VLAN, firewall|
|Debian (conteneur LXC)|Hébergement du site web (DMZ)|
|2× Windows (postes client)|Postes employés (exemple)|
![[inventaire_des_machines.png]]
> Description Figure:_Déploiement des machines virtuelles dans Proxmox. Les machines sont éteintes sur cette capture._

Chaque machine est référencée avec des **tags**, ce qui permet de filtrer et retrouver plus facilement une machine.

---

## 2.2 Mise en place de l'infrastructure

### 2.2.1 Virtualisation

La virtualisation des machines est assurée par Proxmox. L'installation peut se faire sur du bare-metal ou dans une machine virtuelle. Proxmox propose une interface web via le **port 8006** pour contrôler les machines virtuelles et permet une visualisation graphique des ressources consommées.

#### Nœuds

Avant tout, un espace de stockage **"thin"** a été créé afin d'allouer uniquement la place réellement utilisée. Dans le datacenter, un nœud nommé `duckstore` a été créé. Dans Proxmox, il est possible de créer des machines virtuelles ou des conteneurs.

#### Interface réseau

Dans le nœud DuckStore, quatre interfaces réseau ont été créées :

|Interface|Usage|
|---|---|
|`vmbr0`|NAT (WAN)|
|`vmbr2`|Réseau des serveurs|
|`vmbr3`|Réseau des employés|
|`vmbr4`|DMZ|
|`vmbr5`|Liaison machine de gestion ↔ PfSense|

Ces réseaux étaient initialement assurés par des **Linux Bridges**. Cependant, il s'est avéré complexe de faire passer correctement les tags VLAN via ces interfaces. Il a donc été opté pour les **switches virtuels OVS** inclus dans Proxmox :

- **OVS Bridge** — commutateur sur lequel on peut attacher des ports
- **OVS Int Port** — port virtuel
- **OVS Bond** — permet d'agréger plusieurs interfaces réseau

Le Linux Bridge a été conservé pour le WAN et pour `vmbr5`. Les **OVS IntPorts** sont utilisés pour définir les tags VLAN, et les bridges pour les associer aux machines virtuelles. Dans les paramètres réseau de chaque VM, un bridge est attribué avec le tag VLAN défini dans les OVS ports.
![[reseau_proxmox.png]]
> Description Figure:_Interfaces réseau utilisées dans Proxmox_

![[config_pfsense.png]]
> Description Figure:_Configuration matérielle de PfSense avec ses 4 interfaces réseau connectées_

#### Machines Virtuelles

Pour créer une machine, il faut tout d'abord importer l'ISO dans un espace dédié (`/var`). Une fois importée, on peut créer la machine. Chaque machine possède un **ID attribué** (100, 101, ...). On installe ensuite le système sur la machine. Pour chaque machine, on peut surveiller les logs et les ressources consommées.

Une machine **"template"** a été utilisée pour réaliser des **"link clone"**, permettant de déployer rapidement un nouveau poste client sans devoir réinstaller une machine complète.

> [!NOTE] Une machine obsolète `RTRWin` a été créée comme essai pour faire du routage sous Windows via le rôle "Serveur dédié au routage" dans Windows Server 2019. Cette solution n'était pas efficiente et consommait trop de ressources.

---

### 2.2.2 Annuaire LDAP — Active Directory

Pour l'annuaire LDAP, **Windows Server 2019** a été utilisé avec le rôle **AD DS**. Un petit script Python disponible ici: https://github.com/dytq/ou_adds_generator a été créé permettant de générer des scripts `.ps1` exécutables avec PowerShell. Cela permet d'éviter des erreurs, garantit davantage de sécurité (chaque utilisateur reçoit un mot de passe par défaut) et assure une meilleure traçabilité.

#### Étapes de configuration

1. **Création des OU** — Une organisation représentant la situation géographique (ici `PARIS`) a été définie. Dans cette unité, chaque département possède une OU pour les `GROUP`, les `PCs` et les `USER`.
    
2. **Création des groupes** :
    
    - `GG` — groupe global contenant tous les utilisateurs
    - `GDL` — groupes de domaine local permettant d'attribuer des droits spécifiques
    - `SHARE_R` — accès stockage en lecture seule
    - `SHARE_RW` — accès stockage en lecture/écriture
3. **Création des PCs** dans les groupes PCs des départements.
    
4. **Création des utilisateurs**, placés dans les groupes `USERS`.
    
5. **Ajout des utilisateurs** dans le groupe `GG`.
    
6. **Ajout des GDL** comme membres du groupe `GG`.
    

![[OU.png]]
> Description Figure:_Capture d'écran des unités d'organisation. Ici sont représentés les groupes pour les employés Opérations._

---

### 2.2.3 Stockage — Serveur de partage de fichiers

#### Mise en place du disque

1. Un nouvel espace disque de **15 Go** a été ajouté à la machine virtuelle au niveau de Proxmox.
2. Le disque a été monté et formaté en **NTFS** via le gestionnaire de partitions de Windows.
3. Le disque a été monté sous la lettre **Z:**.
![[disk_dedie.png]]
> Description Figure:_Capture d'écran qui montre le disque dédié_

#### Organisation des dossiers

Dans la partition Z:, **2 dossiers par département** ont été créés :

- Un dossier en **lecture seule**
- Un dossier en **lecture/écriture**

Le disque Z: a été partagé avec les permissions suivantes :

- Par défaut, les utilisateurs ont seulement l'accès en **lecture**
- Dans les dossiers spécifiques aux départements, les permissions ont été modifiées pour autoriser les groupes locaux à lire ou lire/écrire
- Les autres départements ont été exclus pour ne pas avoir accès


![[Organisation_Stockage.png]]
> Description Figure:_Organisation du stockage_
![[droit_stockage.png]]
> Description Figure:_Exemple de droits attribués au dossier `OPE_RW`. Les GG des autres départements sont exclus et le `GDL_OPE_SHARE_RW` est inclus en lecture et écriture._

![[Acces_client_stockage.png]]

> Description Figure:_Accès client au stockage partagé dans Z_

> [!TIP] **Amélioration possible :** Pour faciliter l'accès au stockage, une icône pourrait être ajoutée sur le bureau via une GPO.

---

### 2.2.4 Services Réseaux

#### Service DNS

Le service DNS est assuré par le serveur DNS de **Windows Server**. Le DNS apparaît bien sur les postes clients dans les interfaces réseau (`duckstore.local`). Une nouvelle entrée DNS **AAA** a été ajoutée pour le serveur web.

![[web_dns.png]]

> Description Figure:_Capture d'écran montrant le fonctionnement du DNS dans un poste client. Le nom de domaine est configuré à `duck.com`_

![[serveur_dns.png]]

> Description Figure:_Capture d'écran du serveur DNS_

#### Service DHCP

Le serveur DHCP est installé sous forme de rôle dans Windows Server. Des étendues correspondant à chaque VLAN ont été définies. Dans le VLAN 104, les adresses des imprimantes ont été exclues.

![[tableau_dhcp.png]]

> Description Figure:_Tableau qui résume l'ensemble des équipements pour la segmentation des étendues pour le DHCP._

![[DHCP_WINDOWS_SRV.png]]

> Description Figure:_Capture d'écran des étendues DHCP — une étendue par VLAN_

#### Mise en place du serveur dans la DMZ

Pour le site web, un conteneur **LXC Debian** a été créé dans Proxmox. Le conteneur a été téléchargé directement depuis l'interface de Proxmox. **Apache2** a été installé via `apt`.

> [!NOTE] L'avantage du conteneur est sa faible consommation de ressources par rapport à une machine virtuelle classique car une partie du système est partagée.

---

### 2.2.5 Sécurité — PfSense

Pour la partie sécurité, **PfSense** a été utilisé. PfSense permet de faire du routage et de la gestion de firewall.

#### VLAN

Les VLANs sont définis dans Proxmox afin de faire transiter les tags VLAN vers les interfaces. La gestion et l'inter-routage des VLANs est ensuite assurée par PfSense. Pour configurer les VLANs, il faut d'abord les créer via l'interface dédiée, puis connecter les interfaces VLAN aux vnet de la machine.

![[LAN_PFSENSE.png]]

> Description Figure:_Configuration des LAN dans PfSense_

![[pfsense.png]]

> Description Figure:_Ensemble des interfaces connectées aux interfaces vnet de la machine_

#### Firewall

Dans PfSense, le firewall **bloque toutes les entrées par défaut** (sauf pour le WAN et le LAN). Les règles suivantes doivent être configurées :

- Isoler les VLANs entre eux
- Permettre l'accès à la DMZ depuis l'extérieur
- Autoriser l'Active Directory
- Permettre à la DMZ d'exposer son port 80 via un **port forwarding** dans le NAT

![[firewall_exemple.png]]

> Description Figure:_Les VLAN 100 et 103 sont isolés_

> [!CAUTION] **Comportement observé :** Le ping entre le VLAN100 et VLAN103 ne passe plus, mais du VLAN 103 au VLAN 100, le ping passe. Les règles placées le plus haut sont en priorité.

> [!TIP] **Retour d'expérience :** Lors des essais, une erreur a été commise en confondant l'adresse VLAN et le subnet VLAN. Pour spécifier l'ensemble des adresses dans un VLAN, il faut utiliser les adresses **subnets**.

##### Plan d'ACL proposé

|#|Règle|Description|
|---|---|---|
|1|Isolation globale|Isoler tous les VLAN entre eux|
|2|Accès interne|Autoriser les VLAN internes|
|3|AD DS|N'autoriser que les ports utiles du VLAN 20 (serveurs Active Directory)|
|4|DMZ|Isoler la DMZ du LAN|
|5|IT|Donner des autorisations au VLAN 30 (IT) pour administrer les serveurs|
|6|DMZ → réseau|Donner l'accès au réseau des VLAN au serveur DMZ|

> La segmentation en VLAN du réseau facilite grandement l'administration des firewalls et permet de définir proprement les règles sans contraintes physiques.

#### IPS / IDS — Suricata

Dans PfSense, le package **Suricata** peut être installé. Il sert à bloquer les IP suspectes et à surveiller les charges réseau.

![[suricata.png]]

> Description Figure:_Capture d'écran de l'interface Suricata intégrée dans PfSense_

---

### 2.2.6 Les GPO (Group Policy Objects)

Une GPO a été mise en place pour le changement du fond d'écran afin de vérifier le bon fonctionnement.

![[gpo_ecran.png]]

> Description Figure:_Un exemple de GPO appliquée à l'ensemble de la forêt qui change le fond d'écran_

> [!TIP] **Pistes d'amélioration :** Les GPO constituent un projet à part entière. Il aurait fallu déterminer les objectifs de sécurité et établir une liste de politiques à appliquer, notamment pour restreindre l'accès à certaines ressources (terminal, etc.), faire des changements de mots de passe, ou ajouter une icône de stockage sur le bureau. Cela pourrait être agrégé dans un script Python générant des commandes PowerShell telles que `New-GPO`.

---

## 2.3 Les difficultés rencontrées

- **Manque de ressources RAM** — frein majeur, provoquant régulièrement des **Kernel Panic**.
- **Temps limité** — contrainte qui a empêché l'approfondissement de certains aspects.
- **Technologies nouvelles** — KVM, Proxmox et PfSense étaient des outils non maîtrisés au départ.

![[Kernel_Panic.png]]

> Description Figure:_Kernel Panic signifiant un crash de la VM Proxmox_

---

# 3. Conclusion

Pour ce scénario, les connaissances fondamentales en réseaux, en sécurité et en gestion d'infrastructures ont été mobilisées. Grâce à la formation, il a été possible de mettre en place un Active Directory dans une situation concrète, des outils de virtualisation comme Proxmox et les best practices en termes de gestion et de sécurité.

> [!SUCCESS] **La maquette est fonctionnelle et prête à l'emploi.**

Sur un projet à long terme, il est suggéré de creuser plus en profondeur, notamment sur :

- La partie **automatisation**
- L'**inventaire**
- Le **firewall** et la définition des **GPO** pour limiter les accès non autorisés par les employés

---

# 4. Sources & Références

|Ressource|URL|
|---|---|
|Installation de KVM|https://linuxconfig.org/install-and-set-up-kvm-on-ubuntu-20-04-focal-fossa-linux|
|Installation de Proxmox|https://youtu.be/IX5EsbWd8qQ|
|Installation de VLAN|https://www.youtube.com/watch?v=t7qt1wlS9uA|
|Installation de DHCP|https://youtu.be/18g3IdIq87g|
|Installation de PfSense (vidéo)|https://www.youtube.com/watch?v=Vmd9Amz524U|
|Installation de PfSense (texte)|https://neptunet.fr/pfsense-install/|
|Installation de conteneur LXC|https://www.youtube.com/watch?v=CgfjMpO_wAo|
|Installation de DMZ|https://www.it-connect.fr/tuto-vmware-workstation-lab-virtuel-pfsense/|
|Configuration réseau Proxmox|https://pve.proxmox.com/wiki/Network_Configuration|