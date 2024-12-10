BEGIN
    pack_gestion_rubrique.p_ajouter_rubrique(3,2,17,1,'DANCE');
    pack_gestion_rubrique.p_ajouter_rubrique(3,2,19,1,'DANCE');
    pack_gestion_rubrique.p_ajouter_rubrique(3,4,18,1,'Magie');
END;
select * from spectacle;
select * from rubrique;
BEGIN
    pack_gestion_rubrique.p_ajouter_rubrique(3,6,20,1,'Music');
END;
select * from spectacle;
select * from rubrique;