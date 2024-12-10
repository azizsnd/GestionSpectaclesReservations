CREATE MATERIALIZED VIEW vue_spectacle
BUILD IMMEDIATE
REFRESH COMPLETE ON COMMIT
AS
SELECT idLieu,idSpec, dateS, h_debut, h_debut + dureeS AS h_fin
FROM spectacle;