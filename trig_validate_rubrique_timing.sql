CREATE OR REPLACE TRIGGER trig_validate_rubrique_timing
BEFORE INSERT OR UPDATE OF H_debutR,dureeRub  ON Rubrique
FOR EACH ROW
DECLARE
    spectacle_start spectacle.h_debut%TYPE;
    spectacle_end spectacle.h_debut%TYPE;
    V_IDSPEC Rubrique.idSpec%TYPE;
    V_H_DEBUTR Rubrique.h_debutR%TYPE;
    V_DUREERUB Rubrique.dureeRub%TYPE;
BEGIN
    IF INSERTING THEN
        v_idSpec := :NEW.idSpec;
        v_H_debutR := :NEW.H_debutR;
        v_dureeRub := :NEW.dureeRub;
    ELSIF UPDATING THEN
        v_idSpec := :OLD.idSpec;
        IF UPDATING('H_debutR') THEN
            v_H_debutR := :NEW.H_debutR;   
        ELSE
            v_H_debutR := :OLD.H_debutR;   
        END IF;
        IF UPDATING('dureeRub') THEN
             v_dureeRub := :NEW.dureeRub;     
        ELSE
             v_dureeRub := :OLD.dureeRub;     
        END IF;
    END IF;
    SELECT h_debut, h_debut + dureeS
    INTO spectacle_start, spectacle_end
    FROM SPECTACLE
    WHERE idSpec = v_idSpec;
    IF v_H_debutR < spectacle_start OR v_H_debutR + v_dureeRub > spectacle_end THEN
        RAISE_APPLICATION_ERROR(-20005, 'Les horaires de la rubrique doivent correspondre aux horaires des spectacles.');
    END IF;
END;



