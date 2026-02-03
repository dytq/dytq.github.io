---
title: Compte Rendu du Projet TER — IA Carcassonne
tags:
  - IA
  - Carcassonne
  - Minimax
  - Alpha-Beta
  - MonteCarlo
  - Cpp
  - Godot
---
# 1. Présentation du sujet

## 1.1 Rappel de l'énoncé

Le projet de recherche porte sur l'implémentation d'une IA appliquée au jeu **Carcassonne**. L'objectif est de créer un bot avec un bon niveau de jeu qui puisse prédire les coups de l'adversaire et réagir en conséquence. Le travail consiste à programmer une méthode d'évaluation du meilleur coup possible relativement aux interactions stratégiques avec un unique joueur adverse.

## 1.2 Travail à effectuer

Le travail à effectuer est principalement la création d'une IA capable de tenir tête à un joueur humain sur une partie de Carcassonne.

Le principe est, premièrement, de coder l'intégralité du jeu de Carcassonne de base : établir la liste des tuiles, déterminer toutes les possibilités de les assembler les unes aux autres, puis pouvoir compter les points afin qu'un joueur soit déclaré vainqueur.

Deuxièmement, il faut développer des stratégies utilisables par l'IA en se servant des règles du Carcassonne version 2 joueurs.

## 1.3 Plan du rapport

|Section|Description|
|---|---|
|Présentation du sujet|Introduction du sujet et du travail à effectuer|
|Présentation du jeu Carcassonne|Règles, matériel, mise en place et déroulement|
|Rappels théoriques|Types de jeux, algorithmes (Minimax, Alpha-Beta, MCTS, AlphaGo)|
|Travail effectué|Choix techniques, architecture, implémentation|
|Analyse des résultats|Évaluation de l'efficacité de l'IA|
|Conclusion|Bilan et pistes d'amélioration|
# 2. Présentation du jeu Carcassonne

## 2.1 Règles du jeu

Le Carcassonne est un jeu tour par tour de stratégie centré sur l'univers médiéval. Chevaliers, brigands, moines et paysans vous assisteront afin d'obtenir la mainmise sur la région de Carcassonne. Pour cela, vous devrez engager des partisans symbolisés par des **meeples**, que vous devrez placer judicieusement sur les tuiles qui composent le plateau.

À votre tour, vous devrez prolonger le plateau existant et décider de placer, ou non, un meeple sur l'un des éléments de la tuile. Un meeple peut être placé :

- Sur une **ville** → il devient un **chevalier** chargé de sa protection.
- Sur une **route** → un **brigand** qui veut escroquer les marchandises transitantes.
- Dans une **abbaye** → un **moine** assurant le contrôle de sa région.
- Sur un **pré** → un **paysan** pour pouvoir y cultiver.

Selon les choix du joueur adverse et de la disposition du plateau, vous devrez maximiser vos profits. Vous n'avez qu'un nombre limité de meeples, et il est possible d'empêcher un joueur de gagner des points selon les placements effectués.

> [!NOTE] Le jeu est conçu pour 2 à 5 joueurs. Ce projet se concentre uniquement sur la version à **2 joueurs**, avec une IA jouant contre un joueur humain.

## 2.2 Inventaire du matériel

Le jeu est composé de **72 tuiles** et de **5 meeples** de couleurs différentes (une couleur par joueur), avec pour chaque couleur **7 meeples** associés.

### Tuiles

Les tuiles sont des cartes où figure un paysage contenant des éléments comme des villes, des routes, une abbaye ou des plaines. Elles représentent un morceau du plateau et permettent de former la carte du jeu.

![[tuiles_plateau.png]]

> Figure: _L'ensemble des tuiles du jeu (256×256 px)_

### Meeples

Les meeples sont des jetons que l'on peut placer sur les tuiles. Ils prennent un rôle en fonction de l'élément situé sur la tuile. Par exemple, si un pion est placé sur une ville, il sera un chevalier.

![[meeples.png]]

> Figure: _L'ensemble des meeples — 7 meeples par couleur_

## 2.3 Déroulement du jeu

Le jeu se déroule essentiellement en 3 phases.

### Mise en place

On place la tuile de base au milieu du plateau, puis on distribue 7 meeples aux joueurs. Chaque joueur a une couleur de meeple propre et commence avec un score de 0.

