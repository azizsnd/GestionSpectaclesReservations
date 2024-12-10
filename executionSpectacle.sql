SET SERVEROUTPUT ON;
DECLARE
    v_exists BOOLEAN;
BEGIN
    pack_gestion_spectacle.p_ajouter_spectacle(1, 'Soirée de Danse Classique', TO_DATE('2025-12-20', 'YYYY-MM-DD'), 19.00, 2.5, 50);
    pack_gestion_spectacle.p_ajouter_spectacle(2, 'Concert de Chants Traditionnels', TO_DATE('2025-12-22', 'YYYY-MM-DD'), 20.00, 3.0, 50);
    pack_gestion_spectacle.p_ajouter_spectacle(4, 'Spectacle de Magie', TO_DATE('2025-12-25', 'YYYY-MM-DD'), 18.30, 2.0, 50);
    pack_gestion_spectacle.p_Modifier_spectacle(1, v_nbrSpectateur => 100);
    v_exists := pack_gestion_spectacle.f_chercher_id_spect(2);
        IF v_exists THEN
            p_afficher_msg('Le spectacle avec ID 2 existe.');
        ELSE
            p_afficher_msg('Le spectacle avec ID 2 n"existe pas.');
        END IF;
    p_afficher_msg('------chercher spectacles de titre Magie----');
    pack_gestion_spectacle.p_chercher_spectacle_titre('Magie');
    -- Test de la procédure p_ajouter_categorieBillet p_ajouter_billet
    pack_gestion_spectacle.p_ajouter_categorieBillet(15, 'GOLD', 150.00);
    pack_gestion_spectacle.p_ajouter_categorieBillet(15, 'SILVER', 100.00);
    pack_gestion_spectacle.p_ajouter_billet('GOLD', 15);
    pack_gestion_spectacle.p_ajouter_billet('SILVER', 15);
    -- Test de la procédure p_annuler_spectacle
    pack_gestion_spectacle.p_annuler_spectacle(3);
END;

