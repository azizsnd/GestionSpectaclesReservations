CREATE OR REPLACE TRIGGER trig_modif_sepc
AFTER UPDATE OF H_Debut, dureeS ON SPECTACLE
FOR EACH ROW
DECLARE
    Vnb NUMBER;
BEGIN
   IF ( UPDATING('h_debut')) THEN
       UPDATE rubrique 
       SET h_debutr=h_debutr+(:new.H_Debut-:old.H_Debut)
       WHERE idspec= :old.idspec;
   END IF;
   IF ( UPDATING('dureeS')) THEN 
      SELECT count(idrub) INTO Vnb
      FROM rubrique
      where idspec= :old.idspec;
      IF( Vnb >0 ) THEN 
           UPDATE rubrique 
           SET dureerub=dureerub+(:new.dureeS-:old.dureeS)/Vnb
           WHERE idspec= :old.idspec;
      END IF;      
   END IF;
END;