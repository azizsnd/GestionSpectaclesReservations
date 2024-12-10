CREATE OR REPLACE TRIGGER trig_verif_nb_rubriques
BEFORE INSERT ON Rubrique
FOR EACH ROW
DECLARE
vnb NUMBER;
BEGIN
	SELECT nbrRubriques INTO vnb FROM spectacle WHERE idspec=:NEW.idspec;
	IF(vnb=3) THEN 
		RAISE_APPLICATION_ERROR(-20006,'L"ajout d"une nouvelle rubrique est impossible! Vous avez atteint le nombre maximal ');
        END IF;
END;