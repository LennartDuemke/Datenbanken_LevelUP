
/* Anlegen der ER-entitys */
CREATE TABLE DBO.FITNESSGERAET
	( id numeric(5) NOT NULL
	, typ varchar(300) NOT NULL
	, firma varchar(100) NOT NULL
	, name varchar(100) NULL
	, quadratmeter numeric(3,1) NULL
	, kaufdatum date NULL
	, wartung date NULL
	, ausgemustert char(1) NULL
	, notiz varchar(1000) NULL
	, CONSTRAINT PK_FITNESSGERAET PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.UEBUNG
	( id numeric(5) NOT NULL
	, datum date NOT NULL
	, beschreibung varchar(1000) NULL
	, gewicht numeric(4,1) NULL
	, anzahl numeric(3) NULL
	, wiederholung numeric(3) NULL
	, fitnessgeraet_id numeric(5) NULL
	, basistraining_id numeric(5) NOT NULL
	, CONSTRAINT PK_UEBUNG PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.BASISTRAINING
	( id numeric(5) NOT NULL
	, beginn date NOT NULL
	, mindestlaufzeit numeric(2) NOT NULL
	  CONSTRAINT CKC_MINDESTLAUFZEIT_BASISTRAINING CHECK (mindestlaufzeit IN (6,12,24))
	, kuendigungsfrist numeric(2) NOT NULL
	  CONSTRAINT CKC_KUENDIGUNGSFRIST_BASISTRAINING CHECK (kuendigungsfrist IN (1,2,3))
	, kuendigung date NULL
	, getraenk char(1) NULL
	, notiz varchar(1000) NULL
	, angestellter_id numeric(5) NULL
	, CONSTRAINT PK_BASISTRAINING PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.FUNKTION
	( id numeric(5) NOT NULL
	, funktion varchar(50) NOT NULL
	  CONSTRAINT CKC_FUNKTION_FUNKTION CHECK (funktion IN (	'Sekretär',
															'Fitness-Trainer',
															'Diätassistent',
															'Physiotherapeut',
															'Masseur',
															'Herzsport Übungsleiter',
															'Studentische Hilfskraft',
															'FSJler',
															'Reinigungskraft',
															'Hausmeister',
															'Chef'))
	, notiz varchar(1000) NULL
	, CONSTRAINT PK_FUNKTION PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.ADRESSE
	( id numeric(5) NOT NULL
	, straße varchar(50) NOT NULL
	, haus_nr varchar(10) NOT NULL
	, plz numeric(5) NOT NULL
	, ort varchar(50) NULL
	, CONSTRAINT PK_ADRESSE PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.ANGESTELLTER
	( id numeric(5) NOT NULL
	, anrede varchar(20) NULL
	  CONSTRAINT CKC_ANREDE_ANGESTELLTER CHECK (anrede IN (	'Herr',
															'Frau'))
	, name varchar(100) NOT NULL
	, vorname varchar(100) NOT NULL
	, geburtsdatum date NOT NULL
	, email varchar(50) NULL
	, telefon varchar(50) NULL
	, stundenlohn numeric(4,2) NULL
	, wochenarbeitszeit numeric(2) NULL
	, einstellungsdatum date NULL
	, notiz varchar(1000) NULL
	, CONSTRAINT PK_ANGESTELLTER PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.KURS
	( id numeric(5) NOT NULL
	, typ varchar(50) NOT NULL
	  CONSTRAINT CKC_TYP_KURS CHECK (typ IN (	'Gewichtsreduktion',
												'Yoga',
												'Zumba',
												'Pilates',
												'Step',
												'Indoor-Cycling',
												'Herz-Kreislauf',
												'Circel Training',
												'Koronarsport',
												'Rückengymnastik',
												'Beckenbodengymnastik'))
	, beginn date NOT NULL
	, ende date NOT NULL
	, raum varchar(50) NULL
	, terminanzahl numeric(2) NULL
	, CONSTRAINT PK_KURS PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.REHA_INFO
	( id numeric(5) NOT NULL
	, zahlung varchar(200) NOT NULL
	, krankenkasse varchar(100) NULL
	, belastbarkeit varchar(1000) NULL
	, notiz varchar(1000) NULL
	, kurs_id numeric(5) NOT NULL
	, mitgliedschaft_id numeric(5) NOT NULL
	, CONSTRAINT PK_REHA_INFO PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.EINFUEHRUNG
	( id numeric(5) NOT NULL
	, datum date NOT NULL
	, preis numeric(4,2) NULL
	, gewicht numeric(4,1) NULL
	, bmi numeric(2) NULL
	, koerperfett numeric(2) NULL
	, mitgliedschaft_id numeric(5) NOT NULL
	, angestellter_id numeric(5) NOT NULL
	, CONSTRAINT PK_EINFUEHRUNG PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.MASSAGE
	( id numeric(5) NOT NULL
	, datum date NOT NULL
	, preis numeric(4,2) NOT NULL
	, typ varchar(500) NULL
	, angestellter_id numeric(5) NOT NULL
	, mitgliedschaft_id numeric(5) NOT NULL
	, CONSTRAINT PK_MASSAGE PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.VERTRAG
	( id numeric(5) NOT NULL
	, preis numeric(5,2) NOT NULL
	, rabatt numeric(2) NULL
	, notiz varchar(1000) NULL
	, mitgliedschaft_id numeric(5) NOT NULL
	, sauna_id numeric(5) NULL
	, basistraining_id numeric(5) NULL
	, kurs_id numeric(5) NULL
	, CONSTRAINT PK_VERTRAG PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.MITGLIEDSCHAFT
	( id numeric(5) NOT NULL
	, beitritt date NOT NULL
	, austritt date NULL 
	, zahlungsart varchar(50) NULL
	  CONSTRAINT CKC_ZAHLUNGSART_MITGLIEDSCHAFT CHECK (zahlungsart IS NULL OR zahlungsart IN (	'Lastschrift',
																								'Rechnung',
																								'PayPal'))
	, kunde_id numeric(5) NOT NULL
	, CONSTRAINT PK_MITGLIEDSCHAFT PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.KUNDE
	( id numeric(5) NOT NULL
	, anrede varchar(100)
	  CONSTRAINT CKC_ANREDE_KUNDE CHECK (anrede IN (	'Herr',
														'Frau' ))
	, name varchar(100) NOT NULL
	, vorname varchar(100) NOT NULL
	, geburtsdatum date NOT NULL
	, email varchar(50) NULL
	, telefon varchar(50) NULL
	, notiz varchar(1000) NULL
	, CONSTRAINT PK_KUNDE PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.SAUNA
	( id numeric(5) NOT NULL
	, beginn date NOT NULL
	, laufzeit numeric(2) NOT NULL
	  CONSTRAINT CKC_LAUFZEIT_SAUNA CHECK (laufzeit IN (6,12,24))
	, CONSTRAINT PK_SAUNA PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.GETRAENK
	( id numeric(5) NOT NULL
	, typ varchar(50) NOT NULL
	, preis numeric(4,2) NOT NULL
	, CONSTRAINT PK_GETRAENK PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.SPORTLER_NAHRUNG
	( id numeric(5) NOT NULL
	, typ varchar(50) NOT NULL
	, preis numeric(4,2) NOT NULL
	, CONSTRAINT PK_SPORTLER_NAHRUNG PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.KAUF
	( id numeric(5) NOT NULL
	, kauf date NOT NULL
	, mitgliedschaft_id numeric(5) NOT NULL
	, getraenk_id numeric(5) NULL
	, sportler_nahrung_id numeric(5) NULL
	, CONSTRAINT PK_KAUF PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.AKTION
	( id numeric(5) NOT NULL
	, beschreibung varchar(1000) NOT NULL
	, CONSTRAINT PK_AKTION PRIMARY KEY nonclustered (id)
)GO

CREATE TABLE DBO.ANGESTELLTER_FUNKTION
	( angestellter_id numeric(5) NOT NULL
	, funktion_id numeric(5) NOT NULL 
	, CONSTRAINT PK_ANGESTELLTER_FUNKTION PRIMARY KEY nonclustered (angestellter_id, funktion_id)
)GO

CREATE TABLE DBO.ANGESTELLTER_KURS
	( angestellter_id numeric(5) NOT NULL
	, kurs_id numeric(5) NOT NULL
	, CONSTRAINT PK_ANGESTELLTER_KURS PRIMARY KEY nonclustered (angestellter_id, kurs_id)
)GO
	
CREATE TABLE DBO.MITGLIEDSCHAFT_AKTION
	( mitgliedschaft_id numeric(5) NOT NULL
	, aktion_id numeric(5) NOT NULL
	, CONSTRAINT PK_MITGLIEDSCHAFT_AKTION PRIMARY KEY nonclustered (mitgliedschaft_id, aktion_id)
)GO
	
CREATE TABLE DBO.ANGESTELLTER_ADRESSE
	( angestellter_id numeric(5) NOT NULL
	, adresse_id numeric(5) NOT NULL
	, CONSTRAINT PK_ANGESTELLTER_ADRESSE PRIMARY KEY nonclustered (angestellter_id, adresse_id)
)GO

CREATE TABLE DBO.KUNDE_ADRESSE
	( kunde_id numeric(5) NOT NULL
	, adresse_id numeric(5) NOT NULL
	, CONSTRAINT PK_KUNDE_ADRESSE PRIMARY KEY nonclustered (kunde_id, adresse_id)
)GO

/* CONSTRAINTS anlegen */

ALTER TABLE UEBUNG
	ADD CONSTRAINT uebung_fitnessgeraet_fk FOREIGN KEY
	( fitnessgeraet_id )
	REFERENCES DBO.FITNESSGERAET
	( id )GO
	
ALTER TABLE UEBUNG
	ADD CONSTRAINT uebung_basistraining_fk FOREIGN KEY
	( basistraining_id )
	REFERENCES DBO.BASISTRAINING
	( id )GO 
	
ALTER TABLE BASISTRAINING
	ADD CONSTRAINT basistraining_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES DBO.ANGESTELLTER
	( id )GO

ALTER TABLE REHA_INFO
	ADD CONSTRAINT reha_info_kurs_fk FOREIGN KEY
	( kurs_id )
	REFERENCES DBO.KURS
	( id )GO

ALTER TABLE REHA_INFO
	ADD CONSTRAINT reha_info_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES DBO.MITGLIEDSCHAFT
	( id )GO

ALTER TABLE EINFUEHRUNG
	ADD CONSTRAINT einfuehrung_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES DBO.MITGLIEDSCHAFT
	( id )GO
	
ALTER TABLE EINFUEHRUNG
	ADD CONSTRAINT einfuehrung_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES DBO.ANGESTELLTER
	( id )GO
	
ALTER TABLE MASSAGE
	ADD CONSTRAINT massage_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES DBO.ANGESTELLTER
	( id )GO
	
ALTER TABLE MASSAGE
	ADD CONSTRAINT massage_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES DBO.MITGLIEDSCHAFT
	( id )GO

ALTER TABLE MITGLIEDSCHAFT
	ADD CONSTRAINT mitgliedschaft_kunde_fk FOREIGN KEY
	( kunde_id )
	REFERENCES DBO.KUNDE
	( id )GO

ALTER TABLE KAUF
	ADD CONSTRAINT kauf_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES DBO.MITGLIEDSCHAFT
	( id )GO
	
ALTER TABLE KAUF
	ADD CONSTRAINT kauf_getraenk_fk FOREIGN KEY
	( getraenk_id )
	REFERENCES DBO.GETRAENK
	( id )GO
	
ALTER TABLE KAUF
	ADD CONSTRAINT kauf_sportler_nahrung_fk FOREIGN KEY
	( sportler_nahrung_id )
	REFERENCES DBO.SPORTLER_NAHRUNG
	( id )GO
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES DBO.MITGLIEDSCHAFT
	( id )GO
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_sauna_fk FOREIGN KEY
	( sauna_id )
	REFERENCES DBO.SAUNA
	( id )GO
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_basistraining_fk FOREIGN KEY
	( basistraining_id )
	REFERENCES DBO.BASISTRAINING
	( id )GO
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_kurs_fk FOREIGN KEY
	( kurs_id )
	REFERENCES DBO.KURS
	( id )GO
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT angestellter_funktion_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES DBO.ANGESTELLTER
	( id )GO
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT angestellter_funktion_funktion_fk FOREIGN KEY
	( funktion_id )
	REFERENCES DBO.FUNKTION
	( id )GO
	
ALTER TABLE ANGESTELLTER_KURS
	ADD CONSTRAINT angestellter_kurs_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES DBO.ANGESTELLTER
	( id )GO
	
ALTER TABLE ANGESTELLTER_KURS
	ADD CONSTRAINT angestellter_kurs_kurs_fk FOREIGN KEY
	( kurs_id )
	REFERENCES DBO.KURS
	( id )GO
	
ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT mitgliedschaft_aktion_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES DBO.MITGLIEDSCHAFT
	( id )GO
	
ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT mitgliedschaft_aktion_aktion_fk FOREIGN KEY
	( aktion_id )
	REFERENCES DBO.AKTION
	( id )GO
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES DBO.ANGESTELLTER
	( id )GO
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_adresse_fk FOREIGN KEY
	( adresse_id )
	REFERENCES DBO.ADRESSE
	( id )GO
	
ALTER TABLE KUNDE_ADRESSE
	ADD CONSTRAINT kunde_adresse_kunde_fk FOREIGN KEY
	( kunde_id )
	REFERENCES DBO.KUNDE
	( id )GO
	
ALTER TABLE KUNDE_ADRESSE
	ADD CONSTRAINT kunde_adresse_adresse_fk FOREIGN KEY
	( adresse_id )
	REFERENCES DBO.ADRESSE
	( id )GO
	
	
/* Daten einfuegen: INSERT-Statements */

/* 1. KUNDE */

INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(1, 'Herr', 'Holstein', 'Peter', '1950-07-23', 'p.holstein@gmail.com', '015752356673', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(2, 'Herr', 'Meyer zu Wickern', 'Timo', '1948-06-10', null, '0571563118', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(3, 'Frau', 'Tischbein', 'Ulla', '1960-12-03', 'ullatisch@aol.com', '0571900174', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(4, 'Frau', 'Aslan', 'Aischa', '1996-05-20', 'Aaslan96@gmail.com', '01642789540', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(5, 'Herr', 'Aslan', 'Mehmet', '1995-11-08', 'Maslan95@gmail.com', '015754228790', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(6, 'Herr', 'Hildebrandt', 'Ben', '2000-11-19', 'Benjamin20@t-online.de', '0571035523', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(7, 'Herr', 'Petrow', 'Alexander', '1989-01-28', 'AlexPetrow89@t-online.de', '01642654408', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(8, 'Frau', 'Schmidt', 'Hilde', '1947-08-30', null, '0571254545', 'Schwiegermutter vom Chef')GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(9, 'Frau', 'Großer', 'Michelle', '1998-04-17', 'Michi17@gmail.com', '015754429887', null)GO
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(10, 'Frau', 'Großer', 'Miriam', '1999-02-15', 'Miriam999@aol.com', '0164245529', null)GO

/* 2. ANGESTELLTER */

INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(1, 'Herr', 'Rösner', 'Harrald', '1968-01-31', 'Harrald.Roesner@gmail.com', '05713395623', null, null, null, null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(2, 'Herr', 'Morillio Mendoza', 'Viktor', '1984-06-25', 'Morillio@gmail.com', '015756690342', 13.10, 35, '2010-02-01', null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(3, 'Frau', 'Hagen', 'Jasmin', '1987-02-12', 'Jasmin97@aol.com', '05716442990', 13.50, 38, '2010-12-10', null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(4, 'Frau', 'Dudai', 'Birgit', '1975-05-18', 'Duda75@t-online.de', '05719823114', 12.00, 20, '2010-11-15', null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(5, 'Frau', 'Jaschinski', 'Magda', '1963-03-01', null, '015758842092', 9.19, 15, '2011-03-20', null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(6, 'Herr', 'Walter', 'Joshua', '1999-10-25', 'Josh2500@gmail.com', '01648729902', null, 35, null, 'Wohnt unentgeltlich über dem Gym, monatliches Entgelt 320?')GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(7, 'Herr', 'Götz', 'Fred', '2000-09-21', 'Götz2109@t-online.de', '015758200189', 9.19, 10, null, 'Student der Informatik an der FH')GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(8, 'Herr', 'Iwanow', 'Vladimir', '1983-04-03', 'VladTheImpaler@aol.com', '05713378290', 15.00, 10, '2013-07-01', null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(9, 'Herr', 'Brown', 'John', '1989-09-22', 'John.brown@gmail.com', '05715229073', 25.00, 25, '2012-08-01', null)GO
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(10, 'Herr', 'Peters', 'Manfred', '1972-01-30', 'Manfred92@aol.com', '015752039648', 11.00, 12, '2016-01-01', null)GO

/* 3. FUNKTION */

INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(1, 'Masseur', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(2, 'Physiotherapeut', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(3, 'Herzsport Übungsleiter', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(4, 'Diätassistent', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(5, 'Studentische Hilfskraft', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(6, 'FSJler', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(7, 'Fitness-Trainer', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(8, 'Chef', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(9, 'Hausmeister', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(10, 'Reinigungskraft', null)GO
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(11, 'Sekretär', null)GO

/* 4. ANGESTELLTER_FUNKTION */

INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(1, 2)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(1, 8)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(2, 7)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(3, 4)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(3, 2)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(4, 11)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(5, 10)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(6, 6)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(7, 5)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(8, 1)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(9, 3)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(9, 2)GO
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(10, 9)GO

/* 5. ADRESSE */

INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(1, 'Zeugstraße', '11a', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(2, 'Bergweg', '3', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(3, 'Am Denkmal', '20', 32457, 'Porta Westfalica')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(4, 'Melittaweg', '4', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(5, 'Am Museum', '22', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(6, 'Berghof', '8', 32457, 'Porta WestfalicaMinden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(7, 'Rathausstraße', '28', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(8, 'Zwinger', '59', 32602, 'Vlotho')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(9, 'Ratstraße', '32', 32428, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(10, 'Schulstraße', '9', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(12, 'Schnurrviertel', '60', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(13, 'Altstadt', '6', 32429, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(14, 'Domstraße', '1c', 32428, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(15, 'Ahornweg', '11', 32469, 'Petershagen')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(16, 'Oeynhausenerweg', '6', 32545, 'Bad Oeynhausen')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(17, 'An der Schleuse', '34', 32427, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(19, 'Marktstraße', '17', 32429, 'Minden')GO
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(20, 'Bäderstraße', '29', 32545, 'Bad Oeynhausen')GO

/* 6. ANGESTELLTER_ADRESSE */

INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(1, 3)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(2, 6)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(3, 15)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(4, 16)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(5, 20)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(6, 9)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(7, 4)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(8, 5)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(9, 8)GO
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(10, 13)GO

/* 7. KUNDE_ADRESSE */

INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(1, 12)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(3, 17)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(9, 7)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(10, 7)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(4, 19)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(5, 19)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(8, 14)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(2, 10)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(6, 2)GO
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(7, 1)GO

/* 8. MITGLIEDSCHAFT */

INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(1, '2010-02-01', '2016-05-01', 'Lastschrift', 1)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(2, '2010-02-01', '2012-02-01', 'Rechnung', 2)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(3, '2010-02-01', null, 'Lastschrift', 3)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(4, '2013-10-01', '2015-10-01', 'Rechnung', 2)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(5, '2015-02-01', null, 'Lastschrift', 4)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(6, '2015-02-01', null, 'Lastschrift', 5)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(7, '2016-09-01', null, 'Rechnung', 8)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(8, '2015-02-01', null, 'PayPal', 7)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(9, '2017-03-01', null, 'Lastschrift', 9)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(10, '2018-01-01', null, 'Rechnung', 2)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(11, '2018-03-01', null, 'Lastschrift', 10)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(12, '2018-03-01', null, 'Lastschrift', 6)GO
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(13, '2017-12-01', null, 'Lastschrift', 1)GO

/* 9. AKTION */

INSERT INTO AKTION (id, beschreibung)
VALUES(1, 'Kundenwerbung: Getränk umsonst')GO
INSERT INTO AKTION (id, beschreibung)
VALUES(2, 'Rabattwoche : Basistraining 95%')GO
INSERT INTO AKTION (id, beschreibung)
VALUES(3, 'Einführung umsonst')GO
INSERT INTO AKTION (id, beschreibung)
VALUES(4, 'Circel Training für Kunden mit Basistraining 75% Nachlass')GO
INSERT INTO AKTION (id, beschreibung)
VALUES(5, 'Zumba für Kunden mit Basistraining 75% Nachlass')GO

/* 10. MITGLIEDSCHAFT_AKTION */

INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(9, 1)GO
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(8, 2)GO
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(12, 3)GO
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(6, 4)GO
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(9, 5)GO
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(11, 5)GO

/* 11. MASSAGE */

INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(1, '2015-03-12', 20.00, 'Ganzkörper', 8, 4)GO
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(2, '2018-01-30', 25.00, 'Ganzkörper', 8, 7)GO
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(3, '2018-04-02', 15.00, 'Schultergürtel', 1, 10)GO
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(4, '2018-05-23', 15.00, 'Untere Extremität', 1, 1)GO
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(5, '2018-07-29', 20.00, 'Rücken', 8, 8)GO

/* 12. EINFUEHRUNG */

INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(1, '2010-02-01', 15.00, 76.0, null, null, 1, 1)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(2, '2010-02-01', 15.00, 82.0, null, null, 2, 1)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(3, '2010-02-01', 15.00, 56.0, null, null, 3, 1)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(4, '2013-10-15', 30.00, 91.0, 26, 21, 4, 2)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(5, '2015-02-15', 30.00, 52.0, 21, 16, 5, 1)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(6, '2015-02-15', 30.00, 78.0, 26, 22, 6, 2)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(7, '2018-03-02', 0.00, 120.0, 38, 41, 12, 2)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(8, '2017-12-12', 30.00, 97.0, null, 23, 8, 1)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(9, '2017-03-15', 30.00, 85.0, null, null, 9, 9)GO
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(10, '2018-03-14', 30.00, null, null, null, 11, 9)GO


/* 13. GETRAENK */

INSERT INTO GETRAENK (id, typ, preis)
VALUES(1, 'Mineralwasser', 0.80)GO
INSERT INTO GETRAENK (id, typ, preis)
VALUES(2, 'Iso-Drink', 1.20)GO
INSERT INTO GETRAENK (id, typ, preis)
VALUES(3, 'Cola Light', 1.20)GO
INSERT INTO GETRAENK (id, typ, preis)
VALUES(4, 'Kaffee', 2.00)GO
INSERT INTO GETRAENK (id, typ, preis)
VALUES(5, 'Tee', 1.50)GO
INSERT INTO GETRAENK (id, typ, preis)
VALUES(6, 'Milchshake', 2.50)GO


/* 14. SPORTLER_NAHRUNG */

INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(1, 'Protein Riegel Schoko', 1.80)GO
INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(2, 'Power Protein Bar Erdbeer', 1.20)GO
INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(3, 'Müslimischung proteinreich', 5.50)GO
INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(4, 'Proteinpulver Muskelaufbau', 39.50)GO

/* 15. KAUF */

INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(1, '2015-02-10', 5, 1, null)GO
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(2, '2015-04-12', 4, 4, null)GO
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(3, '2018-05-30', 12, null, 2)GO
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(4, '2015-02-23', 5, 6, null)GO
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(5, '2018-01-20', 8, null, 4)GO
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(6, '2015-02-13', 5, 2, null)GO


/* 16. SAUNA */

INSERT INTO SAUNA (id, beginn, laufzeit)
VALUES(1, '2011-02-01', 6)GO
INSERT INTO SAUNA (id, beginn, laufzeit)
VALUES(2, '2017-12-01', 24)GO

/* 17. KURS */

INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(1, 'Gewichtsreduktion', '2018-04-02', '2018-06-18', 'Raum F', 12)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(2, 'Yoga', '2012-05-23', '2012-07-24', null, 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(3, 'Zumba', '2018-04-04', '2018-06-20', 'Halle', 12)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(4, 'Pilates', '2012-05-23', '2012-07-24', null, 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(5, 'Step', '2012-05-23', '2012-07-24', null, 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(6, 'Indoor-Cycling', '2012-05-23', '2012-07-24', null, 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(7, 'Herz-Kreislauf', '2012-05-23', '2012-07-24', null, 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(8, 'Circel Training', '2018-01-01', '2018-04-01', 'Vorhalle', 12)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(9, 'Koronarsport', '2018-01-04', '2018-02-22', 'Halle', 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(10, 'Rückengymnastik', '2018-04-03', '2018-05-23', 'Halle', 8)GO
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(11, 'Beckenbodengymnastik', '2018-04-05', '2018-06-21', 'Spiegelsaal', 12)GO

/* 18. ANGESTELLTER_KURS */

INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 1)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(2, 2)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 3)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 4)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(6, 5)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(7, 6)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(9, 7)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(6, 8)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(9, 9)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(1, 10)GO
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 11)GO

/* 19. REHA_INFO */

INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(1, 'Krankenkasse', 'Techniker', '75 Watt', 'Hausarzt Dr. Rüdiger, Herzinfarkt 06-06-2016', 9, 13)GO
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(2, 'Krankenkasse', 'Barmer', null, 'Hausarzt Dr. Hill', 1, 12)GO
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(3, 'Selbstzahler', null, null, 'Hausarzt Dr. Rüdiger', 1, 9)GO
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(4, 'Selbstzahler', null, null, 'Hausarzt Dr. Rüdiger', 10, 3)GO
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(5, 'Krankenkasse', 'AOK', null, 'Hausarzt Dr. Hill', 11, 7)GO


/* 20. BASISTRAINING */

INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(1, '2010-02-01', 6, 1, '2015-12-15', null, null, 1)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(2, '2010-02-01', 12, 2, '2011-12-15', null, null, 1)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(3, '2010-02-01', 24, 3, null, null, null, 1)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(4, '2013-10-01', 24, 3, '2015-06-15', null, null, 3)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(5, '2015-02-01', 12, 2, null, 'j', null, 3)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(6, '2015-02-01', 12, 2, null, null, null, 2)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(7, '2018-02-01', 12, 2, null, 'j', null, 1)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(8, '2017-12-01', 24, 3, null, null, null, 2)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(9, '2017-03-01', 12, 2, null, 'j', null, 9)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(10, '2018-03-01', 12, 2, null, null, null, 3)GO
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(11, '2018-03-01', 12, 2, null, null, null, 9)GO


/* 21. FITNESSGERAET */

INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(1, 'Laufband', 'emotion fitness GmbH & Co. KG', 'Motion Sprint 300', 3.0, '2010-03-20', '2012-04-23', 'j', 'reparaturanfällig')GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(2, 'Laufband', 'Intenza Fitness GmbH', 'Laufband 550 Ti', 3.0, '2014-12-01', '2017-05-03', null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(3, 'Ergometer', 'Intenza Fitness GmbH', 'Intenza Ergometer UBi', 2.5, '2014-05-20', '2017-05-03', null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(4, 'Überzug', 'gym80 International GmbH', 'pullover', 2.5, '2017-04-30', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(5, 'Beinpresse', 'gym80 International GmbH', 'Leg Press', 3.0, '2017-08-09', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(6, 'Abduktion', 'gym80 International GmbH', 'Abduction machine', 2.5, '2016-11-09', '2018-03-01', null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(7, 'Adduktion', 'gym80 International GmbH', 'Adduction machine', 2.5, '2016-03-11', '2018-03-01', null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(8, 'Rückenübung', 'gym80 International GmbH', 'Lat Pulley', 3.0, '2017-05-30', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(9, 'Rumpfstemme', 'gym80 International GmbH', 'Chest Press, Sygnum', 2.2, '2017-02-10', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(10, 'Glutaeus-Maschine', 'gym80 International GmbH', 'Glutaeus machine', 2.0, '2017-02-14', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(11, 'Beine strecken', 'gym80 International GmbH', 'Leg Extension', 2.0, '2017-05-04', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(12, 'Beine beugen', 'gym80 International GmbH', 'Leg Curl', 2.0, '2016-06-06', '2018-03-01', null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(13, 'Seilzugapparat', 'Lojer', 'Tree Pulley ', 2.0, '2016-04-01', '2018-03-01', null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(14, 'Bauchmuskulatur', 'gym80 International GmbH', 'Twister Basic', 3.5, '2017-03-24', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(15, 'Bruststabilisator', 'gym80 International GmbH', 'Chest Fixator',2.0, '2018-04-05', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(16, 'Bizepsgerät', 'gym80 International GmbH', 'Pure Kraft Bizepsgerät', 3.0, '2018-04-05', null, null, null)GO
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(17, 'Crosstrainer', 'Intenza Fitness GmbH', 'Crosstrainer 550ETi', 3.5, '2018-04-08', null, null, null)GO

/* 22. UEBUNG */

INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(1, '2018-09-04', '10 Minuten 80 Watt', null, null, null, 3, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(2, '2018-09-04', null, 20.0, 15, 3, 4, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(3, '2018-09-04', null, 35.0, 15, 3, 6, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(4, '2018-09-04', null, 35.0, 15, 3, 7, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(5, '2018-09-04', null, 15.0, 10, 3, 13, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(6, '2018-09-04', null, 20.0, 10, 3, 14, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(7, '2018-09-04', '10 Minuten 100 Watt', null, null, null, 17, 3)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(8, '2018-03-01', '15 Minuten 75 Watt', null, null, null, 2, 7)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(9, '2018-03-01', null, 105.0, 15, 3, 5, 7)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(10, '2018-03-01', null, 45.0, 15, 3, 8, 7)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(11, '2018-03-01', null, 25.0, 15, 3, 9, 7)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(12, '2018-03-01', null, 35.0, 15, 3, 14, 7)GO
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(13, '2018-03-01', null, 10.0, 10, 3, 16, 7)GO


/* 23. VERTRAG */

INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(1, 38.00, null, null, 1, null, 1, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(2, 36.00, null, null, 2, null, 2, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(3, 32.00, null, null, 3, null, 3, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(4, 32.00, null, null, 4, null, 4, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(5, 35.00, null, null, 5, null, 5, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(6, 34.00, null, null, 6, null, 6, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(7, 35.00, null, null, 12, null, 7, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(8, 32.00, 5, null, 8, null, 8, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(9, 31.00, null, null, 9, null, 9, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(10, 34.00, null, null, 10, null, 10, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(11, 100.00, null, null, 13, null, null, 9)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(12, 120.00, null, null, 12, null, null, 1)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(13, 120.00, null, null, 9, null, null, 1)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(14, 80.00, null, null, 3, null, null, 10)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(15, 60.00, null, null, 7, null, null, 11)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(16, 40.00, 75, null, 6, null, null, 8)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(17, 40.00, 75, null, 9, null, null, 3)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(18, 40.00, 75, null, 11, null, null, 3)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(19, 33.00, null, null, 11, null, 11, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(20, 4.00, null, null, 8, 1, null, null)GO
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(21, 3.00, null, null, 3, 2, null, null)GO