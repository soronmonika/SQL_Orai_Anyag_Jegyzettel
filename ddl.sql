/*
Megfelelõ sorrend fontos
*/


-- Egy soros komment

/*
Tobb
soros
komment
*/

/*egy szerveren két adatbázis nem lehet*/

/*DDL-> az adatbázis sémájának kialakításához, felépítéséhez, és annak módosításához szükséges parancsokat foglalja magába. Ezek a parancsok, az adatbázis felügyelõ munkáját segít, 
illetve teszi lehetõpsvé. EK diagramban felépített sémát ezzel tudjuk gyakorlatba ültetni.*/


-- AB letrehozas: adatbázis
CREATE DATABASE `20251009KCS` /*létrehozó parancs:  kijelölöm azt a parancsot, majd futtatás(execute)*/
CHARACTER SET utf8 /*karakter kódolás */
COLLATE utf8_hungarian_ci;/*utf8-as case inssensitive(kia és nagy betû független érzékeny lesz)*/


-- mappákba szedi: Table

-- AB kivalasztasa
USE `20251009KCS`;/*ki kell választani az aktív adatbázis amithasználni fogok*/

-- Tabla letrehozasa: (reláció =egyedhalmaz=tábla && az adatmodellben az egyes egyedek tulajdonságait a tábla tárolja, a felépített reláció alapján)
CREATE TABLE `Ember`(
  /* NEV(oszlop) (oszlop)TIPUS EGYEBEK,(Attribútom=oszlop=tulajdonság && az adatmodellben az egyes attribútumokat, az oszlopok testesíti meg, 
  mely a reláció felhasznált tulajdonsághalmaz elemeit veheti fel.)*/
  `SZIG` CHAR(8) PRIMARY KEY, -- egyszerû elsõdkeleges kulcs
  `Vnev` VARCHAR(100) NOT NULL, /*NOT NULL- közelezõen kitöltendõ*/
  `Knev` VARCHAR(100) NOT NULL,
  `Unev` VARCHAR(200) DEFAULT 'N.A.', /*DEFAULT érték- alapértelmezett érték - elõre meghatározott érték 'szövegesen'*/
  `SzulDatum` DATE NOT NULL,
  `GyerekDb` TINYINT DEFAULT 0 /*TINYIT - Byte*/
  -- az utolsó oszlop felsorolás után sehol nem szabad vesszõt tenni
);

/* az ember táblát nem fogja hagyni törölni, mert össze vannak kötve az idegen kulccsal. Ezért elõbb a Jármû táblát törlöm, majd az Ember táblát.*/

CREATE TABLE Jarmu(
  -- ID INT PRIMARY KEY AUTO_INCREMENT: amikor beszúrom az ID azonosítót, autómatikusan hozzá rendel egy egyedi azonosítót. autómata érték növelés
  Felsegjelzes VARCHAR(3),
  Rendszam VARCHAR(20),
  Gyarto VARCHAR(50) NOT NULL,
  Tipus VARCHAR(50),
  Hengerurtartalom FLOAT DEFAULT 50.0,
  GyartasiIdo DATE DEFAULT '1900-01-01',
  Alvazszam CHAR(12) /*UNIQUE*/ NOT NULL, /*UNIQUE - egyedi kulcs - hiába nem az elsõdleges kulcs, akkor sem lehet egyforma más tulajdonsággal*/
  TulajSZIG CHAR(8),/*IDEGENKULCS - MEG KELL EGYEZNI A TÍPUSNAK! RÁMUTATÓ IDEGENKULCS TÍPUSÁNAK IS CHAR (8)*/  

  /*CONSTRAINT PK_Jarmu_FelsegjelzesRendszam (elnevezes)*/ PRIMARY KEY (Felsegjelzes, Rendszam), /* összetett elsõdleges kulcs*/
  CONSTRAINT FK_JarmuTulajSZIG_EmberSZIG FOREIGN KEY (TulajSZIG) REFERENCES Ember(SZIG), 
  /*FOREIGN KEY=idegen kulcs: két tábla közötti kapcsolatot fogja megteremteni. CSAK AZ OSZLOPOK UTÁNA BEÁLLÍTÁS!(indexek mappába találjuk<--))*/
  CONSTRAINT UQ_Jarmu_Alvazszam UNIQUE (Alvazszam)/*CONSTRAINT elnevezés- megkötés - valamirõl megakarod szüntetni, az idegen kulcsot, 
  akkor a megkötéseket kell törölni.||parancsból töröljük.*/
);

-- Nezettabla
/*
CREATE VIEW Nezettabla AS <lekérdezés>;
*/

-- Esemenyindito
/*
CREATE TRIGGER <név> {AFTER | BEFORE} {INSERT | UPDATE | DELETE}
ON <tbl_neve> FOR EACH ROW
BEGIN
 <parancs(ok)>
END;
*/

-- AB modositas: 
ALTER DATABASE `20251009KCS`
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

-- Tabla modositas
ALTER TABLE Ember
ADD COLUMN TAJ CHAR(9); -- új oszlopot veszek fel

ALTER TABLE Ember
ADD CONSTRAINT UQ_Ember_TAJ UNIQUE (TAJ); -- egyedi kulcs lesz a taj. utólagos megkötés

ALTER TABLE Ember
MODIFY TAJ CHAR(8); -- az oszlopon típus módosítás 

ALTER TABLE Ember
CHANGE TAJ TAJSZAM CHAR(9); -- átnevezés, csere, módosítás

ALTER TABLE Ember
DROP CONSTRAINT UQ_Ember_TAJ; -- nem akarom, hogy egyedi kulcs legyen, ezért törlöm

ALTER TABLE Ember
DROP COLUMN TAJSZAM; -- oszlop törlés

-- Nezettabla modositas
/*
ALTER VIEW Nezettabla AS <lekérdezés>;
*/

-- Esemenyindito modositas
/*
Regi torlese, uj felvetele
*/

-- Torlesek
DROP DATABASE 20251009kcs; -- adatbázis törlés
DROP TABLE jarmu; -- tábla törlés
-- DROP VIEW Nezettabla; -- nézettábla törlés
-- DROP TRIGGER Esemenyindito; -- trigger törlés

-- Alaphelyezetbe allitas - csak a tábláknál mûködik
TRUNCATE TABLE ember; -- alaphelyzetben a tábla üres/ ürít. 


/*
Oszlop beállítási lehetõségek:
hivatalosan egyetlen tábla sem létezhet elsõdleges kulcs nélkül. 
PRIMARY KEY : elsõdleges kulcs: olyan egyszerû vagy öszetett kulcs, mely pontosan tudja azonosítani az adott sort. 
*/