SELECT opis as nazwa_kursu, COUNT(uczest_kurs.id_uczest) as liczba_osób
FROM kurs_opis  LEFT JOIN  kurs ON kurs_opis.id_nazwa = kurs.id_nazwa
                  LEFT JOIN uczest_kurs USING (id_kurs) GROUP BY opis ORDER BY 1 ;

SELECT opis as nazwa_kursu, SUM(case when oplata is null then 0.0 else oplata end) as suma_oplat
FROM kurs_opis  LEFT JOIN  kurs ON kurs_opis.id_nazwa = kurs.id_nazwa
                  LEFT JOIN uczest_kurs USING (id_kurs) GROUP BY opis ORDER BY 1 ;

SELECT opis as nazwa_kursu, avg(case when ocena is null then 0.0 else ocena end)::decimal(6,2) as średnia_ocen
FROM kurs_opis  LEFT JOIN  kurs ON kurs_opis.id_nazwa = kurs.id_nazwa
                  LEFT JOIN uczest_kurs USING (id_kurs) GROUP BY opis ORDER BY 1 ;


SELECT imie, nazwisko, COUNT(*) as liczba_kursow FROM wykladowca,wykl_kurs,kurs where wykl_kurs.id_kurs=kurs.id_kurs and wykladowca.id_wykladowca=wykl_kurs.id_wykl GROUP BY imie,nazwisko having count(*)>0 order by 1 ;

SELECT imie, nazwisko FROM wykladowca w LEFT JOIN wykl_kurs wk ON w.id_wykladowca = wk.id_wykl 
WHERE wk.id_wykl IS NULL ORDER BY 1;

SELECT imie, nazwisko FROM uczestnik,uczest_kurs,kurs where uczest_kurs.id_kurs=kurs.id_kurs and uczest_kurs.id_uczest=uczestnik.id_uczestnik GROUP BY imie,nazwisko having count(*)>1 ORDER BY 1 ;

SELECT imie, nazwisko, COUNT(uczest_kurs.id_uczest) as liczba_kursow, SUM(case when oplata is null then 0.0 else oplata end) as suma_oplat, avg(case when ocena is null then 0.0 else ocena end)::decimal(6,2) as srednia_oc, min(case when ocena is null then 0.0 else ocena end) as min_oc, max(case when ocena is null then 0.0 else ocena end) as max_oc 
FROM uczestnik LEFT JOIN  uczest_kurs ON uczestnik.id_uczestnik = uczest_kurs.id_uczest 
		LEFT JOIN kurs USING (id_kurs) GROUP BY imie,nazwisko ORDER BY 1 ;

SELECT imie,nazwisko,max(foo.itemsum) as kwota FROM (select imie, nazwisko, sum(oplata) as itemsum from  uczestnik, uczest_kurs, kurs where uczest_kurs.id_kurs=kurs.id_kurs and uczest_kurs.id_uczest=uczestnik.id_uczestnik GROUP BY imie,nazwisko) as foo  GROUP BY imie,nazwisko order by 3 desc limit 1;

SELECT wykladowca.id_wykladowca as id_w, wykladowca.imie as imie_w, wykladowca.nazwisko as nazwisko_w, id_uczestnik as id_u, uczestnik.imie as imie_u,uczestnik.nazwisko as nazwisko_u FROM wykladowca,wykl_kurs,kurs,uczest_kurs,uczestnik where wykl_kurs.id_kurs=kurs.id_kurs and wykladowca.id_wykladowca=wykl_kurs.id_wykl and uczest_kurs.id_kurs=kurs.id_kurs and uczest_kurs.id_uczest=uczestnik.id_uczestnik GROUP BY wykladowca.id_wykladowca,wykladowca.imie, wykladowca.nazwisko,uczestnik.id_uczestnik,uczestnik.imie,uczestnik.nazwisko order by 1 ;

SELECT wykladowca.id_wykladowca as id_w, wykladowca.imie as imie_w, wykladowca.nazwisko as nazwisko_w, COUNT(uczest_kurs.id_uczest) as liczba_u FROM wykladowca
 LEFT JOIN wykl_kurs ON wykladowca.id_wykladowca = wykl_kurs.id_wykl
  LEFT JOIN kurs USING (id_kurs)
	 LEFT JOIN uczest_kurs USING (id_kurs)
		LEFT JOIN uczestnik ON uczest_kurs.id_uczest=uczestnik.id_uczestnik 
GROUP BY wykladowca.id_wykladowca,wykladowca.imie, wykladowca.nazwisko order by 1 ;















