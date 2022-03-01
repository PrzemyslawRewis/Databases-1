CREATE SCHEMA praca2 ;
set search_path to praca2 ;
create table KLIENT(ID_K int,IMIE varchar(30),NAZWISKO varchar(30));
create table TOWAR(ID_T int,NAZWA varchar(30));
create table ZAMOWIENIE(ID_Z int,ID_KLIENT int);
create table Z_T(ID_ZAM int,ID_TOW int,ILOSC int);
alter table KLIENT add primary key(ID_K);
alter table TOWAR add primary key(ID_T);
alter table ZAMOWIENIE add primary key(ID_Z);
alter table Z_T add primary key(ID_ZAM,ID_TOW);
alter table ZAMOWIENIE add foreign key(ID_KLIENT) references KLIENT(ID_K);
alter table Z_T add foreign key(ID_ZAM) references ZAMOWIENIE(ID_Z);
alter table Z_T add foreign key(ID_TOW) references TOWAR(ID_T);
insert into KLIENT ( ID_K, IMIE, NAZWISKO ) values 
( 1, 'Jan', 'Flisikowski'),
( 2, 'Andrzej', 'Olech'      ),
( 3, 'Piotr', 'Płochocki'    ),
( 4, 'Krzysztof', 'Stachyra' ),
( 5, 'Stanisław', 'Sztuka'   ),
( 6, 'Tomasz', 'Sosin'       ),
( 7, 'Paweł', 'Głowala'      ),
( 8, 'Józef', 'Straszewski'  ),
( 9, 'Marcin', 'Dwojak'      ),
(10, 'Marek', 'Kotulski'    );
insert into TOWAR ( ID_T, NAZWA) values 
( 1, 'Jabłko'),
( 2, 'Mleko'  ),
( 3, 'Truskawki'),
( 4, 'Jogurt'),
( 5, 'Chleb'),
( 6, 'Banany'),
( 7, 'Kawa'),
( 8, 'Herbata'),
( 9, 'Sos'),
(10, 'Musztarda'),
(11, 'Schab'),
(12, 'Karkówka'),
(13, 'Piwo'),
(14, 'Wino'),
(15, 'Ziemniaki'),
(16, 'Ryż'),
(17, 'Makaron'),
(18, 'Mąka'),
(19, 'Cukier'),
(20, 'Marchewka'),
(21, 'Cebula'),
(22, 'Papryka'),
(23, 'Ogórek');

insert into ZAMOWIENIE ( ID_Z, ID_KLIENT) values 
( 1, 3),
( 2, 3),
( 3, 1),
( 4, 2),
( 5, 4),
( 6, 5),
( 7, 6),
( 8, 7),
( 9, 8),
(10, 9),
(11,10);

insert into Z_T(ID_ZAM, ID_TOW ,ILOSC) values
( 1, 3, 8),
( 1, 8, 9),
( 1, 9, 10),
( 2, 22, 7),
( 2, 7,5),
( 2, 2,1),
( 2, 18,1),
( 3, 16,7),
( 3, 15,7),
( 3, 14,7),
( 4, 21,7),
( 4, 20,7),
( 5, 4,7),
( 6, 13,5),
( 6, 17,5),
( 6, 19,5),
( 7, 6,5),
( 7, 23,5),
( 8, 1,5),
( 9, 11,5),
(10, 12,5),
(11,10,5),
(11,5,5),
(11,11,5);


SELECT KLIENT.ID_K,KLIENT.IMIE,KLIENT.NAZWISKO, ZAMOWIENIE.ID_Z
FROM KLIENT, ZAMOWIENIE
WHERE KLIENT.ID_K = 3 and KLIENT.ID_K=ZAMOWIENIE.ID_KLIENT;

SELECT ZAMOWIENIE.ID_Z,TOWAR.NAZWA
FROM ZAMOWIENIE,Z_T,TOWAR
WHERE ZAMOWIENIE.ID_Z = Z_T.ID_ZAM and ZAMOWIENIE.ID_Z=2 and Z_T.ID_TOW=TOWAR.ID_T;

SELECT TOWAR.NAZWA,ZAMOWIENIE.ID_Z,Z_T.ILOSC
FROM ZAMOWIENIE,Z_T,TOWAR
WHERE ZAMOWIENIE.ID_Z = Z_T.ID_ZAM and TOWAR.NAZWA='Schab' and Z_T.ID_TOW=TOWAR.ID_T;







