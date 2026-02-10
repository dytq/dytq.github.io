void Robot::script_robot_aleat(Plateau * plateau, Tuile * tuile)
{        
    // Création D'un Nouveau Plateau
    plateau->add_child();            
    plateau->set_at_back_child();    
    // 

    // On Calcul les emplacements libre
    plateau->calcul_emplacements_libres(tuile);
    //
    
    // Sélection d'un emplacement aléatoire et le placer sur le plateau
    this->indice_emplacement_libre = rand() % plateau->get_liste_tuiles_emplacements_libres().size(); 
    std::array<int,3> emplacement = plateau->get_liste_tuiles_emplacements_libres()[indice_emplacement_libre];
    plateau->poser_tuile(tuile, emplacement);
    //

    // Placer un Meeple sur un plateau
    if(plateau->get_nbr_meeple(this) > 0)  // Si le Joueur a assez de Meeple
    {
        // Le Robot choisi aléatoirement si il veut placer un meeple
        this->si_poser_meeple = rand() % 2;
        if(this->si_poser_meeple) 
        {
            // On calcul les éléments libre ou le ROBOT peut placer son Meeple
            plateau->calculer_element_libres(tuile);
            int size_liste_element = plateau->get_element_libre().size();
            
            // Si il y a des éléments qu'on peut placer 
            if(size_liste_element > 0)
            {
                // On Place Le Meeple aléatoirement sur un élément
                this->indice_element_libre = rand() % size_liste_element;
            }
            else 
            {
                this->si_poser_meeple = false;
            }
        }
         else 
            {
                this->si_poser_meeple = false;
        }
    }
    else
    {
        this->si_poser_meeple = false;
    }
    //

    // On supprime le fils créer et revient à l'état d'avant (root)
    plateau->remove_back_child(); 
}