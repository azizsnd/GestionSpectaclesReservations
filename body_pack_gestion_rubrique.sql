CREATE OR REPLACE PACKAGE BODY pack_gestion_rubrique AS
    PROCEDURE p_ajouter_artiste (v_nomArt artiste.nomArt%TYPE,v_prenomArt artiste.prenomArt%TYPE,v_specialite artiste.specialite%TYPE)AS
    BEGIN
        INSERT INTO artiste VALUES (seq_artiste.NEXTVAL, v_nomArt, v_prenomArt,v_specialite);
    END  p_ajouter_artiste ;

    FUNCTION f_disponibilite_artiste(p_idArt artiste.idArt%TYPE,p_date spectacle.dateS%TYPE,p_heure_debut rubrique.h_debutR%TYPE,
             p_duree rubrique.dureeRub%TYPE) RETURN BOOLEAN IS
        v_conflit_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_conflit_count
        FROM Rubrique r, SPECTACLE s 
        WHERE r.idSpec = s.idSpec
	  AND r.idArt = p_idArt
          AND s.dateS = p_date
          AND (
               (p_heure_debut >= r.H_debutR AND p_heure_debut < r.H_debutR + r.dureeRub) OR
               (p_heure_debut + p_duree > r.H_debutR AND p_heure_debut + p_duree <r.H_debutR + r.dureeRub)
          );

        RETURN v_conflit_count = 0;
    END f_disponibilite_artiste;

	FUNCTION f_verifier_specialite(vtype rubrique.type%TYPE, vIdArt artiste.idArt%TYPE)
	RETURN BOOLEAN IS
		vSpecialite artiste.specialite%TYPE;
	BEGIN
		SELECT specialite
		INTO vSpecialite
		FROM artiste
		WHERE idArt = vIdArt;
		IF (UPPER(vtype) = 'COMEDIE' AND UPPER(vSpecialite) != 'HUMORISTE') OR
       		(UPPER(vtype) = 'THÉATRE' AND UPPER(vSpecialite) != 'ACTEUR') OR
       		(UPPER(vtype) = 'DANCE' AND UPPER(vSpecialite) != 'DANSEUR') OR
       		(UPPER(vtype) = 'IMITATION' AND UPPER(vSpecialite) != 'IMITATEUR') OR
       		(UPPER(vtype) = 'MAGIE' AND UPPER(vSpecialite) != 'MAGICIEN') OR
       		(UPPER(vtype) = 'MUSIQUE' AND UPPER(vSpecialite) != 'MUSICIEN') OR
      		 (UPPER(vtype) = 'CHANT' AND UPPER(vSpecialite) != 'CHANTEUR') THEN
       		 RETURN FALSE;
    		ELSE
     		   RETURN TRUE;
    		END IF;
	END f_verifier_specialite;

    PROCEDURE p_ajouter_rubrique(p_idSpec spectacle.idSpec%TYPE,p_idArt artiste.idArt%TYPE,
              p_heure_debut rubrique.h_debutR%TYPE,p_duree rubrique.dureeRub%TYPE,p_type rubrique.type%TYPE) IS
        v_nb NUMBER;
        v_type_specialite BOOLEAN;
        v_disponible BOOLEAN;
        v_date_spectacle spectacle.dateS%TYPE;
    BEGIN
        SELECT count(idArt) INTO v_nb FROM ARTISTE WHERE idArt = p_idArt;
        IF v_nb=0 THEN
            RAISE errArtExist;
        END IF;
        v_type_specialite := f_verifier_specialite(p_type, p_idArt);
        IF NOT v_type_specialite THEN
            RAISE errSpecialite;
        END IF;

        SELECT dateS INTO v_date_spectacle FROM SPECTACLE WHERE idSpec = p_idSpec;
	
        v_disponible := f_disponibilite_artiste(p_idArt, v_date_spectacle, p_heure_debut, p_duree);

        IF NOT v_disponible THEN
            RAISE errArtDisp;
        END IF;
        INSERT INTO Rubrique VALUES (seq_rubrique.NEXTVAL,p_idSpec, p_idArt, p_heure_debut, p_duree, p_type);
        EXCEPTION
		WHEN errArtExist THEN
			p_afficher_msg(msgArtExist||p_idArt);
		WHEN errSpecialite THEN
			p_afficher_msg(msgSpecialite);
		WHEN NO_DATA_FOUND THEN
			p_afficher_msg('Aucun spectacle trouvé avec cet identifiant '||p_idSpec);
		WHEN errArtDisp THEN
			p_afficher_msg(msgArtDisp);
    END p_ajouter_rubrique;

    PROCEDURE p_modifier_rubrique(p_idRub rubrique.idRub%TYPE,p_idArt artiste.idArt%TYPE,
              p_heure_debut rubrique.h_debutR%TYPE,p_duree rubrique.dureeRub%TYPE) IS
        v_idSpec spectacle.idSpec%TYPE;
        v_date_spectacle spectacle.dateS%TYPE;
        vType rubrique.type%TYPE;
        v_disponible BOOLEAN;
        v_type_specialite BOOLEAN;
        v_nb NUMBER;
    BEGIN
        SELECT count(idArt) INTO v_nb FROM ARTISTE WHERE idArt = p_idArt;
        IF v_nb=0 THEN
            RAISE errArtExist;
        END IF;
        SELECT idSpec, type INTO v_idSpec, vType FROM Rubrique WHERE idRub = p_idRub;
        v_type_specialite := f_verifier_specialite(vType, p_idArt);
        IF NOT v_type_specialite THEN
            RAISE errSpecialite;
        END IF;
        SELECT dateS INTO v_date_spectacle FROM SPECTACLE WHERE idSpec = v_idSpec;
        v_disponible := f_disponibilite_artiste(p_idArt, v_date_spectacle, p_heure_debut, p_duree);
        IF NOT v_disponible THEN
            RAISE errArtDisp;
        END IF;
        UPDATE Rubrique
        SET idArt = p_idArt,
            H_debutR = p_heure_debut,
            dureeRub = p_duree
        WHERE idRub = p_idRub;
        EXCEPTION
		WHEN errArtExist THEN
			p_afficher_msg(msgArtExist||p_idArt);
		WHEN NO_DATA_FOUND THEN
			p_afficher_msg('Aucun rubrique trouvé avec cet identifiant '||p_idRub);
		WHEN errSpecialite THEN
			p_afficher_msg(msgSpecialite);
		WHEN errArtDisp THEN
			p_afficher_msg(msgArtDisp );
    END p_modifier_rubrique;

    PROCEDURE p_supprimer_rubrique(p_idRub rubrique.idRub%TYPE) IS
    BEGIN
        DELETE FROM Rubrique WHERE idRub = p_idRub;
    END p_supprimer_rubrique;

    PROCEDURE p_rechercher_rubriques (p_idSpec spectacle.idSpec%TYPE DEFAULT NULL,p_nomArt  Artiste.nomArt%TYPE DEFAULT NULL) AS
     CURSOR curRubrique IS
        SELECT r.idRub,r.idSpec, r.H_debutR,r.dureeRub,r.type,a.NomArt,a.PrenomArt
        FROM rubrique r , Artiste a
        WHERE  r.idArt = a.idArt AND 
	   ( p_idSpec IS NULL OR UPPER(idSpec) LIKE '%' || UPPER(p_idSpec) || '%')
        AND ( p_nomArt IS NULL OR UPPER(a.nomArt) LIKE '%' || UPPER(p_nomArt) || '%'
        );
    vCurRubrique curRubrique%ROWTYPE;
    vnb NUMBER;
    errRub EXCEPTION;
BEGIN
    OPEN curRubrique;
    p_afficher_msg('ID rubrique   | ID Spectacle |  Heure debut  | duree Rubrique | Type  | Nom Artiste | Prenom Artiste ');
    LOOP
        FETCH curRubrique INTO vCurRubrique;
        EXIT WHEN curRubrique%NOTFOUND;
        p_afficher_msg(vCurRubrique.idRub || ' | '  || vCurRubrique.idSpec || ' | '  ||  vCurRubrique.H_debutR || ' | '  ||  vCurRubrique.dureeRub 
        || ' | '  ||  vCurRubrique.type|| ' | '  	||  vCurRubrique.NomArt|| ' | '  ||  vCurRubrique.PrenomArt);
    END LOOP;
    vnb:= curRubrique%ROWCOUNT;
    CLOSE curRubrique;
    IF (vnb=0) THEN
	RAISE errRub;
    END IF;
EXCEPTION
    WHEN errRub THEN
        p_afficher_msg('Aucun rubrique correspondant à ces criteres ');
END p_rechercher_rubriques;

END pack_gestion_rubrique;
