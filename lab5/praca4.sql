set search_path to kurs;

select (select kurs_opis.opis from kurs_opis where kurs_opis.id_nazwa = kurs.id_nazwa),
(select cast(count(*) * 100.0/(select count(*) from uczest_kurs) as decimal(3, 1))
from uczest_kurs where uczest_kurs.id_kurs=kurs.id_kurs) as stat_osob,
(select cast(count(uczest_kurs.ocena) * 100.0/(select count(ocena) from uczest_kurs where uczest_kurs.id_kurs=kurs.id_kurs) as decimal(4, 1))
from uczest_kurs where uczest_kurs.id_kurs=kurs.id_kurs and uczest_kurs.ocena >= 4) as stat_ocena
from kurs;

select imie, nazwisko,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 1) as k1,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 2) as k2,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 3) as k3,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 4) as k4,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 5) as k5,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 6) as k6,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 7) as k7,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 8) as k8,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 9) as k9,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 10) as k10,
(select 'x' from uczest_kurs where uczest_kurs.id_uczest = uczestnik.id_uczestnik and uczest_kurs.id_kurs = 11) as k11
from uczestnik;

select (select kurs_opis.opis from kurs_opis where kurs_opis.id_nazwa = kurs.id_nazwa),
(select count(ocena) from uczest_kurs where uczest_kurs.id_kurs = kurs.id_kurs and uczest_kurs.ocena = 3) as ocena_3,
(select count(ocena) from uczest_kurs where uczest_kurs.id_kurs = kurs.id_kurs and uczest_kurs.ocena = 4) as ocena_4,
(select count(ocena) from uczest_kurs where uczest_kurs.id_kurs = kurs.id_kurs and uczest_kurs.ocena = 5) as ocena_5,
(select count(ocena) from uczest_kurs where uczest_kurs.id_kurs = kurs.id_kurs and uczest_kurs.ocena is null) as ocena_null
from kurs;