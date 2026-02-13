---
title: L'AMF au Cœur du réseau 5G
tags:
  - 5G
  - AMF
  - 3GPP
  - mobile_network
author: Taariq Dedarally
date: December 2024
---
# Introduction

Nous allons introduire les différentes fonctionnalités de l'AMF, nous allons expliquer comment l'AMF permet l'accessibilité d'un mobile au cœur du réseau. L'idée ici est de donner une première approche afin de mieux aborder le chapitre sur les services et procédures.

L'accessibilité comprend plusieurs problématiques, notamment l'établissement et la sûreté des terminaisons afin que les liaisons entre le mobile et le réseau ne soient pas corrompues, ensuite la gestion du mobile dans le réseau, c'est-à-dire l'accès et la gestion des différents services, gérer sa localisation pour faire du roaming, de l'handover, mais aussi gérer l'accès nécessite de pouvoir contrôler qui entre et garantir l'équilibre du réseau. L'AMF doit aussi permettre la retransmission des données vers les autres fonctionnalités du mobiles et inversement, par exemple la transmission du flux QOS qui est géré par le SMF. De plus, la 5G a introduit la notion du "network slicing", qui permet d'établir en différents flux différents services. Elle est gérée principalement par le NSSF mais l'AMF doit gérer son accès et sa congestion.

D'autant plus, l'AMF contient aussi des adaptabilités afin de réduire la consommation de données et optimiser le réseau. C'est notamment le cas pour la gestion de l'IOT mais aussi des mécanismes de discontinuité de connexion pour économiser la batterie du mobile par exemple (DRX).

On commencera notre chapitre par l'étude des terminaisons et de l'accès réseau, puis par la gestion de l'accès au réseau, ensuite par les données transportées à travers l'AMF, le paramétrage de l'AMF et enfin par l'optimisation de l'accès.

Les sources principaux utilisées dans cette partie sont, la `3GPP TS 23.501 version 16.18.0 Release 16` sur l'architecture et système et puis `A Reliable AMF Scaling and Load Balancing Framework for 5G Core Networks`.

## Méthode d'accès

Dans cette partie nous allons traiter de la problématique suivante: Comment on accède au réseau ? Déjà, avant de répondre à cette problématique, nous avons vu en introduction que l'AMF est connecté avec différents points de connexions dont certains permettent de lier l'AMF aux terminaisons. Ensuite pour accéder au réseau, il est essentiel de sécuriser ces points de connexions, dont nous allons analyser l'utilité et comment l'AMF opère t-elle. Un autre point que nous allons étudier c'est pour le cas du "network slicing" et sur les méthodes accessibilité de l'AMF.

### Terminaisons

Une Terminaison est l'ensemble des équipements mobile ou en charge de la gestion de la mobilité qui va interagir avec le réseau cœur, sous forme de PDU (paquets contenant les données standardisées dans la 5G). L'objectif de l'AMF c'est de permettre l'accès à l'intercommunication et l'accès des données, des mobiles.

La figure ci-dessous illustre les terminaisons reliées à l'AMF. L'UE et le NG-RAN sont des équipements 3GPP standardisé et le N3IWF et TNGF sont des équipements Non3GPP non standardisé.
![[terminaison.svg]]

#### Terminaisons 3GPP

Commençons par le point de connexion N1. Il s'agit d'un point de connexion virtuelle qui permet la gestion de l'UE (User Equipement). Il interagit avec le NAS (Non Acess Stratum) qui est la couche protocole du réseau 5G. Le rôle de l'AMF est de garantir le chiffrement et l'intégrité des données du NAS.

L'interface N2 est la liaison entre l'UE et la station gNodeB ou RAN (Radio Acess Network). L'UE se connecte au RAN pour établir suivant le plan de contrôle comme montré dans la figure ci-dessous.
![[plan_control.png]]

On peut aussi noter que ces stations de bases peuvent être *cloudifier* comme montré dans cette figure ci-dessous.
![[cloud_ran.png]]

Cette virtualisation permet de regrouper dans un seule unité centrale les processus de coordination et de calcul et de gérer des connexions lointaines lentes.

#### Terminaison Non-3GPP

L'AMF supporte l'accès Non-3GPP (Non-Third Generation Partnership Project) qui permet aux appareils et au service de se connecter au réseau mobile tout en utilisant d'autres technologies ou protocoles qui ne sont pas nativement conformes aux normes 3GPP (wifi par exemple).