![[tuile_de_base.png]]

> Figure: _Tuile de base : une route, un morceau de ville au nord et une plaine au sud_

### Déroulement d'une partie

Carcassonne est un jeu tour par tour. Les étapes à suivre à chaque tour sont :

1. **Piocher** — Le joueur pioche une tuile au hasard dans la pioche.
2. **Placer la tuile** — Parmi les emplacements disponibles, il place sa tuile côte à côte des tuiles déjà présentes. La tuile doit être sur un emplacement libre et cohérent (une route continue une route, une ville continue une ville, etc.). Le joueur peut effectuer des rotations.
3. **Placer un meeple (optionnel)** — Le joueur peut placer un meeple sur la tuile qu'il vient de placer, uniquement si aucun meeple n'est déjà présent dans la même zone d'élément.
4. **Compter les points** — Les points des joueurs sont évalués en fonction des conditions de complétion.

On passe au joueur suivant jusqu'à ce que la pioche soit vide.

## 2.4 Évaluation des scores

### Rôles et points des meeples

|Rôle du meeple|Type d'emplacement|Points en cours de jeu|Points en fin de jeu|
|---|---|---|---|
|Chevalier|Ville|2 points par tuile de ville|1 point par tuile de ville|
|Chevalier avec bonus de Blason|Ville avec Blason|4 points par tuile de ville avec blason|2 points par tuile de ville avec blason|
|Brigand|Route|1 point par route|1 point par route|
|Moine|Abbaye|9 points (1 par tuile voisine + 1 pour la tuile elle-même)|1 point par tuile voisine + 1 pour la tuile|
|Paysan|Plaine|∅|3 points par ville complète adjacente à la plaine|

> [!NOTE] Les paysans ne rapportent pas de points en cours de partie car ils ne sont évalués qu'en fin de partie.

### Conditions de complétion

Les conditions de complétion permettent le comptage de points durant la partie. En cas de plusieurs meeples dans une même zone, le joueur ayant le plus de meeples remporte les points. En cas d'égalité, tous les joueurs concernés gagnent les points.

|Classe du meeple|Condition de complétion|
|---|---|
|Chevalier / Chevalier avec bonus de Blason|Les villes doivent être fermées : fortifications sur toutes les bordures de la zone|
|Brigand|Les routes doivent se finir de bout en bout|
|Abbé|La tuile contenant l'abbaye doit être entourée de 8 tuiles|

### Évaluation finale

Pour attribuer les points restants, on compte l'élément où est placé le meeple et les tuiles voisines qui prolongent cet élément, même si la structure n'est pas terminée. Les points sont indexés selon le tableau ci-dessus (colonne « fin de jeu »).

Pour évaluer les points du **paysan**, on parcourt les zones couvertes (les plaines adjacentes). S'il y a des villes complètes adjacentes à la zone de plaine, le joueur gagne les points correspondants. Les villes non adjacentes ne rapportent rien.
# 3. Rappels théoriques

## 3.1 Types de jeux

La théorie des jeux est une approche mathématique dont l'objet est l'étude des avantages et inconvénieurs des choix possibles pour les protagonistes. Trois grands types de jeux sont identifiés :

### Jeux à connaissance parfaite

Les jeux où tous les joueurs disposent de toutes les informations décrivant l'état du jeu. L'exemple le plus fameux est les **échecs** : les deux joueurs voient l'intégralité du plateau, et aucune pioche n'introduit d'aléatoire.

### Jeux à somme nulle

Les jeux où le perdant ne peut pas perdre plus que ce que le gagnant gagne, et inversement. Le poker (sans ajout de jetons personnels) est un exemple de jeu à somme **non nulle** : le gagnant remporte ni plus ni moins que la mise.

### Jeux synchrones

Les jeux où tous les joueurs jouent en même temps sans connaître à l'avance les décisions de leurs adversaires. Le poker est un exemple : les joueurs découvrent les cartes jouées en même temps.

### Classification du Carcassonne

|Propriété|Carcassonne ?|Raison|
|---|---|---|
|Connaissance parfaite|❌ Non|La pioche introduit de l'aléatoire|
|Somme nulle|❌ Non|Les points gagnés par un joueur ne sont pas perdus pour l'autre|
|Synchrone|❌ Non|Les joueurs jouent chacun leur tour et observent les actions adverses|

