BEGIN
    -- Ajouter une cat�gorie 'Normale'
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'NORMALE', 50);
    -- Ajouter une cat�gorie 'Silver' avec un prix incorrect (doit �chouer)
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'SILVER', 30);
    -- Ajouter une cat�gorie 'Silver' avec un prix correct
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'SILVER', 70);
    -- Ajouter une cat�gorie 'Gold' avec un prix incorrect (doit �chouer)
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'GOLD', 60);
    -- Ajouter une cat�gorie 'Gold' avec un prix correct
        pack_gestion_spectacle.p_Ajouter_CategorieBillet(2, 'GOLD', 100);
END;