Nous avons des composants Non-3GPP supporté par l'AMF, comme par exemple le N3IWF/TNGF. L'exemple illustré ci-dessous est le réseau satellitaire, ou c'est le N31WF ou TNGF qui réceptionnent les données mobiles de l'UE.
![[non3gpp.png]]

L'AMF supporte les procédures et les échanges d'informations avec les équipements Non-3GPP. Certaines procédures diffèrent et l'enjeu de l'AMF c'est de s'adapter à ces équipements afin de leur garantir l'accès au réseau et aux services. Ainsi l'AMF doit être capable de les identifier et authentifier mais que certaines applications ne sont appliqués car incompatibles avec les Non-3GPP.

Le N3/WF Non-3GPP InterWorking Function est une fonction du réseau 5G qui facilite la connectivité et l'interopérabilité entre les appareils ou les services qui utilisent des technologies Non-3GPP et le réseau 5G. Il est dit untrusted (non fiable).
![[image.png]]

Tandis que le TNGF joue le même rôle que le N3IWF mais il est dit trusted (fiable).

![[trustedn3gpp.png]]

### La Sécurité dans l'AMF

Comme nous l'avons évoqué plus tôt, l'AMF gère des terminaisons. Afin de garantir la sécurité de ces terminaisons, l'AMF doit être en mesure de sécuriser la transmission de données. Pour cela, l'AMF garantit trois axes principaux de sécurité tel que:

- **La confidentialité des données**, en utilisant les protocoles de chiffrements le NEA0, 128-NEA1, 128-NEA2 et peut supporter l'algorithme de chiffrement 128-NEA3.
- **L'intégrité des données**, en utilisant les protocoles de chiffrements le NIA-0, 128-NIA1, 128-NIA2. L'AMF supporte aussi le 128-NIA3.
- **L'authentification** qui est géré par le **SEAF** (Security Anchor Authentification Function). Dans la spécification 3GPP, le SEAF est un module qui se trouve dans l'AMF. Pour pouvoir authentifier un UE, elle a besoin de récupérer le 5G-GUTI ou SUCI de l'UE et le transférer vers l'AUSF/UDM. L'authentification est un sujet a part entière que nous n'aborderons pas dans ce papier.

À noter que les procédures de chiffrements sont expliqués dans la `TS 33 401` et les algorithmes sont expliqués dans la `TS 33.501`.

### L'identification 5G

Un des outils pris en charge par l'AMF pour identifier l'UE dans un réseau 5G cœur et le Globally Unique Temporary Identifiers (5G-GUTI) qui succède au GUTI du MME. C'est un identifiant temporaire qui sert à la sécurité du mobile, mais aussi contient des informations liées à sa gestion. Cet identifiant peut être assigné ou réalloué. La `TS 122 003` contient l'architecture en détail du GUTI, nous allons seulement résumer l'essentiel de son utilisation. Le GUTI est commun aux équipements 3GPP et Non3GPP et peut-être alloué n'importe quand. L'AMF peut appliquer un délai de mise à jour avec l'UE. En voici l'architecture:
![[GUTI.png]]

Voici les composant du 5G GUTI:

1. Les réseaux mobiles sont gérés par des opérateurs en zone géographique, afin de couvrir la voix et les données. Ces zones sont appelées PLMN (Public Land Mobile Network) et contiennent chacune un identifiant PLMN ID. L'identifiant PLMN ID est composée du MCC (Mobile Country Code) et du MNC (Mobile Network Code).

2. Le GUAMI (48 bits) (inclu le PLMN_ID) peut identifier un ou plusieurs AMF(s) interconnecter(s). La figure suivante permet de donner une illustration de son utilisation dans un réseau 5G est comment un réseau d'AMF s'organise. Le GUAMI est composé de L'AMF Region ID identifie une région, de L'AMF Set ID identifie de manière unique l'AMF Set sans l'AMF Region et de L'AMF pointeur (englobe l'AMF name qui désigne un FQDN (Fully Qualifed Domain Names, adresse constitué de plusieurs labels stockés dans un DNS server)) identifie un ou plusieurs AMF sans l'AMF Set.

3. Le 5G-TMSI identifie l'UE où le TMSI ((Temporary Mobile Subscriber Identity) est stocké dans la carte SIM du mobile.
![[guami.png]]

Les détails de l'architecture se trouvent dans la `TS 23.003 (2.11)`.

## Gestion d'accès

