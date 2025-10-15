/*
Megfelel� sorrend fontos
*/


-- Egy soros komment

/*
Tobb
soros
komment
*/

/*egy szerveren k�t adatb�zis nem lehet*/

/*DDL-> az adatb�zis s�m�j�nak kialak�t�s�hoz, fel�p�t�s�hez, �s annak m�dos�t�s�hoz sz�ks�ges parancsokat foglalja mag�ba. Ezek a parancsok, az adatb�zis fel�gyel� munk�j�t seg�t, 
illetve teszi lehet�psv�. EK diagramban fel�p�tett s�m�t ezzel tudjuk gyakorlatba �ltetni.*/


-- AB letrehozas: adatb�zis
CREATE DATABASE `20251009KCS` /*l�trehoz� parancs:  kijel�l�m azt a parancsot, majd futtat�s(execute)*/
CHARACTER SET utf8 /*karakter k�dol�s */
COLLATE utf8_hungarian_ci;/*utf8-as case inssensitive(kia �s nagy bet� f�ggetlen �rz�keny lesz)*/


-- mapp�kba szedi: Table

-- AB kivalasztasa
USE `20251009KCS`;/*ki kell v�lasztani az akt�v adatb�zis amithaszn�lni fogok*/

-- Tabla letrehozasa: (rel�ci� =egyedhalmaz=t�bla && az adatmodellben az egyes egyedek tulajdons�gait a t�bla t�rolja, a fel�p�tett rel�ci� alapj�n)
CREATE TABLE `Ember`(
  /* NEV(oszlop) (oszlop)TIPUS EGYEBEK,(Attrib�tom=oszlop=tulajdons�g && az adatmodellben az egyes attrib�tumokat, az oszlopok testes�ti meg, 
  mely a rel�ci� felhaszn�lt tulajdons�ghalmaz elemeit veheti fel.)*/
  `SZIG` CHAR(8) PRIMARY KEY, -- egyszer� els�dkeleges kulcs
  `Vnev` VARCHAR(100) NOT NULL, /*NOT NULL- k�zelez�en kit�ltend�*/
  `Knev` VARCHAR(100) NOT NULL,
  `Unev` VARCHAR(200) DEFAULT 'N.A.', /*DEFAULT �rt�k- alap�rtelmezett �rt�k - el�re meghat�rozott �rt�k 'sz�vegesen'*/
  `SzulDatum` DATE NOT NULL,
  `GyerekDb` TINYINT DEFAULT 0 /*TINYIT - Byte*/
  -- az utols� oszlop felsorol�s ut�n sehol nem szabad vessz�t tenni
);

/* az ember t�bl�t nem fogja hagyni t�r�lni, mert �ssze vannak k�tve az idegen kulccsal. Ez�rt el�bb a J�rm� t�bl�t t�rl�m, majd az Ember t�bl�t.*/

CREATE TABLE Jarmu(
  -- ID INT PRIMARY KEY AUTO_INCREMENT: amikor besz�rom az ID azonos�t�t, aut�matikusan hozz� rendel egy egyedi azonos�t�t. aut�mata �rt�k n�vel�s
  Felsegjelzes VARCHAR(3),
  Rendszam VARCHAR(20),
  Gyarto VARCHAR(50) NOT NULL,
  Tipus VARCHAR(50),
  Hengerurtartalom FLOAT DEFAULT 50.0,
  GyartasiIdo DATE DEFAULT '1900-01-01',
  Alvazszam CHAR(12) /*UNIQUE*/ NOT NULL, /*UNIQUE - egyedi kulcs - hi�ba nem az els�dleges kulcs, akkor sem lehet egyforma m�s tulajdons�ggal*/
  TulajSZIG CHAR(8),/*IDEGENKULCS - MEG KELL EGYEZNI A T�PUSNAK! R�MUTAT� IDEGENKULCS T�PUS�NAK IS CHAR (8)*/  

  /*CONSTRAINT PK_Jarmu_FelsegjelzesRendszam (elnevezes)*/ PRIMARY KEY (Felsegjelzes, Rendszam), /* �sszetett els�dleges kulcs*/
  CONSTRAINT FK_JarmuTulajSZIG_EmberSZIG FOREIGN KEY (TulajSZIG) REFERENCES Ember(SZIG), 
  /*FOREIGN KEY=idegen kulcs: k�t t�bla k�z�tti kapcsolatot fogja megteremteni. CSAK AZ OSZLOPOK UT�NA BE�LL�T�S!(indexek mapp�ba tal�ljuk<--))*/
  CONSTRAINT UQ_Jarmu_Alvazszam UNIQUE (Alvazszam)/*CONSTRAINT elnevez�s- megk�t�s - valamir�l megakarod sz�ntetni, az idegen kulcsot, 
  akkor a megk�t�seket kell t�r�lni.||parancsb�l t�r�lj�k.*/
);

-- Nezettabla
/*
CREATE VIEW Nezettabla AS <lek�rdez�s>;
*/

-- Esemenyindito
/*
CREATE TRIGGER <n�v> {AFTER | BEFORE} {INSERT | UPDATE | DELETE}
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
ADD COLUMN TAJ CHAR(9); -- �j oszlopot veszek fel

ALTER TABLE Ember
ADD CONSTRAINT UQ_Ember_TAJ UNIQUE (TAJ); -- egyedi kulcs lesz a taj. ut�lagos megk�t�s

ALTER TABLE Ember
MODIFY TAJ CHAR(8); -- az oszlopon t�pus m�dos�t�s 

ALTER TABLE Ember
CHANGE TAJ TAJSZAM CHAR(9); -- �tnevez�s, csere, m�dos�t�s

ALTER TABLE Ember
DROP CONSTRAINT UQ_Ember_TAJ; -- nem akarom, hogy egyedi kulcs legyen, ez�rt t�rl�m

ALTER TABLE Ember
DROP COLUMN TAJSZAM; -- oszlop t�rl�s

-- Nezettabla modositas
/*
ALTER VIEW Nezettabla AS <lek�rdez�s>;
*/

-- Esemenyindito modositas
/*
Regi torlese, uj felvetele
*/

-- Torlesek
DROP DATABASE 20251009kcs; -- adatb�zis t�rl�s
DROP TABLE jarmu; -- t�bla t�rl�s
-- DROP VIEW Nezettabla; -- n�zett�bla t�rl�s
-- DROP TRIGGER Esemenyindito; -- trigger t�rl�s

-- Alaphelyezetbe allitas - csak a t�bl�kn�l m�k�dik
TRUNCATE TABLE ember; -- alaphelyzetben a t�bla �res/ �r�t. 


/*
Oszlop be�ll�t�si lehet�s�gek:
hivatalosan egyetlen t�bla sem l�tezhet els�dleges kulcs n�lk�l. 
PRIMARY KEY : els�dleges kulcs: olyan egyszer� vagy �szetett kulcs, mely pontosan tudja azonos�tani az adott sort. 
*/