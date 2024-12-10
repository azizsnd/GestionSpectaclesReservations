CREATE OR REPLACE PACKAGE pack_gestion_rubrique AS
    PROCEDURE p_ajouter_artiste (v_nomArt artiste.nomArt%TYPE, v_prenomArt artiste.prenomArt%TYPE,v_specialite artiste.specialite%TYPE);
    FUNCTION f_disponibilite_artiste(p_idArt artiste.idArt%TYPE,p_date spectacle.dateS%TYPE,
             p_heure_debut rubrique.h_debutR%TYPE,p_duree rubrique.dureeRub%TYPE) RETURN BOOLEAN;
    FUNCTION f_verifier_specialite(vtype rubrique.type%TYPE,vIdArt artiste.idArt%TYPE) RETURN BOOLEAN ;
    PROCEDURE p_ajouter_rubrique(p_idSpec spectacle.idSpec%TYPE,p_idArt artiste.idArt%TYPE,
              p_heure_debut rubrique.h_debutR%TYPE,p_duree rubrique.dureeRub%TYPE,p_type rubrique.type%TYPE);
    PROCEDURE p_modifier_rubrique(p_idRub rubrique.idRub%TYPE,p_idArt artiste.idArt%TYPE,
              p_heure_debut rubrique.h_debutR%TYPE,p_duree rubrique.dureeRub%TYPE);
    PROCEDURE p_supprimer_rubrique(p_idRub rubrique.idRub%TYPE);
    PROCEDURE p_rechercher_rubriques(p_idSpec spectacle.idSpec%TYPE  DEFAULT NULL, p_nomArt artiste.nomArt%TYPE  DEFAULT NULL);
    errArtDisp EXCEPTION;
    errArtExist EXCEPTION;
    errSpecialite EXCEPTION;
    msgArtDisp Varchar(100) :='L"artiste n"est pas disponible pour l"horaire indiqué.';
    msgArtExist Varchar(100) :='Aucun artiste trouvé avec cet identifiant.';
    msgSpecialite Varchar(100) :='Spécialité de l"artiste doit etre adaptée au type de la rubrique.';
END pack_gestion_rubrique;
