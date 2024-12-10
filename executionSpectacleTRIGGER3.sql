BEGIN
    -- Ajouter une catégorie 'Normale'
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'NORMALE', 50);
    -- Ajouter une catégorie 'Silver' avec un prix incorrect (doit échouer)
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'SILVER', 30);
    -- Ajouter une catégorie 'Silver' avec un prix correct
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'SILVER', 70);
    -- Ajouter une catégorie 'Gold' avec un prix incorrect (doit échouer)
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'GOLD', 60);
    -- Ajouter une catégorie 'Gold' avec un prix correct
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'GOLD', 100);
END;

