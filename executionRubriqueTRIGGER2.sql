select * from spectacle;
select * from rubrique;
BEGIN
    pack_gestion_rubrique.p_ajouter_rubrique(6,2,19,1,'DANCE');
    pack_gestion_rubrique.p_supprimer_rubrique(1);
END;
select * from spectacle;
select * from rubrique;