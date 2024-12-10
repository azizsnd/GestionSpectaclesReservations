CREATE OR REPLACE TRIGGER trig_update_spec_nbrub
AFTER INSERT OR DELETE ON Rubrique
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE SPECTACLE 
        SET nbrRubriques = nbrRubriques + 1 
        WHERE idSpec = :NEW.idSpec;
    ELSIF DELETING THEN
        UPDATE SPECTACLE 
        SET nbrRubriques = nbrRubriques - 1 
        WHERE idSpec = :OLD.idSpec;
    END IF;
END;
