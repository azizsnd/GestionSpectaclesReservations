CREATE OR REPLACE PACKAGE BODY pack_gestion_lieu AS
PROCEDURE p_ajouter_lieu(vNomLieu IN Lieu.nomlieu%TYPE,vAdresse IN Lieu.adresse%TYPE,vVille IN Lieu.ville%TYPE,vCapacite IN Lieu.capacite%TYPE) AS
BEGIN
    IF (vCapacite >=mincapacite AND vCapacite<=maxcapacite) THEN
   	 INSERT INTO lieu(idlieu,nomlieu,adresse,ville,capacite) VALUES (seq_lieu.nextVal,vNomLieu,vAdresse,vVille,vCapacite);	
    ELSE 
	RAISE errCapacite;
    END IF;
EXCEPTION
   WHEN errCapacite THEN 
	P_afficher_msg(msgErrCapacite);
END p_ajouter_lieu;	

PROCEDURE p_modifier_lieu(vIdLieu IN Lieu.idlieu%TYPE,vNomLieu IN Lieu.nomlieu%TYPE DEFAULT NULL,vCapacite IN Lieu.capacite%TYPE DEFAULT NULL) AS
BEGIN
    IF vCapacite IS NULL OR (vCapacite >=mincapacite AND vCapacite<=maxcapacite) THEN
	    UPDATE lieu
    	    SET nomlieu = NVL(vNomLieu, nomlieu),
            capacite = NVL(vCapacite, capacite)
   	    WHERE idlieu = vIdLieu;    
    ELSE 
	RAISE errCapacite;
    END IF;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE errLieu;
    END IF;
EXCEPTION 
 WHEN errLieu THEN 
	P_afficher_msg(msgErrLieu|| vIdLieu);
  WHEN errCapacite THEN 
	P_afficher_msg(msgErrCapacite);
END p_modifier_lieu;

PROCEDURE p_supprimer_lieu(vIdLieu IN Lieu.idlieu%TYPE) AS
vId_Lieu Lieu.idlieu%TYPE;
Vnb NUMBER;
BEGIN
    SELECT idlieu INTO vId_Lieu
    FROM Lieu
    WHERE idlieu = vIdLieu;
    select count(*) into Vnb
    FROM spectacle
    WHERE idlieu= vIdLieu;
    IF(Vnb !=0) THEN
        UPDATE lieu 
        set estsupprime='oui' 
        where idlieu= vIdLieu;
    ELSE 
    	DELETE FROM lieu
    	WHERE idlieu = vIdLieu; 
    END IF;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
	P_afficher_msg(msgErrLieu|| vIdLieu);
END p_supprimer_lieu;

PROCEDURE p_chercher_lieu (vNomLieu IN Lieu.nomlieu%TYPE DEFAULT NULL,vVille IN Lieu.ville%TYPE DEFAULT NULL,vCapacite IN Lieu.capacite%TYPE DEFAULT NULL) AS
    CURSOR curLieux IS
        SELECT *
        FROM Lieu
        WHERE UPPER(estSupprime) = 'NON'
        AND (
            vNomLieu IS NULL OR UPPER(nomLieu) LIKE '%' || UPPER(vNomLieu) || '%'
        )
        AND (
            vVille IS NULL OR UPPER(ville) LIKE '%' || UPPER(vVille) || '%'
        )
        AND (
            vCapacite IS NULL OR capacite = vCapacite
        );  
    vCurLieux curLieux%ROWTYPE;
    vnb NUMBER;
BEGIN
    OPEN curLieux;
    p_afficher_msg('ID Lieu   | Nom Lieu |  ville  |  Adresse  | Capacite ');
    LOOP
        FETCH curLieux INTO vCurLieux;
        EXIT WHEN curLieux%NOTFOUND;
        p_afficher_msg(vCurLieux.idlieu || ' | '  || vCurLieux.nomlieu || ' | '  ||  vCurLieux.ville || ' | '  ||  vCurLieux.adresse || ' | '  
        ||  vCurLieux.capacite);
    END LOOP;
    vnb:= curLieux%ROWCOUNT;
    CLOSE curLieux;
    IF (vnb=0) THEN
	RAISE errLieu;
    END IF;
EXCEPTION
    WHEN errLieu THEN
        p_afficher_msg('Aucun lieu correspondant à ces criteres ');
END p_chercher_lieu;

FUNCTION f_chercher_id_lieu (vIdLieu IN Lieu.idlieu%TYPE) RETURN BOOLEAN AS
  VId_lieu Lieu.idlieu%TYPE;
  
BEGIN
    SELECT idlieu INTO VId_lieu
    FROM lieu 
    WHERE idlieu=vIdLieu;
    RETURN True;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN False;
END f_chercher_id_lieu ;

END pack_gestion_lieu;