## 3.2 Types d'IA et fonctionnement

### MiniMax

L'algorithme MiniMax met sous forme d'arbre tous les coups possibles puis réalise une évaluation de la position courante du joueur. Il explore l'arbre en profondeur et stocke les meilleurs états du jeu. L'arbre est composé de nœuds de types **Min** et **Max**.

Pour effectuer une recherche à une profondeur 2, on évalue le nombre de points que rapporte chaque coup et on retire, à chacun de ces coups, le nombre de points maximum que pourra obtenir l'adversaire au tour suivant.

![[Algo_MinMax.PNG]]

> Figure: _Pseudo-code de la fonction MiniMax_

**Exemple sur le morpion :** On énumère tous les coups possibles, puis tous les coups possibles de l'adversaire, etc. On obtient un arbre dont la racine représente l'état du jeu courant.

![[minimax_morpion.png]]

> Figure: _Schéma de l'algorithme Minimax sur le jeu du morpion_

On attribue des poids (réussite, défaite ou égalité) aux feuilles, puis on remonte les valeurs successivement vers les pères. Pour chaque couche, on cherche à **minimiser** les coups de l'adversaire et à **maximiser** les coups de l'IA.

> [!WARNING] Cet algorithme est assez coûteux : il doit sauvegarder tous les états du jeu. Pour un simple morpion de 9 cases, la complexité atteint déjà **9!**.

### Méthode Alpha-Beta

La méthode Alpha-Beta permet de ne pas évaluer des positions inutiles. Elle utilise l'algorithme minimax en **élagage** certaines branches à l'aide de la borne inférieure **α** et de la borne supérieure **β**.

![[Algo_AlphaBeta.PNG]]

> Figure: _Pseudo-code de la fonction Alpha-Beta_

### Monte Carlo Tree Search (MCTS)

Monte Carlo Tree Search est un algorithme de recherche probabiliste et heuristique pour la prise de décision. Son principe repose sur quatre étapes répétées x fois :

![[Algo_MonteCarlo.png]]

> Figure: _Pseudo-code de la fonction Monte Carlo Tree Search_

1. **Sélection** — Depuis la racine, on parcourt l'arbre jusqu'à une feuille. Le choix des fils est guidé par un compromis entre **exploitation** (aller vers un fils prometteur) et **exploration** (visiter un fils moins connu mais potentiellement meilleur).
2. **Expansion** — Si la feuille n'est pas finale, on crée un nouveau nœud.
3. **Simulation** — On simule une exécution de partie au hasard depuis ce fils jusqu'à une configuration finale.
4. **Rétropropagation** — Le résultat remonte l'arbre pour mettre à jour les informations sur la branche, du nœud fils vers la racine.

### AlphaGo

AlphaGo est un algorithme conçu pour le jeu de **Go**, un jeu à deux joueurs sans hasard dont le nombre de solutions possibles est de l'ordre de 10 000. Il est en pratique impossible de parcourir tout l'arbre, donc on utilise une IA qui fait des traitements dessus.

AlphaGo repose sur le **deep learning** et l'**apprentissage par renforcement** dans l'heuristique de valeur et la politique d'exploration, bien que l'algorithme central reste le Monte Carlo Tree Search.
# 4. Travail effectué

## 4.0 Choix technologiques

Le langage **C++** a été choisi pour ses bonnes performances, la possibilité de bénéficier de classes, et la multitude de bibliothèques disponibles. Le groupe étant familiarisé avec ce langage, c'était un choix naturel.

- **Bibliothèque standard C++** — pour les tableaux, maps et méthodes associées.
- **Godot Engine** (basé sur Qt) — pour l'interface graphique.

Le code est organisé pour **dissocier l'interface graphique de la logique** via une API appelée par les scripts Godot (conversion du `gdnative` en `gdscript`). Cela permet de réaliser des expériences et analyses sans être ralentis par le calcul des composants graphiques.

## 4.1 Fonctionnement et architecture générale

Le jeu est basé sur une **boucle principale** permettant aux joueurs de jouer chacun leur tour :

