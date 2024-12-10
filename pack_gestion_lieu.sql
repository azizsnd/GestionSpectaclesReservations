CREATE OR REPLACE PACKAGE pack_gestion_lieu AS
PROCEDURE p_ajouter_lieu(vNomLieu IN Lieu.nomlieu%TYPE,vAdresse IN Lieu.adresse%TYPE,vVille IN Lieu.ville%TYPE,vCapacite IN Lieu.capacite%TYPE);
PROCEDURE p_modifier_lieu(vIdLieu IN Lieu.idlieu%TYPE,vNomLieu IN Lieu.nomlieu%TYPE DEFAULT NULL,vCapacite IN Lieu.capacite%TYPE DEFAULT NULL);
PROCEDURE p_supprimer_lieu(vIdLieu IN Lieu.idlieu%TYPE);
PROCEDURE p_chercher_lieu (vNomLieu IN Lieu.nomlieu%TYPE DEFAULT NULL,vVille IN Lieu.ville%TYPE DEFAULT NULL,vCapacite IN Lieu.capacite%TYPE DEFAULT NULL);
FUNCTION f_chercher_id_lieu (vIdLieu IN Lieu.idlieu%TYPE) RETURN BOOLEAN;
mincapacite NUMBER :=100;
maxcapacite NUMBER :=2000;
errLieu EXCEPTION;
errCapacite EXCEPTION;
msgErrLieu Varchar(100) :='Aucun lieu trouvé avec cet identifiant ';
msgErrCapacite Varchar(100) :='la capacite doit etre entre '|| mincapacite ||' et '|| maxcapacite;
END pack_gestion_lieu;
