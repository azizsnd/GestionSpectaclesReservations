select * from billet;
select * from spectacle;
BEGIN
 pack_gestion_spectacle.p_vendre_billet(5);
END
;
select * from billet;
select * from spectacle;