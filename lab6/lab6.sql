CREATE OR REPLACE VIEW zadaniepierwsze AS
with CTE as (
	SELECT id_uczest,
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
	SUM(obec) as sum
	FROM uczest_zaj
	WHERE id_kurs = 1
)
SELECT p.nazwisko, p.imie, view.z1, view.z2, view.z3, view.z4, view.z5, view.z6, view.z7, view.z8, view.z9, view.z10, view.sum
FROM uczestnik p
JOIN CTE view ON (p.id_uczestnik = view.id_uczest)
ORDER BY p.nazwisko, p.imie;

SELECT * FROM zadaniepierwsze;



CREATE OR REPLACE VIEW zadaniedrugie AS
WITH CTE AS
	(SELECT DISTINCT id_kurs FROM kurs)
SELECT ko.opis as "Kurs", k.id_grupa as "Gr.",
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 1) as z1,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 2) as z2,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 3) as z3,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 4) as z4,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 5) as z5,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 6) as z6,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 7) as z7,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 8) as z8,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 9) as z9,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa AND id_zaj = 10) as z10,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = k.id_kurs AND id_grupa = k.id_grupa) as "sum"
FROM kurs_opis ko, kurs k
WHERE ko.id_nazwa = k.id_nazwa;

SELECT * FROM zadaniedrugie;


CREATE OR REPLACE VIEW zadanietrzecie AS
WITH CTE AS
	(SELECT DISTINCT id_wykl FROM wykl_kurs)
SELECT wk.nazwisko as "Nazwisko", wk.imie as "Imie",
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 1 HAVING COUNT(id_kurs) > 0) as k1,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 2 HAVING COUNT(id_kurs) > 0) as k2,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 3 HAVING COUNT(id_kurs) > 0) as k3,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 4 HAVING COUNT(id_kurs) > 0) as k4,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 5 HAVING COUNT(id_kurs) > 0) as k5,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 6 HAVING COUNT(id_kurs) > 0) as k6,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 7 HAVING COUNT(id_kurs) > 0) as k7,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 8 HAVING COUNT(id_kurs) > 0) as k8,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 9 HAVING COUNT(id_kurs) > 0) as k9,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 10 HAVING COUNT(id_kurs) > 0) as k10,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl AND id_kurs = 11 HAVING COUNT(id_kurs) > 0) as k11,
	(SELECT COUNT(id_kurs) FROM wykl_kurs WHERE id_wykl = wkk.id_wykl) as "sum"
FROM wykladowca wk, CTE wkk
WHERE wk.id_wykladowca = wkk.id_wykl
ORDER BY wk.nazwisko, wk.imie;

SELECT * FROM zadanietrzecie;