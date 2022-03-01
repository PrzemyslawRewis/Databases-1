CREATE OR REPLACE FUNCTION rob(ID_uczestnik int, kurs int)
RETURNS INTEGER AS
$$
BEGIN
    IF EXISTS(SELECT 1 FROM uczest_kurs WHERE uczest_kurs.id_kurs = kurs AND uczest_kurs.id_uczest = ID_uczestnik)
        THEN RETURN 1;
    END IF;
    IF (SELECT COUNT(uczest_kurs.id_kurs) FROM uczest_kurs WHERE uczest_kurs.id_kurs = kurs) >= (SELECT kurs.max_uczest FROM kurs WHERE kurs.id_kurs = kurs)
        THEN RETURN 2;
    END IF; 
    INSERT INTO uczest_kurs (id_uczest, id_kurs) VALUES (ID_uczestnik, kurs);
    INSERT INTO uczest_zaj
    SELECT id_kurs, id_zaj, uczest_kurs.id_uczest, CASE WHEN RANDOM() < .7 THEN 1 ELSE 0 END AS obec
    FROM zajecia JOIN uczest_kurs USING(id_kurs) WHERE id_uczest = ID_uczestnik AND id_kurs = kurs
    ORDER BY id_kurs, id_zaj, 3;
    RETURN 0;
END;
$$
LANGUAGE 'plpgsql';

SELECT * FROM rob(7,1);







