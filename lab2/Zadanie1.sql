CREATE SCHEMA zadanie1;
use zadanie1;

CREATE TABLE `zadanie1`.`new_table` (
  `Identyfikator` INT NOT NULL ,
  `Nazwisko` VARCHAR(45) NOT NULL,
  `Imie` VARCHAR(45) NOT NULL,
  `Telefon` VARCHAR(45) NOT NULL,
  `Miejscowosc` VARCHAR(45) NULL,
  `Kod` VARCHAR(45) NULL,
  `Ulica` VARCHAR(45) NULL,
  `Numer mieszkania` VARCHAR(45) NULL,
  `Pole opisowe` VARCHAR(45) NULL,
  PRIMARY KEY (`Identyfikator`));
  
INSERT INTO new_table values
    ( 1,'Abacki','Adam','123456789','Jaslo','38-200','Piotra Skargi','44a','XXXX' ),
    ( 2,'Babacki','Marek','806808200','Krosno','38-400','Przemysłowa','45a','XXXX' ),
	( 3,'Cabacka','Anna','501262854','Jaslo','38-200','Czackiego','46a','XXXX' ),
    ( 4,'Dadacka','Aleksandra','653140350','Krosno','38-400','Przemysłowa','47a','XXXX' ),
    ( 5,'Ebacki','Jan','617891186','Jaslo','38-200','Czackiego','41a','XXXX' ),
    ( 6,'Fabacki','Henryk','811435394','Krosno','38-400','Szczepana','42a','XXXX' ),
    ( 7,'Gacki','Jakub','736307637','Jaslo','38-200','Piotra Skargi','43a','XXXX' ),
    ( 8,'Kowalski','Marek','767511138','Krosno','38-400','Szczepana','54a','XXXX' ),
    ( 9,'Nowak','Zbigniew','315224787','Jaslo','38-200','Czackiego','64a','XXXX' ),
     ( 10,'Nowak','Janusz','315284787','Jaslo','38-200','Dworcowa','94a','XXXX' );
    

SELECT  Nazwisko, Imie,Telefon FROM new_table ORDER BY Nazwisko;
SELECT * FROM new_table WHERE Nazwisko='Kowalski';
SELECT * FROM new_table WHERE Imie='Adam';
SELECT * FROM new_table WHERE Telefon like '3%';
SELECT * FROM new_table WHERE Miejscowosc='Krosno';
UPDATE new_table SET  Nazwisko = 'Korek'  WHERE Identyfikator = 5 ;
DELETE FROM new_table WHERE Identyfikator =10 ;

