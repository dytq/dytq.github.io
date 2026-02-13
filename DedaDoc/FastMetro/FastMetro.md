---
title: Implémentation en Java de l'algorithme de Dijktra appliqué au réseau métro parisien
link: https://github.com/dytq/Fast-Metro/tree/master
tags:
  - Java
  - Dijkstra
---
# Présentation du logiciel
Fast-Metro est un logiciel permettant de trouver le plus court chemin entre deux stations de métro. Ce logiciel est programmée avec Java, j’utilise: Jframe (bibliothèque graphique native de Java), Maven (pour les dépendances) et du standard Json, librairie Gson (lire et écrire sur un fichier) pour faciliter les transferts de données.
![[c1.png]]
# Mode d’Emploi
On selectionnne les deux stations qu’on souhaite voir le plus court chemin. Si on est dans une gare traversée par plusieurs stations, on selectionne la ligne souhaité via un menu déroulant. On clic. Le logiciel va afficher le plus court chemin. On clic pour reinitialiser la carte.

Explication de la structure du projet global

Voici un résumé de la structure du projet:
1) fastmetro package: contient la classe main et les classes de structures de
données
		a) Main.java: class principal.
		b) Carte.java: Tous ce qui concerne la carte, la liste des gares, des
stations et les appelle vers fenêtre.
		c) Station.java: Tous ce qui concerne une station (numéro de la stations,ligne). Un station est traversée par une ligne dans les deux sens de circulations. Elle hérite d’une gare pour pouvoir obtenir
l’identifiant de la gare dont laquelle est affecté.
		d) Gare.java: Une gare est un ensemble de stations. Elle contient un
nom et une liste de stations.
		e) Lecture.java: Pour lire un fichier json dans le système de fichier.
		f) Dijkstra.java: Implémentation de l’algo et utilisation d’un tableau
pour faire les opérations.
		g) CouplePereTemps.java: Un couple de valeur. Utiliser pour dijkstra.
2) GUI package: c’est pour l’interface graphique de l’utilisateur. On a une fenetre, un panel(station pannel) pour dessiner les  stations(changer les couleurs etc. . . ), circle qui représente un cercle utiliser pour l’affichage des stations et une classe de clique mise sur écoute.
## Algorithme du plus court chemin: Dijkstra

Pour la structure de donnée il fallait une structures ou l’on peut faire des opérations dynamique et avoir accès facilement à une données. J’ai donc utiliser une table de hachage avec une clé (un sommet, qui est l’identifiant d’une station) pour chercher facilement une valeur (pour supprimer et ajouter) et un couple de père/temps. J’ai donc deux table de hachage que j’ai appelé matriceDijkstra_atraiter qui contient les valeurs que l’on a besoin de traiter et une autre matriceDijsktra_res qui est le résultat du plus court chemin.
## Dérouler de l’algorithme
Voici l’algo adapter pour le programme, elle se déroule en deux temps, on cherche les valeurs des plus courts chemin que l’on met dans la table res:
	• On ajoute la station de départ dans la table a traiter (elle devient la station
	père).
	• On boucle jusqu’a que la table a traiter soit vide:
	• Pour chaque voisin du père:
	• Si le voisin est dans la table res (Les voisins de S0 par exemple à pour	voisin S1 et S2 et S1 à pour voisin S0 alors qu’il est déjà traiter) on ne fait 	rien.
	• Si le voisin est dans la table a traiter et qu’on a trouver un plus court chemin on le rajoute sinon on ne fait rien.
	• On met le père dans res et le minimum dans père.
	Et la deuxième étape s’agit de remonter de la station d’arriver pour aller à la station de départ en regardant les voisins de la table res.
## Lecture
C’est simplement une deserialization d’un ensemble d’objet écrit en Json de toutes les stations. J’ai pas voulu refaire le graphe avec les stations, donc j’ai juste adapter grâce aux registres vim en le transformant en une matrice et je l’ai
lu pour initialiser le graphe. Donc on a deux fichiers, un ensemble de stations et une autre pour le graphe.
## Carte
La carte contient deux listes: La liste des gares et la liste des stations avec leurs voisins. Les voisins des voisins n’ont pas de voisins, c’est juste à titre d’identifiant. Ils ont la même adresse que après lecture de fichier des stations. L’identifiant gare est sont emplacement dans la liste par ordre de lecture du fichier.
## clic
Le clic est mis en écoute. Quand on clic on fait appel à l’objet dijkstra initialisé dans la carte. Les tableaux sont temporaires et change à chaque itérations. 
## Panel 
On initialise la carte et les stations en même temps. On va juste changer un cercle pour changer sa couleur.
