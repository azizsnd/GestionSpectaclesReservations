CREATE OR REPLACE TRIGGER trg_valider_prix
BEFORE INSERT ON CategorieBillet
FOR EACH ROW
DECLARE
    prix_gold NUMBER;
    prix_silver NUMBER;
    prix_normale NUMBER;
BEGIN
    SELECT Max(prix) INTO prix_gold
    FROM CategorieBillet
    WHERE idSpec = :NEW.idSpec AND UPPER(categorie) = 'GOLD';
    SELECT Max(prix) INTO prix_silver
    FROM CategorieBillet
    WHERE idSpec = :NEW.idSpec AND UPPER(categorie) = 'SILVER';
    SELECT Max(prix) INTO prix_normale
    FROM CategorieBillet
    WHERE idSpec = :NEW.idSpec AND UPPER(categorie) = 'NORMALE';
    IF UPPER(:NEW.categorie) = 'GOLD' THEN
        IF (:NEW.prix <= NVL(prix_silver, 0)) OR (:NEW.prix <= NVL(prix_normale, 0)) THEN
            RAISE_APPLICATION_ERROR(-20008, 'Le prix de la catégorie Gold doit être supérieur à celui des catégories Silver et Normale.');
        END IF;
    ELSIF UPPER(:NEW.categorie) = 'SILVER' THEN
        IF (:NEW.prix >= NVL(prix_gold, :NEW.prix + 1)) OR (:NEW.prix <= NVL(prix_normale, 0)) THEN
            RAISE_APPLICATION_ERROR(-20009, 'Le prix de la catégorie Silver doit être inférieur à celui de Gold et supérieur à celui de Normale.');
        END IF;
    ELSIF UPPER(:NEW.categorie) = 'NORMALE' THEN
        IF (:NEW.prix >= NVL(prix_gold, :NEW.prix + 1)) OR (:NEW.prix >= NVL(prix_silver, :NEW.prix + 1)) THEN
            RAISE_APPLICATION_ERROR(-20010, 'Le prix de la catégorie Normale doit être inférieur à celui des catégories Gold et Silver.');
        END IF;
    END IF;
END;