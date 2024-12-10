SET SERVEROUTPUT ON;
DECLARE
    v_exists BOOLEAN;
BEGIN
    pack_gestion_lieu.p_ajouter_lieu('CABARET RESTAURANT SHEHERAZADE', 'Médina Mediterranea - Yasmine-Hammamet - Tunisie', 'Hammamet', 100);
    pack_gestion_lieu.p_ajouter_lieu('THÉÂTRE EL HAMRA', '28, rue El Jazira - Tunis - Tunisie', 'Tunis', 550);
    pack_gestion_lieu.p_ajouter_lieu('Pathé Tunis City', 'Cebalet ben ammar, route de bizerte km 17 Ariana, Tunis 2032, Tunisie', 'Tunis', 1600);
    pack_gestion_lieu.p_ajouter_lieu('Théâtre Municipal de Tunis', 'Avenue Bourguiba - Tunis - Tunisie', 'Tunis', 1461);
    pack_gestion_lieu.p_ajouter_lieu('CINÉMA TUNISIA ODYSSÉE', 'Medina Mediterranea - Yasmine-Hammamet - Tunisie', 'Hammamet', 1251);
    pack_gestion_lieu.p_ajouter_lieu('L"ÉTOILE DU NORD', '41, avenue Farhat-Hached - Tunis - Tunisie', 'Tunis', 1794);
    pack_gestion_lieu.p_ajouter_lieu('Pathé Tunis City', 'Cebalet ben ammar, route de bizerte km 17 Ariana, Tunis 2032, Tunisie', 'Ariana', 1600);
    pack_gestion_lieu.p_ajouter_lieu('CENTRE DOUAR EL HASFI', 'Route du Zoo-Paradis - 2200 - Tozeur - Tunisie', 'Tozeur', 707);
    pack_gestion_lieu.p_ajouter_lieu('EL MAWEL', '5, rue Amine-Abbassi - Tunis - Tunisie', 'Tunis', 1437);
    pack_gestion_lieu.p_ajouter_lieu('EL TEATRO', 'Avenue Ouled Haffouz - Tunis - Tunisie', 'Tunis', 1711);
    pack_gestion_lieu.p_ajouter_lieu('ZINEBLEDI', 'route de tunis km12 - 4000 - Sousse - Tunisie', 'Sousse', 1725);
    pack_gestion_lieu.p_ajouter_lieu('Le Colisée', 'Avenue Habib Bourguiba, Tunis, Tunisie', 'Tunis', 1508);
    pack_gestion_lieu.p_ajouter_lieu('Cine Jamil', 'Rue du docteur Mohamed Ben Salah, Ariana, Tunisie', 'Ariana', 1163);
    pack_gestion_lieu.p_ajouter_lieu('L’agora', 'Rue 1 La Marsa', 'La Marsa', 1779);
    pack_gestion_lieu.p_ajouter_lieu('Alhambra “zéphyr”', 'Centre Commercial Zéphyr La Marsa', 'La Marsa', 458);
    pack_gestion_lieu.p_ajouter_lieu('CinéMadart', 'Rue Hbib Bourguiba - Monoprix Dermech, Tunisie', 'Dermech', 975);
    pack_gestion_lieu.p_ajouter_lieu('Théâtre Opéra', 'CITE DE LA CULTURE A TUNIS', 'Tunis', 1800);
    v_exists := pack_gestion_lieu.f_chercher_id_lieu(3);
    IF v_exists THEN
        p_afficher_msg('Lieu avec ID 3 existe.');
    ELSE
        p_afficher_msg('Lieu avec ID 3 n"existe pas.');
    END IF; 
    pack_gestion_lieu.p_modifier_lieu(1, 'Cabaret Sheherazade', 200);
    pack_gestion_lieu.p_modifier_lieu(2, 'Théâtre Hamra', NULL);
    pack_gestion_lieu.p_supprimer_lieu(3);
    pack_gestion_lieu.p_chercher_lieu(vNomLieu => 'Cabaret');
    pack_gestion_lieu.p_chercher_lieu(vVille => 'Tunis');
    pack_gestion_lieu.p_chercher_lieu(vCapacite => 1600);
    pack_gestion_lieu.p_chercher_lieu(vNomLieu => 'Pathé',vVille => 'Tunis',vCapacite => 1600);

    v_exists := pack_gestion_lieu.f_chercher_id_lieu(3);
    IF v_exists THEN
        p_afficher_msg('Lieu avec ID 3 existe.');
    ELSE
        p_afficher_msg('Lieu avec ID 3 n"existe pas.');
    END IF;
END;
SELECT * FROM lieu;
