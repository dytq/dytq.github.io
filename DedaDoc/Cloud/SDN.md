---
title: Vers un réseau programmable, focus du contrôleur ONOS+P4
tags:
  - P4
  - Cloud
  - Network
  - ONF
  - ONOS
---
# Introduction

Pour "programmer un réseau", nous devons utiliser un système d'exploitation SDN, permettant de contrôler et de gérer un réseau à partir d'un contrôleur, ainsi qu'un langage de programmation pour définir différentes instructions et contrôler le plan de données. Dans notre cas, nous nous concentrons sur ONOS, un contrôleur SDN. Cet outil est un cas d'étude intéressant car il est Open Source, facilement accessible et installable, dispose de ressources pertinentes telles que des rapports IEEE, des conférences, etc. Il est également relativement mature, ayant environ une décennie d'existence, et peut être testé sans trop de difficultés moyennant des connaissances de base en Docker et en réseau. En tant que langage de programmation, nous utilisons le langage P4.

Ce chapitre est divisé en trois parties :

1. Présentation du contexte en mettant en avant l'ONF.
2. Étude approfondie de ONOS et de son architecture.
3. Analyse du langage P4 et du modèle PISA.

# 1. Présentation du projet ONF

Fondée par Nick McKeown et co-fondée par Scott Shenker en 2011, l'Open Networking Foundation (ONF) est une organisation qui rassemble divers logiciels open source, visant à ouvrir les logiciels réseau. Elle compte environ 200 membres, parmi lesquels des entreprises d'équipement réseau, des entreprises de semi-conducteurs, des sociétés de logiciels, des opérateurs télécoms, des exploitants de bases de données et d'hyperscale, ainsi que des entreprises utilisant ces logiciels. L'objectif principal de l'ONF est de travailler sur les SDN et de standardiser le protocole OpenFlow.

La figure suivante présente les différents projets de l'ONF, notamment le projet SMART-5G visant à intégrer l'apprentissage machine dans les réseaux 5G, des projets de cloudification et des projets de réseaux programmables avec ONOS et P4.

![[Pasted image 20260210153411.png]]

La partie que nous allons nous intéresser est la partie "Programmable Networks".

# 2. Présentation de ONOS

En collaboration avec ON.LAB, suivi par AT&T et NTT Communications, ONOS (Open Network Operating System) a vu le jour en 2014. Il s'agit d'un contrôleur open source conçu pour les architectures SDN, dont l'objectif principal est de résoudre les problèmes d'évolutivité, de disponibilité et de performances des réseaux modernes en constante évolution. Du fait de son architecture, ONOS répond aux besoins de disponibilité, de scalabilité, de modularité et à la distinction entre les protocoles agnostiques et spécifiques aux équipements et aux connexions, comme cela sera détaillé dans ce chapitre. ONOS peut être qualifié de système d'exploitation SDN, étant constitué d'une plateforme extensible et interchangeable, ainsi que d'un ensemble d'applications. Il offre également aux applications un certain nombre d'API de haut niveau installables directement depuis la plateforme, leur permettant ainsi d'accéder à l'état du réseau et de contrôler le flux de trafic dans les équipements.

## 2.1. Architecture de ONOS

Pour bien comprendre les concepts abordés par la suite, la figure ci-dessous résume en quelque sorte l'architecture générale du fonctionnement d'ONOS :

![[Pasted image 20260210153430.png]]

Dans ce modèle d'architecture, il est défini plusieurs couches différente que compose le logiciel:

**Les applications** sont des modules logiciels qui ajoutent des fonctionnalités spécifiques au système, comme le contrôle, la surveillance, la gestion ou l'optimisation des aspects du réseau. Ces applications sont installées en dehors du cadre d'ONOS ; elles s'exécutent au-dessus du cœur d'ONOS et doivent donc utiliser les interfaces NBI pour interagir et influencer le comportement du réseau. Comme application, on peut utiliser Mininet pour créer la topologie et les éléments virtuels en utilisant, par exemple, OVS (Open vSwitch) pour la virtualisation (composé de switch, host, controller) ou des équipements physiques.
![[Pasted image 20260210153529.png]]
**L'interface Northbound (NBI)** agit comme une passerelle qui permet aux applications de contrôle de transmettre leurs demandes et d'accéder aux fonctionnalités de gestion et de contrôle du réseau fournies par ONOS.

