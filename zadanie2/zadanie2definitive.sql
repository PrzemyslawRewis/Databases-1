CREATE OR REPLACE VIEW dane AS
SELECT 
    osoba.id as "ID",
    osoba.imie as "Imie",
    osoba.nazwisko as "Nazwisko",
    osoba.data_urodzenia as "Data urodzenia",
    osoba.data_zgonu as "Data zgonu",
    osoba.kobieta as "Plec zenska",
    osoba.miejsce_urodzenia as "Miejsce urodzenia",
    malzonek.imie as "Imie malzonka",
    malzonek.nazwisko as "Nazwisko malzonka"
FROM
    czlowiek osoba
LEFT JOIN slub wesele 
    ON CASE
       WHEN osoba.kobieta = false THEN wesele.id_malzonek2
	   WHEN osoba.kobieta = true THEN wesele.id_malzonek1
	   END = osoba.id
	   AND wesele.active = true
LEFT JOIN czlowiek malzonek
    ON CASE
       WHEN osoba.kobieta = false THEN wesele.id_malzonek1
	   WHEN osoba.kobieta = true THEN wesele.id_malzonek2
	   END = malzonek.id;

SELECT * FROM dane WHERE ID = idosoby;
	 

SELECT 
    osoba.imie as "Imie",
    osoba.nazwisko as "Nazwisko",
    m.imie as "Imie rodzica 1",
    m.nazwisko as "Nazwisko rodzica 1",
    m.data_urodzenia as "Data urodzenia rodzica 1",
    m.miejsce_urodzenia as "Miejsce urodzenia rodzica 1",
    t.imie as "Imie rodzica 2",
    t.nazwisko as "Nazwisko rodzica 2",
    t.data_urodzenia as "Data urodzenia rodzica 2",
    t.miejsce_urodzenia as "Miejsce urodzenia rodzica 2"
FROM
    czlowiek osoba
    LEFT JOIN czlowiek m ON (osoba.id_rodzic1 = m.id)
    LEFT JOIN czlowiek t ON (osoba.id_rodzic2 = t.id)
WHERE
    osoba.id = idosoby;


SELECT
    rodzic.imie as "Imie rodzica",
    rodzic.nazwisko as "Nazwisko rodzica",
    dziecko.imie as "Imie dziecka"
FROM
    czlowiek rodzic
    LEFT JOIN czlowiek dziecko
        ON CASE
            WHEN osoba.kobieta = false THEN dziecko.id_rodzic2
	        WHEN osoba.kobieta = true THEN dziecko.id_rodzic1
	        END = rodzic.id
WHERE
    osoba.id = idosoby;