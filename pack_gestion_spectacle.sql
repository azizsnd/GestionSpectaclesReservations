CREATE OR REPLACE PACKAGE pack_gestion_spectacle AS
PROCEDURE p_ajouter_spectacle(v_idLieu IN SPECTACLE.idLieu%TYPE,v_titre IN SPECTACLE.titre%TYPE,v_dateS IN SPECTACLE.dateS%TYPE,
    v_H_Debut IN SPECTACLE.H_Debut%TYPE,v_dureeS IN SPECTACLE.dureeS%TYPE,v_nbrSpectateur IN SPECTACLE.nbrSpectateur%TYPE);
PROCEDURE p_annuler_spectacle(v_idspec IN SPECTACLE.idspec%TYPE);
PROCEDURE p_Modifier_spectacle(v_idspec IN SPECTACLE.idspec%TYPE,v_idLieu IN SPECTACLE.idLieu%TYPE DEFAULT NULL,
    v_titre IN SPECTACLE.titre%TYPE DEFAULT NULL,v_dateS IN SPECTACLE.dateS%TYPE DEFAULT NULL,v_H_Debut IN SPECTACLE.H_Debut%TYPE DEFAULT NULL,
    v_dureeS IN SPECTACLE.dureeS%TYPE DEFAULT NULL,v_nbrSpectateur IN SPECTACLE.nbrSpectateur%TYPE DEFAULT NULL);
PROCEDURE p_chercher_spectacle_titre(v_titre IN SPECTACLE.titre%TYPE);
FUNCTION f_chercher_id_spect(vIdspec IN spectacle.idspec%TYPE) RETURN BOOLEAN;
PROCEDURE p_ajouter_billet (v_categorie billet.categorie%TYPE, v_idSpec billet.idSpec%TYPE);
PROCEDURE p_ajouter_categorieBillet (v_idSpec billet.idSpec%TYPE,v_categorie billet.categorie%TYPE,v_prix CATEGORIEBILLET.prix%TYPE);
PROCEDURE p_vendre_billet (v_idBillet billet.IDBILLET%TYPE);
errSpec EXCEPTION;
msgSpecExist VARCHAR(100) :='Aucun spectacle trouvé avec cet identifiant ';
END pack_gestion_spectacle;