**Le couche "Distributed Core"** est le cœur de ONOS, les fonctionnalités centrales du système sont réparties sur plusieurs nœuds afin d'améliorer la performance, la redondance et la résilience du système de gestion réseau.

**L'interface Southbound** permet au logiciel de contrôle de prendre des décisions et de mettre en œuvre des politiques sur les équipements réseau. Elle collecte également des données sur l'état du réseau, contribuant ainsi à la gestion globale et au contrôle des opérations réseau.

**La couche physique** représente la composante matérielle.

À noter que le flux circule à la fois "vers le bas" et "vers le haut" à travers ONOS. Des applications peuvent utiliser l'interface NBI d'ONOS pour contrôler le réseau, tandis que des plugins au niveau du SBI transmettent des informations sur le réseau sous-jacent jusqu'au cœur d'ONOS.

Ces interactions entre le cœur d'ONOS et les dispositifs réseau sont gérées par un ensemble d'adaptateurs (par exemple, OpenFlow, P4Runtime) qui dissimulent les détails de la communication avec les équipements, isolant ainsi le cœur d'ONOS et les applications qui s'exécutent au-dessus de lui. Cette isolation offre une certaine flexibilité permettant de contrôler une diversité de dispositifs réseau, qu'il s'agisse de commutateurs propriétaires, de commutateurs "bare-metal", de dispositifs optiques ou de stations de base.

## 2.2 Descriptions des différentes couches de ONOS

### Northbound (NBI)