L'AMF s'occupe aussi de la gestion d'accès. Nous allons voir dans cette partie la part de l'AMF dans cette tâche et donc répondre à la problématique suivante: Comment l'AMF gère t-elle l'accès du mobile et des données du réseau 5G ?

Pour répondre à ce problème l'AMF doit intégrer des fonctionnalités qui permettent à répondre aux services demandés aux autres composants pour répondre aux exigences, aux attentes d'un réseau 5G. Comme exigence, on a déjà besoin de gérer un mobile au cœur du réseau et donc pour cela l'AMF doit pouvoir gérer, créer des sessions d'utilisateurs à travers des mécanismes d'enregistrement. Ensuite en matière de mobilité on doit être capable de déterminer sa localisation et de pouvoir gérer des infrastructures plus complexes (zone de recouvrement). Par la suite, on analysera comment l'AMF gère la facturation et qu'elle est son rôle en tant qu'élément d'accessibilité et de la gestion du Roaming. Puis on finit cette partie par la gestion des connexions en gérant l'accessibilité du réseau en cas de congestion et ou de redirection spécifique.

### Gestion de sessions, l'enregistrement

L'enregistrement est géré en partie par l'AMF qui l'abonné souhaite se connecter au réseau ou bien se maintenir. Cette étape le permet d'établir un contexte avec le réseau PLMN afin de recevoir les différents services nécessaires. Une fois enregistré, l'abonné est géré par l'UDM. Nous avons des différences d'enregistrement et de besoin entre les protocoles 3GPP et Non-3GPP et le tout c'est de pouvoir les coordonner. Nous verrons plus en détails l'enregistrement et son fonctionnement.

Nous n'allons pas entrer dans les détails du network slicing, il s'agit d'un sujet à part entière. Néanmoins, nous pouvons dire que l'AMF va gérer la procédure d'enregistrement pour trouver l'AMF qui supporte le Network Slices nécessaires. Les détails de l'enregistrement se trouvent dans la TS architecture qui parle de comment est configuré un NSSAI (Network Slice Selection Assistance Information) et du lien entre l'UE pour qu'elle obtienne les services.

### Localisation

L'AMF gère la partie localisation de la mobilité. Il permet de transporter des données de localisation, Location Services Messages (LMF) entre l'UE ou RAN. De plus, l'AMF est capable de gérer des zones de recouvrement, "Enhanced Coverage" (Zone de recouvrement). Dans un réseau 5G la zone de recouvrement est composé de Tracking Area, décomposé en gNodeB (gNB). Les zones sont gérées par l'AMF afin d'optimiser la recherche de localisation et le paging d'un abonné. L'UE n'est pas constamment connecté à l'UE, quand elle cherche à obtenir des services du réseau cœur, elle doit passer par une étape d'abonnement, enregistrement au réseau. On rappelle que l'UPF est en charge du user plane. Si les données rentrent dans l'UPF, l'AMF va être informé et va pouvoir savoir dans quelle zone l'UE se trouve, ce qui facilite la recherche de localisation. Ça évite d'aller dans chaque gNB. La figure ci-dessous montre les différentes zones de localisation connecté au réseau coeur de la 5G.
![[tai.png]]

À noter que les données sont sauvegardées dans des TAI list. L'architecture du TAI est composé du MCC, MNC et TAC (TAC est le Tracking Area Code qui identifie la zone de localisation dans le PLMN) L'architecture se trouve dans la `TS 123 003`.

### Roaming

L'AMF s'occupe de normaliser la constitution du roaming (si le mobile peut faire du roaming) qui sera transmis entre le VPLMN (Virtual Plan Mobile Network) et HPLMN (Home Plan Mobile Network). Le HPMN peut vérifier que l'UE est présent et envoyé une requête de service depuis le VPMN. C'est pour faciliter le roaming et de prévenir la fraude. En voici son architecture:
![[roaming.png]]

### Facturation (Charging)

La facturation (charging) consiste à collecter les données afin d'établir une facture pour les utilisateurs du réseau. Dans un premier temps, on verra le rôle de l'AMF en cette tache, puis le cas du roaming. La `TS 32.240` donne en détail principe du charging et la `TS 32.256` montre les interactions des fonctionnalités.

#### Données de Facturation

L'objectif de l'AMF est de rassembler une collection de données afin de permettre la facturation, il propose donc une interface. Les données transmissent concerne le gestionnaire d'enregistrement, le gestionnaire de connexion et le suivit de la localisation, applicable seulement pour le NG-RAN.