```
ALGORITHME : Boucle principale du jeu Carcassonne

  Initialisation du Plateau et des Joueurs

  TANT QUE la pioche n'est pas vide :
      Le joueur courant pioche une tuile au hasard
      Le Plateau calcule les emplacements disponibles
      Le Joueur choisit un emplacement libre

      SI le joueur a assez de meeples ET choisit d'en placer un :
          Calculer les éléments libres de la tuile piochée
          Le Joueur choisit un élément libre
      FIN SI

      Compter les points et désindexer les meeples qui ont complété une zone
      Passer au joueur suivant
  FIN TANT QUE

  Compter les points finaux et déterminer le Joueur gagnant
```

### Représentation des données

Les composants logiques suivants ont été utilisés :

- **Grille** — représente le plateau du jeu sur lequel on pose les tuiles.
- **Pioche** — tableau vidé au fur et à mesure que les joueurs piochent.
- **Tuile** — composée de :
    - **4 bordures** : permettent de placer la tuile en fonction des tuiles voisines.
    - **Éléments** : les emplacements où l'on peut poser un meeple.

![[tuilebordure.png]]

> Figure: _Les bordures (en rouge) ont chacune un type. En rotation horaire : [Ville], [Plaine, Route et Plaine], [Plaine], [Plaine, Route et Plaine]_

![[tuileelement.png]]

> Figure: _Les éléments (en bleu) : ville, plaine, route, plaine_

Les bordures et les éléments sont reliés entre eux selon leur type. Une bordure de ville est reliée à un emplacement de ville, etc.

![[tuilelink.png]]

> Figure: _Les éléments sont reliés selon leurs types. La plaine est reliée par un lien simple à la ville pour l'évaluation des villes complètes._

Les bordures sont connectées aux bordures des tuiles voisines pour pouvoir déterminer les éléments appartenant à la même zone.

> [!TIP] **Problème résolu :** Pour évaluer les points des paysans, les bordures ont été divisées en 3 nœuds pour distinguer les différents chemins dans une même bordure.

![[bordurefils.png]]

> Figure: _Le carré noir est la bordure avec 3 nœuds. Le chemin bleu et le chemin rose sont ainsi distingués._

En assemblant les tuiles et en connectant les nœuds, on obtient un ensemble de **composantes connexes** sur lesquelles on peut appliquer des algorithmes de parcours pour le comptage des points.

![[reseautuiles.png]]

> Figure: _Réseau complet : nœuds ROUTE (bleu), VILLE/VILLE-BLASON (rouge), MOINE (vert), PAYSANS (turquoise)_

Les autres composants :

- **Meeple** — peut être un Chevalier, un Brigand, un Moine ou un Paysan (par héritage). Placé sur un élément d'une tuile.
- **Sac de Meeples** (`class Pion`) — permet de gérer les meeples d'un joueur.

### Placement des tuiles sur le plateau

Pour chercher les emplacements possibles, un algorithme brute force est appliqué : on détermine un ensemble d'emplacements candidats et on vérifie pour chaque rotation si les bordures voisines se complètent.

```
ALGORITHME : Récupère les emplacements libres
  ENTRÉE  : la tuile piochée
  SORTIE  : la liste des emplacements libres

  emplacement_candidate ← liste des tuiles candidates
  POUR chaque emplacement_candidate :
      POUR chaque voisin de l'emplacement_candidate :
          On place la tuile et on vérifie ses voisins
          SI les bordures de la tuile et du voisin sont les mêmes :
              On ajoute les coordonnées et l'orientation à emplacement_libre
          FIN SI
      FIN POUR
  FIN POUR
  RETOURNER emplacement_libre
```

Quand une tuile est placée, la liste des tuiles candidates est mise à jour :

```
ALGORITHME : Placer une tuile
  ENTRÉE  : la tuile piochée, les coordonnées de placement
  SORTIE  : void

  Supprimer l'emplacement cible de tuile_candidate
  Ajouter la tuile sur la grille aux coordonnées données
  POUR chaque voisin de l'emplacement :
      SI l'emplacement est vide OU ne figure pas dans tuile_candidate :
          Ajouter l'emplacement voisin à tuile_candidate
      FIN SI
  FIN POUR
```

### Comptage des points

Pour compter les points, on évalue tous les meeples de chaque joueur, car un joueur peut placer une tuile qui fait gagner des points à l'autre. En fonction du rôle du meeple, différents algorithmes sont appliqués :

**Chevalier** — algorithme de parcours en profondeur sur chaque nœud :

