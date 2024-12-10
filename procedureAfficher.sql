CREATE OR REPLACE PROCEDURE p_afficher_msg( msg varchar ) as
BEGIN
 DBMS_OUTPUT.PUT_LINE(msg);
END;