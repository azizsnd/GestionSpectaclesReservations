CREATE OR REPLACE TRIGGER trig_verif_lieu
BEFORE INSERT OR UPDATE OF idLieu, dateS, H_Debut, dureeS, nbrSpectateur ON SPECTACLE
FOR EACH ROW
DECLARE
    Vnb NUMBER;
    v_idLieu   SPECTACLE.idLieu%TYPE;
    v_idSpec   SPECTACLE.idspec%TYPE;
    v_dateS    SPECTACLE.dateS%TYPE;
    v_H_Debut SPECTACLE.H_Debut%TYPE;
    v_duree    SPECTACLE.dureeS%TYPE;
    v_capacite Lieu.capacite%TYPE;
    v_nbSpectateur  SPECTACLE.nbrSpectateur%TYPE;
BEGIN
	--Initialisation des variables
    IF INSERTING THEN
        v_idLieu := :NEW.idLieu;
        v_idSpec := -1;
        v_dateS := :NEW.dateS;
        v_H_Debut := :NEW.H_Debut;
        v_duree := :NEW.dureeS;
        v_nbSpectateur := :NEW.nbrSpectateur;
    ELSIF UPDATING THEN
        v_idSpec := :OLD.idSpec;
        IF UPDATING('idLieu') THEN
            v_idLieu := :NEW.idLieu;   
        ELSE
            v_idLieu := :OLD.idLieu;   
        END IF;

        IF UPDATING('dateS') THEN
            IF :NEW.dateS IS NULL THEN
              RETURN;
            ELSE
                v_dateS := :NEW.dateS;     
            END IF;
        ELSE
            v_dateS := :OLD.dateS;     
        END IF;

        IF UPDATING('H_Debut') THEN
            v_H_Debut := :NEW.H_Debut;  
        ELSE
            v_H_Debut := :OLD.H_Debut;  
        END IF;

        IF UPDATING('dureeS') THEN
            v_duree := :NEW.dureeS;     
        ELSE
            v_duree := :OLD.dureeS;    
        END IF;

        IF UPDATING('nbrSpectateur') THEN
            v_nbSpectateur := :NEW.nbrSpectateur;     
        ELSE
            v_nbSpectateur := :OLD.nbrSpectateur;    
        END IF;
        
    END IF;
	--Vérifier la date
    IF INSERTING OR UPDATING('dateS') THEN
        IF v_dateS <= SYSDATE THEN
        	RAISE_APPLICATION_ERROR(-20002, 'La date du spectacle doit etre supérieure a la date du jour. ');
        END IF;
    END IF;
	--Vérifier la capacité
    IF INSERTING OR UPDATING('idLieu') OR UPDATING('nbrSpectateur') THEN
        SELECT capacite into v_capacite
        FROM Lieu
        WHERE idLieu = v_idLieu;
        IF v_nbSpectateur > v_capacite THEN
        	RAISE_APPLICATION_ERROR(-20003, 'Le nombre de spectateur ne doit pas dépasser la capacité du lieu ');
        END IF;
    END IF;
	--Vérifier la diponibilité du lieu
    IF INSERTING OR UPDATING('idLieu') OR UPDATING('dateS') OR UPDATING('H_Debut') OR UPDATING('dureeS') THEN
        SELECT COUNT(*) INTO Vnb
        FROM vue_spectacle
        WHERE idLieu = v_idLieu
          AND idspec != v_idSpec
          AND dateS = v_dateS
          AND (
              v_h_debut BETWEEN h_debut AND h_fin
              OR (v_h_debut + v_duree) BETWEEN h_debut AND h_fin
              OR v_h_debut <= h_debut AND (v_h_debut + v_duree) >= h_fin
          );
        IF Vnb > 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Le lieu est déjà réservé pour cette date et cet horaire.');
        END IF;
    END IF;
END;