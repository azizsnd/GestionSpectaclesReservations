CREATE OR REPLACE TRIGGER trig_delete_rubrique
BEFORE DELETE ON Rubrique
FOR EACH ROW
DECLARE
vDateS spectacle.dateS%TYPE;
BEGIN
	SELECT dateS INTO vDateS FROM spectacle WHERE idspec=:OLD.idspec;
	IF(vDateS<= SYSDATE) THEN 
		RAISE_APPLICATION_ERROR(-20007,'La date du spectacle doit etre supérieure a la date du jour.');
    END IF;
END;