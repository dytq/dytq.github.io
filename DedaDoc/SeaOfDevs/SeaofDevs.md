---
title: Implémentation de MultiThreading en langage C
link: https://github.com/dytq/Projet-Sea-Of-Devs.git
tags:
  - C
  - MultiThread
---
## 1. Introduction

Ce rapport présente le développement d'un jeu de bataille navale en C, comprenant une gestion de carte, un système de placement de navires et une logique de jeu complète.

Le projet consiste en l’implémentation d’une bataille navale. Un nombre donné de joueurs, chacun représenté par un navire, doivent parcourir un océan à la recherche des autres pour
être le dernier survivant. La vie du navire est symbolisée par une valeur C appelée coque, et son endurance par une valeur K appelée kerosene. Chaque action effectuée par le navire aura une incidence sur sa coque et son kerosene. Si l’une de ces ressources vient à manquer, le navire coule. Le jeu fonctionne en tour par tour : durant un tour: 

(1) chaque joueur détermine la prochaine action à effectuer puis en informe le serveur ; 

(2) ce dernier effectue les actions en fonction de différents critères (priorité par exemple) ; 
(3) puis il informe les joueurs de leur nouvel état (nouvelles coordonnées, perte de points de coque ou de kerosene, etc.). 

Le jeu se termine lorsqu’il ne reste plus qu’un seul survivant, ou si un nombre de tours prédéfini a été atteint.

![[sod.png]]
## 2. Architecture du Projet

### 2.1 Structure des Fichiers

Le projet est organisé selon la structure modulaire suivante :

```
.
├── Makefile              # Gestion de la compilation
├── install.sh            # Script d'installation
├── main.c                # Point d'entrée du programme
├── gestiondujeu.c/h      # Logique principale du jeu
├── navalmap.c/h          # Gestion de la carte de jeu
├── nm_rect.c/h           # Gestion des rectangles/entités
├── liste_action.c/h      # Gestion des actions
├── se_fichier.c/h        # Sauvegarde/chargement de fichiers
├── fichier/              # Dossier de ressources
└── Sod                   # Exécutable final
```

### 2.2 Modules Principaux

#### **Module Naval Map** (`navalmap.c/h`)

Gère la carte de jeu, incluant :

- Initialisation de la grille
- Gestion des coordonnées
- Affichage de la carte

#### **Module Rectangles** (`nm_rect.c/h`)

Gère les entités rectangulaires sur la carte :

- Initialisation des entités
- Détection de collisions
- Placement des navires

#### **Module Gestion du Jeu** (`gestiondujeu.c/h`)

Contient la boucle principale et la logique du jeu :

- Tour par tour
- Gestion des IA
- Conditions de victoire

#### **Module Fichiers** (`se_fichier.c/h`)

Gestion de la persistance :

- Chargement de configurations
- Sauvegarde de parties

#### **Module Liste d'Actions** (`liste_action.c/h`)

Gestion des actions possibles :

- Historique des coups
- Actions disponibles

## 3. Implémentation

### 3.1 Point d'Entrée (`main.c`)

Le programme principal suit cette séquence :

```c
1. Validation des arguments (fichier de configuration requis)
2. Initialisation de la carte via initialisation_de_la_carte()
   - Initialisation de la bibliothèque Naval Map
   - Chargement des données depuis le fichier
   - Initialisation de la carte d'entités
3. Placement aléatoire des navires restants
4. Lancement de la boucle de jeu
5. Libération de la mémoire
```

**Fonction d'initialisation** :

```c
navalmap_t* initialisation_de_la_carte(navalmap_t* MAP, char* path)
```

- Charge les données de configuration
- Initialise les structures de données
- Prépare la carte pour le jeu

### 3.2 Gestion de la Compilation

Le `Makefile` définit deux cibles principales :

#### **Cible `lib`**

```makefile
gcc -g -c -fPIC *.c -g3 
ar rcs libnm.a *.o
```

- Compile tous les fichiers `.c` en objets relocalisables (`-fPIC`)
- Crée une bibliothèque statique `libnm.a`
- Active les symboles de débogage (`-g3`)

#### **Cible `debug`**

```makefile
gcc -g -o Sod main.c -L. -lnm -lm -g3 -pthread
```

- Compile l'exécutable `Sod`
- Lie avec la bibliothèque créée (`-lnm`)
- Lie avec la bibliothèque mathématique (`-lm`)
- Active le support multi-thread (`-pthread`)

## 4. Choix Techniques

### 4.1 Langage et Bibliothèques

- **Langage** : C (C99/C11)
- **Bibliothèques système** :
    - `unistd.h` : Opérations POSIX
    - `sys/types.h`, `sys/stat.h`, `fcntl.h` : Gestion de fichiers
    - `pthread` : Support multi-threading

### 4.2 Organisation Modulaire

Séparation claire des responsabilités :

- Interface/headers (`.h`)
- Implémentation (`.c`)
- Bibliothèque statique pour la réutilisabilité

### 4.3 Gestion de la Mémoire

- Allocation dynamique de la carte
- Libération explicite avec `free(MAP)`
- Prévention des fuites mémoire

## 5. Utilisation

### 5.1 Compilation

```bash
# Compilation de la bibliothèque
make lib

# Compilation de l'exécutable en mode debug
make debug
```

### 5.2 Exécution

```bash
./Sod <fichier_configuration>
```

**Exemple** :

```bash
./Sod fichier
```

### 5.3 Installation

```bash
chmod +x install.sh
./install.sh
```

## 6. Conclusion

Ce projet implémente un jeu de bataille navale fonctionnel en C avec une architecture modulaire claire. Le système de compilation avec bibliothèque statique permet une réutilisation facile du code. La gestion des fichiers permet de configurer différentes parties et de sauvegarder la progression.

Les fonctionnalités de base sont opérationnelles, mais des améliorations pourraient être apportées notamment au niveau de l'interface utilisateur et du placement manuel des navires.