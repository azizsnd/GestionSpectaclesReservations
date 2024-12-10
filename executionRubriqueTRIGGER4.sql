ALTER TABLE spectacle DISABLE ALL TRIGGERS;
BEGIN
    pack_gestion_spectacle.p_ajouter_spectacle(14,'Test Spectacle',TO_DATE('2023-12-01', 'YYYY-MM-DD'),18, 2,100);
END;
select * from spectacle;
pack_gestion_rubrique.p_ajouter_rubrique(
    16,   
    4, 
    18,
    1,
    'Magie'
);
END;
select * from rubrique r, spectacle s where r.idspec = s.idspec;
BEGIN
    pack_gestion_rubrique.p_supprimer_rubrique(11);
END;
ALTER TABLE spectacle ENABLE ALL TRIGGERS;