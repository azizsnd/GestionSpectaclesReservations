BEGIN
    pack_gestion_spectacle.p_ajouter_spectacle(
        1, 
        'Concert A', 
        TO_DATE('2024-12-02', 'YYYY-MM-DD'),
        19, 
        2, 
        150
    );
    pack_gestion_spectacle.p_ajouter_spectacle(
        1, 
        'Concert A', 
        TO_DATE('2024-12-25', 'YYYY-MM-DD'),
        19, 
        2, 
        500
    );
    pack_gestion_spectacle.p_ajouter_spectacle(
        1, 
        'Concert A', 
        TO_DATE('2024-12-20', 'YYYY-MM-DD'),
        19, 
        2, 
        150
    );
pack_gestion_spectacle.p_ajouter_spectacle( 
        1, 
        'Concert A', 
        TO_DATE('2024-12-20', 'YYYY-MM-DD'),
        10, 
        2, 
        150
    );
    pack_gestion_spectacle.p_Modifier_spectacle(
        12,
        1, 
        'Concert A', 
        TO_DATE('2024-12-04', 'YYYY-MM-DD'),
        10, 
        4, 
        150
    );
        pack_gestion_spectacle.p_Modifier_spectacle(
        12,
        1, 
        'Concert A', 
        TO_DATE('2024-12-22', 'YYYY-MM-DD'),
        10, 
        4, 
        350
    );
        pack_gestion_spectacle.p_Modifier_spectacle(
        1,
        1, 
        'Concert A', 
        TO_DATE('2024-12-20', 'YYYY-MM-DD'),
        20, 
        4, 
        150
    );
END;