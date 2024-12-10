CREATE OR REPLACE PACKAGE BODY pack_gestion_spectacle AS

PROCEDURE p_ajouter_spectacle(v_idLieu IN SPECTACLE.idLieu%TYPE,v_titre IN SPECTACLE.titre%TYPE,v_dateS IN SPECTACLE.dateS%TYPE,
    v_H_Debut IN SPECTACLE.H_Debut%TYPE,v_dureeS IN SPECTACLE.dureeS%TYPE,v_nbrSpectateur IN SPECTACLE.nbrSpectateur%TYPE) IS
BEGIN
	INSERT INTO SPECTACLE (idSpec, Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu)
	VALUES (seq_spectacle.nextval, v_titre, v_dateS, v_H_Debut, v_dureeS, v_nbrSpectateur, v_idLieu);
   	commit;
END p_ajouter_spectacle;

PROCEDURE p_annuler_spectacle(v_idspec IN SPECTACLE.idspec%TYPE) IS
errAnnul EXCEPTION;
BEGIN
    UPDATE SPECTACLE
    SET dates=NULL
    WHERE idspec=v_idspec AND dates > SYSDATE;
    IF(SQL%ROWCOUNT=0) THEN
        RAISE errAnnul;
    END IF;
    EXCEPTION
    WHEN errAnnul THEN
     p_afficher_msg('Aucun spectacle a annulé');
END p_annuler_spectacle;

PROCEDURE p_Modifier_spectacle(v_idspec IN SPECTACLE.idspec%TYPE,v_idLieu IN SPECTACLE.idLieu%TYPE DEFAULT NULL,
    v_titre IN SPECTACLE.titre%TYPE DEFAULT NULL,v_dateS IN SPECTACLE.dateS%TYPE DEFAULT NULL,v_H_Debut IN SPECTACLE.H_Debut%TYPE DEFAULT NULL,
    v_dureeS IN SPECTACLE.dureeS%TYPE DEFAULT NULL,v_nbrSpectateur IN SPECTACLE.nbrSpectateur%TYPE DEFAULT NULL ) IS
BEGIN
        UPDATE SPECTACLE
        SET idLieu = NVL(v_idLieu, idLieu),
            titre = NVL(v_titre, titre),
            dateS = NVL(v_dateS, dateS),
            H_Debut = NVL(v_H_Debut, H_Debut),
            dureeS = NVL(v_dureeS, dureeS),
            nbrSpectateur = NVL(v_nbrSpectateur, nbrSpectateur)
        WHERE idspec = v_idspec;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE errSpec;
        END IF;
    EXCEPTION 
     WHEN errSpec THEN 
        P_afficher_msg(msgSpecExist|| v_idspec);
END;

PROCEDURE p_chercher_spectacle_titre(v_titre IN SPECTACLE.titre%TYPE ) IS
 CURSOR curSpec IS
        SELECT *
        FROM SPECTACLE
        WHERE  UPPER(titre) LIKE '%' || UPPER(v_titre) || '%';
    vCurSpec curSpec%ROWTYPE;
    vnb NUMBER;
BEGIN
    OPEN curSpec;
    p_afficher_msg('ID spec   | titre |  date  |  heure debut  | duree |  nbr spectateurs  | ID Lieu ');
    LOOP
        FETCH curSpec INTO vCurSpec;
        EXIT WHEN curSpec%NOTFOUND;
        p_afficher_msg(vCurSpec.idspec || ' | '  ||  vCurSpec.titre || ' | '  ||  vCurSpec.dates || ' | '  ||  vCurSpec.h_debut || ' | '  ||
        vCurSpec.durees || ' | '  ||       	vCurSpec.nbrspectateur || ' | '  ||  vCurSpec.idlieu);
    END LOOP;
    vnb:= curSpec%ROWCOUNT;
    CLOSE curSpec;
    IF (vnb=0) THEN
	RAISE errSpec;
    END IF;
EXCEPTION
    WHEN errSpec THEN
        p_afficher_msg('Aucun spectacle correspondant à ces criteres ');
END p_chercher_spectacle_titre;

FUNCTION f_chercher_id_spect(vIdspec IN spectacle.idspec%TYPE) RETURN BOOLEAN AS
  VId_spec spectacle.idspec%TYPE;
  
BEGIN
    SELECT idspec INTO VId_spec
    FROM spectacle 
    WHERE idspec=vIdspec;
    RETURN True;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN False;
END f_chercher_id_spect;

PROCEDURE p_ajouter_billet (
    v_categorie billet.categorie%TYPE,
    v_idSpec billet.idSpec%TYPE
) AS
    count_speCategorie NUMBER;
    errSpecat EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO count_speCategorie
    FROM CATEGORIEBILLET
    WHERE idSpec = v_idSpec AND categorie=v_categorie ;

    IF count_speCategorie = 0 THEN
        RAISE errSpecat;
    END IF;

    INSERT INTO Billet (idBillet, categorie, idSpec, vendu)
    VALUES (seq_billet.NEXTVAL, v_categorie, v_idSpec,'NON');
   EXCEPTION
	WHEN errSpecat THEN
		p_afficher_msg('Catégorie ' || v_categorie || ' n"existe pas pour le spectacle ' || v_idSpec);
END p_ajouter_billet;

PROCEDURE p_ajouter_categorieBillet (
    v_idSpec billet.idSpec%TYPE,
    v_categorie billet.categorie%TYPE,
    v_prix CATEGORIEBILLET.prix%TYPE
) AS
    count_spec NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count_spec
    FROM Spectacle
    WHERE idSpec = v_idSpec;
    IF count_spec = 0 THEN
        RAISE errSpec;
    END IF;
    INSERT INTO CategorieBillet (idSpec, categorie, prix)
    VALUES (v_idSpec, v_categorie, v_prix);
EXCEPTION
    WHEN errSpec THEN
        p_afficher_msg(msgSpecExist ||  v_idSpec );
END;

PROCEDURE p_vendre_billet (v_idBillet billet.IDBILLET%TYPE) AS
BEGIN
    update billet 
    set vendu = 'OUI'
    where IDBILLET = v_idBillet;
END p_vendre_billet;

END pack_gestion_spectacle;

