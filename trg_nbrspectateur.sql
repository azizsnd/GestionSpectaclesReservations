CREATE OR REPLACE TRIGGER trg_nbrspectateur
AFTER UPDATE OF vendu ON BILLET
FOR EACH ROW
BEGIN
 IF(UPPER(:NEW.vendu)='OUI') THEN
    UPDATE spectacle SET nbrSpectateur=nbrSpectateur+1 WHERE idspec= :OLD.idspec;
 END IF;
END;