```
ALGORITHME : Comptage des points pour un Chevalier
  ENTRÉE  : tuile piochée, le nœud du chevalier, le score
  SORTIE  : si est complet

  pileNoeud ← les nœuds fils
  noeudMarque ← nœuds marqués
  TANT QUE pileNoeud n'est pas vide :
      noeudCentrale ← tête de pileNoeud
      pileNoeud.pop()
      POUR chaque voisin de noeudCentrale :
          noeudsFils ← voisin
          SI noeudsFils n'est pas null ET n'est pas marqué :
              pileNoeud.push(noeudsFils)
              noeudMarque.push(noeudsFils)
              Incrémenter le score
          FIN SI
      FIN POUR
  FIN TANT QUE
```

- **Brigand** — même principe que le chevalier.
- **Moine** — vérifie si les 8 tuiles voisines sont présentes.

```
ALGORITHME : Comptage des points pour un Moine
  SORTIE : si est complet

  POUR chacune des 8 tuiles voisines :
      SI la tuile existe :
          Incrémenter le score
      FIN SI
  FIN POUR
```

- **Paysan** — algorithme effectué en fin de jeu. On parcourt les prés avec le même algorithme que le chevalier. Si un pré est adjacent à une ville, on vérifie si elle est complète et on marque tous les nœuds de cette zone pour ne pas compter deux fois.

> [!NOTE] Pendant le comptage des points, les meeples rencontrés sont collectés (sauf pour les moines). Celui ayant le plus de points remporte la mise. Les meeples collectés sont ensuite supprimés. Ces algorithmes sont effectués à chaque tour car la carte change de manière dynamique.

### Gestion des meeples

Les meeples sont ajoutés dans un tableau dès que le joueur en place un. On prend la première place libre en parcourant le tableau.

**Exemple :**

```
État initial :  [Chevalier, Brigand, null, Chevalier, Moine, null, null]
Ajout Paysan :  [Chevalier, Brigand, Paysan, Chevalier, Moine, null, null]  → indice 2
Route complète (Brigand idx 1 collecté) :
                [Chevalier, null, Paysan, Chevalier, Moine, null, null]
```

Si tous les meeples sont sur le plateau, le tableau est complet et on ne peut plus en placer.

## 4.2 Fonctionnement de l'IA

Deux types d'IA ont été implémentés : une IA **aléatoire** et une IA basée sur **MINIMAX**.

L'algorithme de l'IA se lance après que la fonction `_update()` (qui précalcule son coup) a été appelée. Le jeu récupère ensuite les scores des coups possibles pour sélectionner le meilleur.

> [!TIP] **Difficulté rencontrée :** La duplication en mémoire du plateau de jeu était problématique car les nœuds et les liens ne pouvaient pas être recréés. La solution retenue : mettre la table des nœuds voisins dans le plateau, permettant de restaurer cette table selon le plateau choisi.

### Niveau 0 — IA aléatoire

Le principe est simple : l'IA reçoit un plateau dupliqué et la tuile piochée, puis elle tire au hasard un emplacement libre (`indice_emplacement_libre`). Si elle a assez de meeples, elle choisit aléatoirement d'en poser un ou non (`si_poser_meeple`), puis elle choisit un élément libre (`indice_element_libre`).
### Niveau 1 — IA MINIMAX

L'algorithme Minimax pour le Carcassonne devient rapidement lourd à supporter lorsque la profondeur augmente. En pratique, seule une **profondeur de 2** a pu être implémentée avant que le temps de réponse ne soit trop grand.

Le fonctionnement :

1. On cherche la liste de toutes les possibilités de placement de la tuile sur le plateau.
2. On itère à travers toutes les possibilités pour trouver où placer un meeple pour maximiser les points.
3. Pour chaque configuration, on cherche le placement optimal que l'adversaire pourrait effectuer (tuile tirée aléatoirement) pour calculer ses points potentiels.
4. On choisit un coup en fonction des points qu'il rapporte **moins** le nombre de points que l'adversaire pourrait gagner, **pondéré par la probabilité** de l'adversaire de tirer la tuile correspondante.
## 4.3 Interface graphique

L'interface graphique a été réalisée avec le moteur **Godot Engine**, un projet open source écrit en C++ pour le développement de jeux vidéo. Une API a été créée pour connecter la logique du jeu au moteur graphique.

L'interface permet de :

