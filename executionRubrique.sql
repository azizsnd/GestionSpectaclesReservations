DECLARE
    v_disponible BOOLEAN;
BEGIN
    -- Ajout des artistes
    pack_gestion_rubrique.p_ajouter_artiste('Ahmed', 'Ben Ali', 'DANCEUR');
    pack_gestion_rubrique.p_ajouter_artiste('Salma', 'Gharbi', 'CHANTEUR');
    pack_gestion_rubrique.p_ajouter_artiste('Oussama', 'Hajji', 'MAGICIEN');
    pack_gestion_rubrique.p_ajouter_artiste('Sami', 'Saad', 'ACTEUR');
    pack_gestion_rubrique.p_ajouter_artiste('Amira', 'Mekki', 'MUSICIEN');
    v_disponible := pack_gestion_rubrique.f_disponibilite_artiste(3, TO_DATE('25/12/2024', 'DD/MM/YYYY'), 18.3, 2);
    IF v_disponible THEN
        p_afficher_msg('L"artiste 3 est disponible pour le spectacle.');
    ELSE
        p_afficher_msg('L"artiste 3 n"est pas disponible pour le spectacle.');
    END IF;
    pack_gestion_rubrique.p_ajouter_rubrique(3, 4, 14, 2,'Magie');
    pack_gestion_rubrique.p_ajouter_rubrique(1, 2, 19, 1,'Dance');
    -- Modification d'une rubrique
    pack_gestion_rubrique.p_modifier_rubrique(1, 4, 14, 2);
    p_afficher_msg('Modification de la rubrique 1 effectuée.');
    -- Recherche des rubriques
    p_afficher_msg('Recherche des rubriques pour le spectacle 3 :');
    pack_gestion_rubrique.p_rechercher_rubriques(3);
    p_afficher_msg('Recherche des rubriques associées à l''artiste Ahmed :');
    pack_gestion_rubrique.p_rechercher_rubriques(NULL, 'Ahmed');
    -- Suppression d'une rubrique
    pack_gestion_rubrique.p_supprimer_rubrique(2);
    p_afficher_msg('Rubrique 2 supprimée.');
END;