L'une des fonctions qui va nous intéresser est le Charging Function(CHF). est sélectionné par l'AMF durant le processus d'enregistrement et suit les options suivantes: (les adresses CHF sont fournies par le PCF faisant partie de l'accès et les informations lié à la politique de contrôle) l'UDM donne les caractéristiques de la facturation, le NRF, AMF va localement apporter les caractéristiques de la facturation. C'est l'opérateur qui décide des options de politiques.

Une fois les CHF adresses ils peuvent être utilisés tout au long l'UE est enregistré dans l'AMF.

Pour que l'AMF puisse établir une facturation du mobile, il faut:

- L'AMF est capable de converger du mode online et offline lors de l'utilisation de la facturation. (Le mode online et offline est défini dans la `TS 32.240`).
- l'AMF collecte les données de facturation par enregistrement à l'UE dans le réseau coeur.
- L'AMF collecte les données de facturation par UE venant d'une connexion N2 entre le réseau 5G et l'AMF.
- L'AMF collecte les données de facturation par UE selon sa localisation.

Dans cette partie on va analyser le rôle de l'AMF dans le processus de la facturation. En voici l'architecture globale:
![[amf_facturation.png]]

On a:

- CHF (Charging Function) qui est la fonctionnalité du charging
- CTF (Charging Trigger Function)
- CGF(Charging Gateway Function)
- BD (Billing Domain)
- Bam: point de référence entre pour le transfert du fichier CDR venant d'une connexion 5G et la mobilité CGF au BD.
- Nchf: Service permettant de connecter le CHF.
- Ga: Point de référence pour le transfert CDR entre le CDF et le CGF.

#### Architecture de la facturation avec Roaming

Les informations de la génération de la facturation est envoyés au HPLMN pour le Monitoring Event Reports. Lors d'un roaming, l'AMF va collecter les informations de facturation pour chaque "roamer" qui s'enregistre dans le réseau 5G.
![[facturation_roaming.png]]

On a:

- N41 Reference point between AMF and the H-CHF
- N42 Reference point between AMF and the V-CHF

### Gestion de connexions/sessions - Load Balancing et Congestion Management

L'AMF en tant que gestionnaires d'accessibilité, il va devoir gérer la gestion des connexions, en autorisant ou pas de nouvelles entrées en fonction de la congestion, mais aussi de permettre l'équilibrage du réseau entre les AMF (faire des redirections vers les autres AMF) ou bien que l'UE spécifie un AMF en particulier, par exemple pour le cas du Network Slicing, l'UE a besoin d'accéder à un Network Slices d'un autre AMF.

### NonStandalone

Non Standalone est le fait de faire fonctionner le réseau 5G au réseau 4G. Dans un réseau 4G, pour les échanges de données sont des EPS. Les Bearers ID identifie les EPS Bearer qui sont des tunnels qui lient l'UE au PDN. L'AMF peut allouer une EPS Bearer ID (EBI) pour l'interconnexion avec un réseau 4G.
![[eps.png]]

## Transport de données

L'AMF n'est pas seul tributaire dans le réseau, elle permet aussi de transférer des autres services vers extérieurs du réseau cœur, tels que des données de régulations, de messages et de gestions. Nous allons donc regarder quelles sont les données transportées. L'AMF permet le transfert de données comme:

- Le transfert transparent de SM (Short Message) pour le routage.
- Le transport de SMS (Short Message Service) entre l'UE et le SMSF, pour assurer les services.
- Le transport de SM (Short Message) entre l'UE et le SMF, pour assurer la gestion de sessions, le transfert du flux de la QOS par exemple.
- Le transport des LI (Lawful intercept) pour les évènements et les interfaces de l'AMF.

## Paramétrage de l'AMF

L'AMF est une fonctionnalité virtuelle dans laquelle on peut la paramétrer. Dans la figure ci dessous donne un exemple de paramétrage de l'AMF pour du matériel cisco.
![[parametter.png]]

## Optimisation

L'AMF va pouvoir gérer l'optimisation pour les CIoT (Cellular Internet of Think). L'objectif c'est de réduire l'impacte du User Plane et du Control Plane en réduisant la consommation d'énergie, minimisation de la latence etc... Un des mécanisme que l'AMF peut employer est la DRX (Discontinious Recepetion) qui permet d'améliorer la batterie de l'UE.