- Sélectionner les types de joueurs (menu Options), notamment le niveau de difficulté de l'IA (**facile** pour aléatoire, **normal** pour minimax).
- Visualiser les tuiles déjà posées et les emplacements disponibles pour la tuile tirée.
- Indiquer les positions possibles pour placer les meeples.
- Afficher les points de chaque joueur en haut de la fenêtre.

![[exemplepartie.png]]

> Figure: _Exemple de partie en cours sur l'interface graphique_
# 5. Analyse des résultats

## 5.1 ALEAT vs ALEAT

Ce graphique représente le score moyen obtenu par deux IA aléatoires jouant l'une contre l'autre, en fonction du numéro du tour. Les données sont obtenues sur **100 simulations**.
![[aleatvsaleat.png]]

>_Graphique : ALEAT vs ALEAT_

**Observations :**

- Les points stagnent sur plusieurs tours : les IA ne cherchent pas à récupérer des points et les gains accidentels sont rares en début de partie.
- Certains points peuvent être à des ordonnées élevées alors que les moyennes restent autour de **10 points maximum**. Cela est dû à la dispersion des résultats : sur 100 simulations, une IA peut accidentellement atteindre un score élevé sans que ce soit la norme.
- Les deux courbes sont relativement proches, témoignant de la similarité des résultats des deux algorithmes aléatoires.

## 5.2 MINIMAX vs ALEAT

Ce graphique montre le score moyen obtenu par une IA minimax contre une IA aléatoire au cours des 71 tours. Les données sont obtenues sur **10 simulations**.

![[MINIMAXvsALEAT.pdf]]

>_Graphique : MINIMAX vs ALEAT_

**Observations :**

- Les points de l'IA MINIMAX sont presque toujours au-dessus de ceux de l'IA ALEAT.
- La courbe de MINIMAX augmente rapidement et n'est jamais dépassée par celle de ALEAT.
- Le score de ALEAT ne dépasse en moyenne pas la dizaine, alors que MINIMAX atteint en moyenne **55 points**, pouvant dépasser **120 points** dans certains cas.

> [!NOTE] Ce graphique témoigne de l'efficacité de l'IA MINIMAX comparée à un joueur jouant aléatoirement.

## 5.3 MINIMAX vs MINIMAX

Ce graphique montre le score moyen obtenu par deux IA minimax jouant l'une contre l'autre en fonction du tour de jeu. Les données sont obtenues sur **10 simulations**.

![[MINIMAXvsMINIMAX.pdf]]

>_Graphique : MINIMAX vs MINIMAX_

**Observations :**

- Comme pour ALEAT vs ALEAT, les courbes sont très proches, mais les scores finaux sont plus élevés, autour de **60 points**. Dans certains cas, un score pouvant dépasser **400 points** a été observé.
- Un comportement particulièrement intéressant a été constaté : les IA semblent se contraindre à gagner moins de points par tour si elles peuvent éviter à leur adversaire d'en gagner encore plus. On observe une stagnation des scores en fin de partie.

> [!TIP] **Conclusion :** Il semble plus intéressant de **jouer contre l'adversaire** (limiter ses points) plutôt que de jouer **pour gagner des points soi-même**.

# 6. Conclusion

## 6.1 Bilan du projet

Il a été démontré que l'IA minimax de profondeur 2 était nettement plus efficace qu'une IA jouant aléatoirement. En jouant contre elle en tant que humain, la difficulté qu'elle offrait était suffisante pour battre un débutant de manière fiable, mais insuffisante pour battre régulièrement un joueur expérimenté.

## 6.2 Critiques et pistes d'amélioration

Plusieurs axes d'amélioration sont identifiés :

- **Optimisation de l'implémentation du jeu** — diviser le nombre de calculs effectués, même au détriment de la mémoire.
- **Réduction de la complexité de recherche** — trouver des heuristiques permettant de réduire drastiquement la complexité de l'IA, et opérer à des profondeurs plus importantes que 2.
- **Exploration de MCTS** — algorithme non implémenté dans ce projet mais potentiellement très adapté au caractère probabiliste de Carcassonne.

# 7. Dépôts Git

- Code principal : https://github.com/Carcassonne-IA-Version-Deux-Joueurs/carcassonne
- Interface graphique : https://github.com/Carcassonne-IA-Version-Deux-Joueurs/carcassonne-graphic