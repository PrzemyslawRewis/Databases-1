 /* wybrany przykladowy przystanek posiada id_przystanku=1 */

 SELECT AUTOBUS.id_autobusu, PRZYSTANEK.id_przystanku, PRZYSTANEK.nazwa
 FROM AUTOBUS, AUTO_PRZYST, PRZYSTANEK
 WHERE AUTOBUS.id_autobusu = AUTO_PRZYST.id_auto and
       PRZYSTANEK.id_przystanku = AUTO_PRZYST.id_przyst and
       PRZYSTANEK.id_przystanku = 1; 


/* wybrany przykladowy przystanek posiada id_przystanku=1 przykladowa linia id_autobusu=2*/

 SELECT AUTOBUS.id_autobusu, PRZYSTANEK.id_przystanku, PRZYSTANEK.nazwa, AUTO_PRZYST.id_odjazdu, AUTO_PRZYST.czasodjazdu
 FROM AUTOBUS, AUTO_PRZYST, PRZYSTANEK
 WHERE AUTOBUS.id_autobusu = AUTO_PRZYST.id_auto and
       PRZYSTANEK.id_przystanku = AUTO_PRZYST.id_przyst and
       AUTO_PRZYST.id_odjazdu = PRZYSTANEK.id_odjazd and
       PRZYSTANEK.id_przystanku = 1 and
       AUTOBUS.id_autobusu=2;

/* wybrana przykladowy  przykladowa linia id_autobusu=2*/

 SELECT AUTOBUS.id_autobusu, PRZYSTANEK.id_przystanku, PRZYSTANEK.nazwa, AUTO_PRZYST.id_odjazdu, AUTO_PRZYST.czasodjazdu
 FROM AUTOBUS, AUTO_PRZYST, PRZYSTANEK
 WHERE AUTOBUS.id_autobusu = AUTO_PRZYST.id_auto and
       PRZYSTANEK.id_przystanku=AUTO_PRZYST.id_przyst and
       AUTO_PRZYST.id_odjazdu= PRZYSTANEK.id_odjazd and
       AUTOBUS.id_autobusu=2;                  