Dans cette section, nous explorerons plus en détail l'architecture du NBI. Cette couche permet aux applications de recevoir des informations sur l'état du réseau (par exemple, explorer la topologie du graphique, intercepter les paquets réseau) et de contrôler le plan de données du réseau (par exemple, programmer des objectifs de flux via l'API FlowObjective).

#### Composition du NBI

Le NBI d'ONOS se compose de plusieurs parties :

- Une API correspondante est dédiée à chaque service inclus dans une configuration spécifique d'ONOS.
- L'interface programmatique Atomix (cf : Distributed Core) permet aux applications de définir et d'utiliser leurs propres tables.
- Les interfaces gNMI et gNOI sont définies indépendamment d'ONOS mais sont prises en charge en tant que composantes du NBI.
- ONOS offre un ensemble d'interfaces pour contrôler les commutateurs sous-jacents, comme le montre la figure suivante que nous détaillerons.
![[Pasted image 20260210153611.png]]
#### Intent

Propose un moyen indépendant de la topologie pour établir des flux à travers le réseau. Les spécifications de haut niveau, appelées "intent", indiquent divers indices et contraintes pour définir le chemin de bout en bout, incluant le type de trafic, les hôtes source et destination, ou encore les ports d'entrée et de sortie pour solliciter une connectivité. Ce service met en place cette connectivité en utilisant les chemins appropriés, puis surveille de manière continue le réseau, ajustant les chemins au fil du temps afin de maintenir la conformité avec les objectifs définis par l'intention face à des conditions réseau changeantes.

#### Flow Rules

Les FlowRules fournissent une paire de correspondance/action centrée sur l'appareil pour programmer le comportement de transfert du plan de données d'un appareil. Cela nécessite que les entrées des FlowRules soient composées conformément à la structure des tables et aux capacités du pipeline de l'appareil.

#### Flow Objective

Le FlowObjective fournit une abstraction centrée sur l'appareil pour programmer le comportement de transfert d'un appareil de manière indépendante du pipeline. Il s'appuie sur le sous-système Pipeliner (voir la section suivante) pour mettre en œuvre la correspondance entre les objectifs de flux indépendants de la table et les règles ou groupes de flux spécifiques à une table. Le FlowObjective service permet de programmer les règles de flux du plan de données indépendamment de la configuration spécifique des tables de pipeline de l'appareil.

On détermine trois types de FlowObjective :
![[Pasted image 20260210153638.png]]
- Le **Filtering** détermine si le trafic doit être autorisé ou non à entrer dans le pipeline, sur la base d'un sélecteur de trafic.
- Le **Forwading** détermine quel trafic doit être autorisé à sortir du pipeline, généralement en faisant correspondre des champs sélectionnés dans le paquet avec une table de transfert.
- Le **Next** indiquent le type de traitement que le trafic doit recevoir, par exemple la manière dont l'en-tête doit être réécrit.

Par exemple, l'objectif Filter peut spécifier que les paquets correspondant à une adresse MAC, une balise VLAN et une adresse IP particulières sont autorisés à entrer dans le pipeline. L'objectif Forwading correspondant recherche ensuite l'adresse IP dans une table de routage, tandis que l'objectif Next réécrit les en-têtes si nécessaire et affecte le paquet à un port de sortie.

Ces trois étapes ne dépendent évidemment pas de la combinaison exacte des tables du commutateur sous-jacent utilisées pour mettre en œuvre la séquence correspondante de paires match/action. Le défi consiste à faire correspondre ces objectifs agnostiques aux pipelines avec les règles correspondantes dépendantes des pipelines.

La figure suivante montre comment, dans ONOS, ce mappage est géré par le service FlowObjective. Pour des raisons de simplicité, l'exemple se concentre sur le sélecteur (match) spécifié par un objectif de filtrage. L'essentiel est d'exprimer le fait que vous souhaitez sélectionner une combinaison particulière de port d'entrée, d'adresse MAC, de tag VLAN et d'adresse IP, sans tenir compte de la séquence exacte des tables de pipeline qui implémentent cette combinaison.
![[Pasted image 20260210153654.png]]
#### Le Pipeliner

Le Pipeliner permet de définir un modèle de pipeline pour chaque commutateur cible. Il cible chaque pilote spécifique pour déployer les instructions de flux vers le commutateur. Ainsi, il agit comme un traducteur spécifique au pipeline, permettant de mapper les FlowObjectives dans le pipeline cible. (Un exemple est donné dans la partie P4)

### SouthBound (SBI)

Une interface Southbound (SBI) est constituée de plugins comprenant des bibliothèques de protocoles partagées et des pilotes spécifiques à chaque périphérique. Ces plugins se déclinent en deux types : les fournisseurs de protocoles (Protocol Providers) et les pilotes de périphérique (Device Drivers)

#### Protocol Providers

ONOS définit un cadre de plugin qui définit une API orientée vers le réseau. Chaque plugin, appelé Protocol Provider, sert de proxy entre le SBI et le réseau sous-jacent, où il n'y a pas de limitation sur le protocole de contrôle que chacun peut utiliser pour communiquer avec le réseau. Les fournisseurs s'enregistrent eux-mêmes dans le cadre des plugins SBI et peuvent commencer à agir comme un conduit pour transmettre des informations et des directives de contrôle entre les applications ONOS et les services de base (en haut) et l'environnement réseau (en bas), comme illustré dans le schéma suivant:

![[Pasted image 20260210153714.png]]

La figure montre deux types principaux de plugins Provider. Le premier type est spécifique à un protocole, comme OpenFlow et gNMI, qui sont des exemples courants. Chacun de ces fournisseurs associe l'API au code qui implémente le protocole correspondant. Le second type, incluant DeviceProvider, HostProvider et LinkProvider, interagit indirectement avec l'environnement en utilisant un autre service fourni par ONOS.

#### Device Drivers

Le cadre SBI, en plus d'isoler le noyau des spécificités du protocole, supporte également les plugins Device Drivers. Ces plugins agissent comme une méthode pour séparer le code (y compris les fournisseurs) des variations propres à chaque appareil. Un pilote de périphérique se compose de modules, chacun responsable de la mise en œuvre d'une fonctionnalité spécifique de contrôle ou de configuration. Comme pour les fournisseurs de protocole, aucun carcan n'est imposé quant à la façon dont un pilote de périphérique met en œuvre ces capacités. Les pilotes de dispositifs sont eux aussi déployés en tant qu'applications ONOS, ce qui leur permet d'être ajoutés ou retirés dynamiquement. Cela offre aux opérateurs la possibilité d'intégrer de nouveaux types et modèles de dispositifs à tout moment.

### Distributed core

Le cœur d'ONOS est constitué de divers sous-systèmes, chacun dédié à un aspect spécifique de l'état du réseau, comme la topologie, le suivi des hôtes, l'interception de paquets et la programmation des flux. Chaque sous-système maintient sa propre abstraction de service, permettant à son implémentation de diffuser l'état à travers l'ensemble du cluster.

De nombreux services d'ONOS reposent sur l'utilisation de tables distribuées, construites à l'aide de structures clé-valeur distribuées telles qu'Atomix. Cet ensemble de tables définit la sémantique des clés qu'il stocke ainsi que les types de valeurs associées. C'est ce modèle de données qui caractérise ONOS en tant que système d'exploitation réseau. Ce concept s'étend sur un réseau distribué de serveurs et met en œuvre un algorithme de consensus tel que Raft pour assurer la résilience aux pannes en cas de défaillance.

Cette approche distribuée est un paradigme de conception courant, permettant à ONOS d'être à la fois scalable, capable de gérer une charge de travail croissante via un nombre suffisant d'instances virtualisées, et hautement disponible, garantissant la continuité du service même en cas de défaillance d'une partie du système.

# 3. Présentation du langage P4

Dans cette section, nous allons présenter l'un des outils que nous utiliserons pour programmer le réseau : P4.

## 3.1 Présentation du projet

P4, créé en 2013, est un langage de haut niveau conçu pour opérer sur des outils réseau tels que des commutateurs, des cartes réseau, des routeurs, etc. Ce langage peut être implémenté sur divers supports tels que des cartes réseau, des FPGA, des commutateurs logiciels et du matériel ASIC. En résumé, P4 est utilisé pour fournir une description statique du réseau.

## 3.2 Compilateur

La figure suivante montre l'évolution du langage depuis sa création:

![[Pasted image 20260210153736.png]]

Le compilateur, appelé p4c ([https://github.com/p4lang/p4c](https://github.com/p4lang/p4c)), est un logiciel open source sous licence Apache 2, développé par le "P4 Language Consortium" ([https://github.com/p4lang/](https://github.com/p4lang/)). Il propose différents back-ends pour s'adapter à divers usages :

- **p4c-bm2-ss** qui peut transformer le code source en un modèle de comportement qui nous seront utile pour l'utiliser avec ONOS.
- **p4c-ebpf**, qui peut transformer le code source en code C qui peut être ensuite compilé par ebpf. Ebpf est une mini machine virtuelle dans laquelle on peut récupérer des informations du noyau (unix), elle succède au bpf. Il y a aussi p4c-ubpf pour que l'ebpf s'exécute dans l'espace utilisateur.
- **p4c-graph** permet de convertir le code source en Graphiz pour voir les différentes connexions entre les modules.

## 3.3 Objectif d'utilisation

Pour mieux comprendre l'objectif de P4, il est nécessaire d'examiner l'évolution de la "softérisation" des réseaux.

Initialement, dans un réseau que l'on pourrait qualifier de "traditionnel", les fonctions étaient fixes (dédiées à des tâches spécifiques, avec une logique orientée "hardware"), ce qui les rendait peu flexibles. Cette rigidité dans l'évolution à long terme entraînait des coûts plus élevés, notamment liés à l'extension et à l'évolution croissante du réseau.

Par la suite, l'introduction du SDN a apporté des changements, comme expliqué dans les chapitres précédents (notamment avec le protocole OpenFlow). Avec le SDN, le plan de contrôle est programmable, mais l'accès à la programmation directe dans le plan de données n'était pas possible. C'est à ce moment que P4 a introduit une innovation en rendant la programmation dans le plan de données possible.

La figure ci-dessous illustre l'évolution d'un réseau traditionnel vers un réseau programmable:

![[Pasted image 20260210153801.png]]

Et donc pour rendre programmable le plan de données, on utilise un programme pipeline en .p4 pour exécuter du code dans le plan de données:

![[Pasted image 20260210153812.png]]

Grâce à la programmation sur le plan de données, P4 offrent plusieurs avantages:

- Une meilleure flexibilité des 7 couches réseau du modèle OSI ou aux 5 couches TCP/IP.
- Va nous permettre de mieux gérer les mises à jour du matériel, en ayant la possibilité d'exploiter au mieux le hardware (ajout de fonctions, modification des protocoles…)

## 3.4 Architecture du langage

P4 repose sur le protocole PISA (Programming Protocol-Independent Packet Processors), qui permet de contrôler le SDN via les protocoles P4 Runtime. La figure présente l'architecture globale du contrôle, ce qui sera utile pour comprendre la structure globale.

![[Pasted image 20260210153828.png]]

Le compilateur P4 génère deux fichiers à partir du programme P4 : l'un spécifiant le plan de données et l'autre décrivant les tables contenant les clés associées aux actions ou aux données. En utilisant P4 Runtime, il devient possible d'interagir avec ces données en transmettant des instructions au plan de données pour modifier les éléments de la table.

Pour comprendre l'architecture, concentrons-nous sur ce qui se déroule au niveau du plan de données:
![[Pasted image 20260210153850.png]]
PISA est la composante chargée du traitement des paquets. Elle englobe le Programmable Parser, le Match-Action Pipeline programmable et le Deparser programmable.

## 3.5 Programmable Parser

Le rôle du parser dans le processus consiste à définir la structure des en-têtes présents dans les paquets réseau et à les analyser. Il agit essentiellement comme une machine à états, traitant chaque en-tête en suivant un ensemble de règles définies dans le programme P4. Le parser décompose les paquets en différentes parties, identifiant chaque en-tête et ses informations associées, ce qui permet au système de comprendre et de manipuler les données du paquet selon les directives fournies dans le programme.

## 3.6 Le Programmable match-action Pipeline

Elle effectue des opérations sur les en-têtes des paquets ainsi que sur les résultats intermédiaires. Une étape de match-action comprend plusieurs blocs de mémoire tels que des tables et des registres, ainsi que des unités arithmétiques et logiques (ALU), permettant ainsi d'exécuter des recherches et des actions simultanées. Étant donné que certains résultats d'actions peuvent être nécessaires pour des traitements ultérieurs, créant ainsi des dépendances de données, les étapes sont organisées de manière séquentielle pour assurer une exécution ordonnée.

### Programmable Deparser

Le Deparser assemble les en-têtes des paquets et les sérialise en vue de leur transmission. Un dispositif PISA est indépendant du protocole.

###  Les clés (Key), dans la table

Le programme P4 définit le format des clés utilisées pour les opérations de recherche. Ces clés peuvent être formées à partir des informations présentes dans l'en-tête du paquet. Le plan de contrôle remplit les entrées de la table avec les clés et les données d'action. Les clés contiennent des informations relatives au paquet, telles que l'adresse IP de destination, tandis que les données d'action définissent les opérations à effectuer, comme le port de sortie.

# 3.7 Architecture P416

Les deux étapes importantes que P4 va pouvoir agir, est au niveau de l'Ingress (le trafic entrant) et l'Egress (trafic sortant).

La figure ci-dessous montre comment se déroule les différentes étapes de traitement dans le plan de données:

![[Pasted image 20260210153909.png]]

Nous aurons l'occasion d'entrer plus en détail dans la prochaine partie.

## 3.8 Structure du langage

Dans cette section, nous examinerons les différentes parties du code P4. P4 est organisé en blocs, et chacun de ces blocs agit à différentes étapes du traitement des données.

### Composition d'un code

**[Header]** Une définition d'en-tête qui décrit la séquence et la structure d'une série de champs. Elle comprend la spécification des largeurs de champs et des contraintes sur les valeurs des champs.

**[Parser]** Une définition d'un analyseur qui spécifie comment identifier les en-têtes et les séquences d'en-têtes valides dans les paquets

**[Table]** Les tables match+action sont le mécanisme permettant d'effectuer le traitement des paquets. Le programme P4 définit les champs sur lesquels une table peut correspondre et les actions qu'elle peut exécuter

**[Action]** P4 supporte la construction d'actions complexes à partir de primitives plus simples, indépendantes du protocole. Ces actions complexes sont disponibles dans les tables match+action

**[Deparser]** Cela sérialise les en-têtes modifiés de retour dans le paquet alors que celui-ci se déplace d'un commutateur à un autre. La fonction considère le variable "packet-out" et les valeurs d'en-tête comme deux arguments dans le pipeline.

**[Control Program]** Le programme de contrôle détermine l'ordre des tables match+action qui sont appliquées à un paquet. Un programme impératif simple décrit le flux de contrôle entre les tables match+action

Cette figure ci-dessous, montre l'implication des différents blocs dans le processus de traitement:

![[Pasted image 20260210153921.png]]

# 4. Utilisation de P4 dans ONOS

ONOS a été construit autour de OpenFlow, il n'en reste néanmoins la possibilité d'utiliser P4Runtime à la place.

## 4.1 P4 RunTime

En résumé, le processus se présente ainsi : l'utilisateur compile son programme P4, créant ainsi un fichier contenant le modèle de comportement (behavior model) et les tables d'architecture (par exemple, v1model pour ONOS). Ces tables servent à l'utilisateur afin de déterminer les informations nécessaires pour spécifier la manière dont il va programmer les données.

Pour programmer ces données, l'utilisateur se servira de P4 Runtime, lui permettant de modifier les tables depuis le plan de contrôle. Par exemple, il peut utiliser P4Runtime Shell ([https://github.com/p4lang/p4runtime-shell](https://github.com/p4lang/p4runtime-shell)). La figure ci-dessous illustre comment l'utilisateur interagit dans le réseau :

![[Pasted image 20260210153933.png]]

## 4.2 Pipeline

Nous avons introduit les notions de FlowObjective Service et de FlowRule Service dans le chapitre sur ONOS. Voyons maintenant leur utilité et leur rôle au niveau du pipeline lors de la programmation d'un réseau.

Pipeconf permet la création d'un pipeline. Il extrait des informations du fichier .p4info, lequel contient des métadonnées spécifiant les entités P4 accessibles via P4Runtime. Ces entités correspondent exactement aux objets instanciés dans le code source P4, produit par le compilateur P4.

Le v1model.p4 est le modèle d'architecture P4 défini par ONOS. Il doit être pris en compte lors de la programmation du plan de données et du plan de contrôle à l'aide de FlowObjective. En termes de programmation, les FlowObjective sont une structure de données accompagnée de routines de construction associées. L'application de contrôle établit une liste de spécifications et les transmet à ONOS pour qu'elles soient exécutées. Ainsi, les pipeliners peuvent faire correspondre les FlowObjective aux FlowRules (dans le cas des pipelines à fonction fixe) ainsi qu'aux pipelines programmés par P4.

Voici comment cela se présente :

![[Pasted image 20260210153948.png]]

Et ce qu'il sera envoyé ça sera un P4Runtime protobuf à l'équipement.

# Sources

## ONF

- [https://opennetworking.org/](https://opennetworking.org/)

## ONOS

- [https://wiki.onosproject.org/](https://wiki.onosproject.org/)
- [https://opennetworking.org/onos/](https://opennetworking.org/onos/)
- [https://www.hsc.com/resources/blog/sdn-based-networks-for-internet-of-things-how-onos-helps/](https://www.hsc.com/resources/blog/sdn-based-networks-for-internet-of-things-how-onos-helps/)
- [https://sdn.systemsapproach.org/onos.html](https://sdn.systemsapproach.org/onos.html)
- [https://api.onosproject.org/2.1.0/apidocs/](https://api.onosproject.org/2.1.0/apidocs/)

### Pour aller plus loin concernant le monitoring dans ONOS

W. Kim, J. Li, J. W. -K. Hong and Y. -J. Suh, "OFMon: OpenFlow monitoring system in ONOS controllers," 2016 IEEE NetSoft Conference and Workshops (NetSoft), Seoul, Korea (South), 2016, pp. 397-402, doi: 10.1109/NETSOFT.2016.7502474.

## P4

- [https://staging.p4.org/p4-spec/docs/P4-16-v1.2.2.html](https://staging.p4.org/p4-spec/docs/P4-16-v1.2.2.html)
- An Exhaustive Survey on P4 Programmable Data Plane Switches: Taxonomy, Applications, Challenges, and Future Trends
- A Survey on P4 Challenges in Software Defined Networks: P4 Programming
- P4: Programming Protocol-Independent Packet Processors
- PISA: [https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8659749/](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8659749/)
- [https://p4.org/](https://p4.org/)
- [https://p4.org/d904ffd6-2361-489d-b122-118b4dd286f9](https://p4.org/d904ffd6-2361-489d-b122-118b4dd286f9)
- [https://p4.org/p4-spec/p4runtime/main/P4Runtime-Spec.html#proto](https://p4.org/p4-spec/p4runtime/main/P4Runtime-Spec.html#proto)