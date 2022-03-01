CREATE OR REPLACE FUNCTION equ_tables(a int,b int, c int, xStart int,delX int,liczbaRekordow int)
RETURNS TABLE (i int, x int, y int) AS
$$
DECLARE
  j INTEGER := 0;
BEGIN
  LOOP
    EXIT WHEN j>liczbaRekordow-1;
    j := j + 1;
    i := j;
    x := xStart + (i-1)*delX;
    y := a*x*x+b*x+c;
    RETURN NEXT;
  END LOOP;
END; 
$$
LANGUAGE 'plpgsql';

SELECT * FROM equ_tables(1,2,1,1,1,10);



CREATE OR REPLACE FUNCTION equ_solve(a int,b int,c int)
RETURNS TEXT AS
$$
DECLARE
  delta INTEGER := b*b-4*a*c;
  x1 DOUBLE PRECISION;
  x2 DOUBLE PRECISION;
  b1 DOUBLE PRECISION :=b;
BEGIN
    RAISE INFO 'DELTA = %',delta;
    IF delta > 0 THEN
        RAISE INFO 'Rozwiazanie posiada dwa rzeczywiste pierwiastki';
        x1=(-b+sqrt(delta))/(2*a);
        x2=(-b-sqrt(delta))/(2*a);
        RAISE INFO 'x1 = %',x1;
        RAISE INFO 'x2 = %',x2;
        RETURN '(x1 = ' || x1 ||' ),(x2 = ' || x2 || ' )';
    END IF;    
    IF delta = 0 THEN
        RAISE INFO 'Rozwiazanie posiada jeden rzeczywisty pierwiastek';
        x1=-b/(2*a);
        RAISE INFO 'x1 = x2 = %',x1;
        RETURN '(x1 = ' || x1 ||' ),(x2 = ' || x1 || ' )';
    END IF;    
    IF delta < 0 THEN
        RAISE INFO 'Rozwiazanie w dziedzinie liczb zespolonych';  
        x1=-b1/(2*a);
        x2=sqrt(-delta)/(2*a);
        RAISE INFO 'x1 = % + %i',x1,x2;
        RAISE INFO 'x2 = % - %i',x1,x2;
        RETURN '(x1 = ' || x1 ||' + ' || x2 || 'i ),(x2 = ' || x1 ||' - ' || x2 || 'i )';
    END IF;
END;
$$ LANGUAGE 'plpgsql';

SELECT equ_solve(1,10,1);
SELECT equ_solve(1,4,4);
SELECT equ_solve(10,5,1);



CREATE OR REPLACE FUNCTION uczest_wykladowca(id int)
RETURNS TABLE (w_nazwisko VARCHAR,w_imie VARCHAR) AS
$$
SELECT DISTINCT wykladowca.nazwisko AS w_nazwisko, wykladowca.imie AS w_imie FROM wykladowca
    JOIN wykl_kurs ON wykladowca.id_wykladowca=wykl_kurs.id_wykl
    JOIN uczest_kurs ON wykl_kurs.id_kurs= uczest_kurs.id_kurs
    WHERE uczest_kurs.id_uczest = id;
$$
LANGUAGE 'sql';

SELECT * FROM uczest_wykladowca(1);



CREATE OR REPLACE FUNCTION uczest_kurs(id int)
RETURNS TABLE (z_opis VARCHAR) AS
$$
    SELECT kurs_opis.opis FROM kurs
        JOIN kurs_opis ON kurs_opis.id_nazwa = kurs.id_nazwa
        JOIN uczest_kurs ON kurs.id_kurs = uczest_kurs.id_kurs
    WHERE uczest_kurs.id_uczest=id
    GROUP BY kurs_opis.opis;    
$$
LANGUAGE 'sql';

SELECT * FROM uczest_kurs(1);



CREATE OR REPLACE FUNCTION lista_obec(id int)
RETURNS TABLE (s_nazwisko VARCHAR,s_imie VARCHAR, z1 BIGINT,z2 BIGINT,z3 BIGINT,z4 BIGINT,z5 BIGINT,z6 BIGINT,z7 BIGINT,z8 BIGINT,z9 BIGINT,z10 BIGINT,sum BIGINT) AS
$$
SELECT uczestnik.nazwisko, uczestnik.imie,
	SUM(case when id_zaj = 1 then obec end) as z1,
	SUM(case when id_zaj = 2 then obec end) as z2,
	SUM(case when id_zaj = 3 then obec end) as z3,
	SUM(case when id_zaj = 4 then obec end) as z4,
	SUM(case when id_zaj = 5 then obec end) as z5,
	SUM(case when id_zaj = 6 then obec end) as z6,
	SUM(case when id_zaj = 7 then obec end) as z7,
	SUM(case when id_zaj = 8 then obec end) as z8,
	SUM(case when id_zaj = 9 then obec end) as z9,
	SUM(case when id_zaj = 10 then obec end) as z10,
	SUM(obec)
FROM uczestnik
    JOIN uczest_zaj ON uczestnik.id_uczestnik=uczest_zaj.id_uczest WHERE uczest_zaj.id_kurs = id
GROUP BY uczestnik.nazwisko, uczestnik.imie
ORDER BY uczestnik.nazwisko;     
$$
LANGUAGE 'sql';

SELECT * FROM lista_obec(1);

