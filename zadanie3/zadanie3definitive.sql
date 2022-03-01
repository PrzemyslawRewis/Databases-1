SELECT
  Zamówienie.ID_ZAMOWIENIE,
  Zamówienie.data,
  Stan_realizacji_zamówienia.stan_realizacji,
  Klient.imie,
  Klient.nazwisko,
  Klient.adres_email,
  SUM(Zamówienie_produkty.ilość*Produkt.cena) as "Wartość"
FROM
  Zamówienie 
  JOIN Stan_realizacji_zamówienia ON (Zamówienie.stan = Stan_realizacji_zamówienia.ID_STAN_REALIZACJI)
  JOIN Klient USING (ID_KLIENT)
  JOIN Zamówienie_produkty USING (ID_ZAMOWIENIE)
  JOIN Produkt USING (ID_PRODUKT)
GROUP BY
  Zamówienie.ID_ZAMOWIENIE,
  Zamówienie.data,
  Stan_realizacji_zamówienia.stan_realizacji,
  Klient.imie,
  Klient.nazwisko,
  Klient.adres_email,
ORDER BY
  Zamówienie.ID_ZAMOWIENIE
;



SELECT 
  Zamówienie.ID_ZAMOWIENIE as "Numer zamówienia",
  Zamówienie.data as "Data zamówienia",
  Klient.imie as "Imie klienta",
  Klient.nazwisko as "Nazwisko klienta",
  Klient.adres_email as "Adres email",
  Stan_realizacji_zamówienia.stan_realizacji as "Stan realizacji"
FROM 
  Zamówienie 
  JOIN Klient USING (ID_KLIENT) 
  JOIN Stan_realizacji_zamówienia ON (Zamówienie.stan = Stan_realizacji_zamówienia.ID_STAN_REALIZACJI)
WHERE Zamówienie.ID_ZAMOWIENIE = 1;
SELECT 
  Produkt.nazwa as "Nazwa produktu",
  Kategoria.nazwa as "Kategoria",
  Zamówienie_produkty.ilość, as "Ilość"
  Produkt.cena as "Cena",
  SUM(Zamówienie_produkty.ilość*Produkt.cena) as "Wartość"
FROM
  Zamówienie_produkty
  JOIN Produkt ON (Zamówienie_produkty.ID_PRODUKT = Produkt.ID_PRODUKT)
  JOIN Kategoria ON (Produkt.ID_KATEGORIA = Kategoria.ID_KATEGORIA)
WHERE
  Zamówienie_produkty.ID_ZAMOWIENIE = 1
GROUP BY
  Produkt.nazwa,
  Kategoria.nazwa,
  Zamówienie_produkty.ilość,
  Produkt.cena
;
