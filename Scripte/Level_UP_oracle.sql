/* Encoding auf UTF-8 setzen */
ALTER SESSION SET NLS_LANGUAGE='UTF8';

/* Anlegen der ER-entitys */
CREATE TABLE FITNESSGERAET
	( id number(5) NOT NULL
	, typ varchar2(300) NOT NULL
	, firma varchar2(100) NOT NULL
	, name varchar2(100)
	, quadratmeter number(3,1)
	, kaufdatum date
	, wartung date
	, ausgemustert char(1)
	, notiz varchar2(1000)
);

CREATE TABLE UEBUNG
	( id number(5) NOT NULL
	, datum date NOT NULL
	, beschreibung varchar2(1000) NULL
	, gewicht number(4,1) 
	, anzahl number(3)
	, wiederholung number(3)
	, fitnessgeraet_id number(5)
	, basistraining_id number(5) NOT NULL
);

CREATE TABLE BASISTRAINING
	( id number(5) NOT NULL
	, beginn date NOT NULL
	, mindestlaufzeit number(2) NOT NULL
	, CONSTRAINT CKC_MINDESTL_BASISTRAINING CHECK (mindestlaufzeit IN (6,12,24))
	, kuendigungsfrist number(2) NOT NULL
	, CONSTRAINT CKC_KUENDIGUNGSF_BASISTRAINING CHECK (kuendigungsfrist IN (1,2,3))
	, kuendigung date
	, getraenk char(1)
	, notiz varchar2(1000)
	, angestellter_id number(5)
);

CREATE TABLE FUNKTION
	( id number(5) NOT NULL
	, funktion varchar2(50) NOT NULL
	, CONSTRAINT CKC_FUNKTION_FUNKTION CHECK (funktion IN (	'Sekretär',
															'Fitness-Trainer',
															'Diätassistent',
															'Physiotherapeut',
															'Masseur',
															'Herzsport Übungsleiter',
															'SHK',
															'FSJler',
															'Reinigungskraft',
															'Hausmeister',
															'Chef'))
	, notiz varchar2(1000)
);

CREATE TABLE ADRESSE
	( id number(5) NOT NULL
	, straße varchar2(50) NOT NULL
	, haus_nr varchar2(10) NOT NULL
	, plz number(5) NOT NULL
	, ort varchar2(50)
);

CREATE TABLE ANGESTELLTER
	( id number(5) NOT NULL
	, anrede varchar2(20)
	, CONSTRAINT CKC_ANREDE_ANGESTELLTER CHECK (anrede IN (	'Herr',
															'Frau' ))
	, name varchar2(100) NOT NULL
	, vorname varchar2(100) NOT NULL
	, geburtsdatum date NOT NULL
	, email varchar2(50)
	, telefon varchar2(50)
	, stundenlohn number(4,2)
	, wochenarbeitszeit number(2)
	, einstellungsdatum date
	, notiz varchar2(1000)
);

CREATE TABLE KURS
	( id number(5) NOT NULL
	, typ varchar2(50) NOT NULL
	, CONSTRAINT CKC_TYP_KURS CHECK (typ IN (	'Gewichtsreduktion',
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
	, raum varchar2(50)
	, terminanzahl number(2)
);

CREATE TABLE REHA_INFO
	( id number(5) NOT NULL
	, zahlung varchar2(200) NOT NULL
	, krankenkasse varchar2(100)
	, belastbarkeit varchar2(1000)
	, notiz varchar2(1000)
	, kurs_id number(5) NOT NULL
	, mitgliedschaft_id number(5) NOT NULL
);

CREATE TABLE EINFUEHRUNG
	( id number(5) NOT NULL
	, datum date NOT NULL
	, preis number(4,2)
	, gewicht number(4,1)
	, bmi number(2)
	, koerperfett number(2)
	, mitgliedschaft_id number(5) NOT NULL
	, angestellter_id number(5) NOT NULL
);

CREATE TABLE MASSAGE
	( id number(5) NOT NULL
	, datum date NOT NULL
	, preis number(4,2) NOT NULL
	, typ varchar2(500)
	, angestellter_id number(5) NOT NULL
	, mitgliedschaft_id number(5) NOT NULL
);

CREATE TABLE VERTRAG
	( id number(5) NOT NULL
	, preis number(5,2) NOT NULL
	, rabatt number(2)
	, notiz varchar2(1000)
	, mitgliedschaft_id number(5) NOT NULL
	, sauna_id number(5)
	, basistraining_id number(5)
	, kurs_id number(5)
);

CREATE TABLE MITGLIEDSCHAFT
	( id number(5) NOT NULL
	, beitritt date NOT NULL
	, austritt date 
	, zahlungsart varchar2(50)
	, CONSTRAINT CKC_ZAHLUNGSART_MITGLIEDSCHAFT CHECK (zahlungsart IS NULL OR zahlungsart IN (	'Lastschrift',
																								'Rechnung',
																								'PayPal'))
	, kunde_id number(5) NOT NULL
);

CREATE TABLE KUNDE
	( id number(5) NOT NULL
	, anrede varchar2(100)
	, CONSTRAINT CKC_ANREDE_KUNDE CHECK (anrede IN (	'Herr',
														'Frau' ))
	, name varchar2(100) NOT NULL
	, vorname varchar2(100) NOT NULL
	, geburtsdatum date NOT NULL
	, email varchar2(50)
	, telefon varchar2(50)
	, notiz varchar2(1000)
);

CREATE TABLE SAUNA
	( id number(5) NOT NULL
	, beginn date NOT NULL
	, laufzeit number(2) NOT NULL
	, CONSTRAINT CKC_LAUFZEIT_SAUNA CHECK (laufzeit IN (6,12,24))
);

CREATE TABLE GETRAENK
	( id number(5) NOT NULL
	, typ varchar2(50) NOT NULL
	, preis number(4,2) NOT NULL
);

CREATE TABLE SPORTLER_NAHRUNG
	( id number(5) NOT NULL
	, typ varchar2(50) NOT NULL
	, preis number(4,2) NOT NULL
);

CREATE TABLE KAUF
	( id number(5) NOT NULL
	, kauf date NOT NULL
	, mitgliedschaft_id number(5) NOT NULL
	, getraenk_id number(5)
	, sportler_nahrung_id number(5)
);

CREATE TABLE AKTION
	( id number(5) NOT NULL
	, beschreibung varchar2(1000) NOT NULL
);

CREATE TABLE ANGESTELLTER_FUNKTION
	( angestellter_id number(5) NOT NULL
	, funktion_id number(5) NOT NULL 
);

CREATE TABLE ANGESTELLTER_KURS
	( angestellter_id number(5) NOT NULL
	, kurs_id number(5) NOT NULL
);
	
CREATE TABLE MITGLIEDSCHAFT_AKTION
	( mitgliedschaft_id number(5) NOT NULL
	, aktion_id number(5) NOT NULL
);
	
CREATE TABLE ANGESTELLTER_ADRESSE
	( angestellter_id number(5) NOT NULL
	, adresse_id number(5) NOT NULL
);

CREATE TABLE KUNDE_ADRESSE
	( kunde_id number(5) NOT NULL
	, adresse_id number(5) NOT NULL
);

/* CONSTRAINTS anlegen */

ALTER TABLE FITNESSGERAET
	ADD CONSTRAINT PK_FITNESSGERAET PRIMARY KEY 
	( id );

ALTER TABLE UEBUNG
	ADD CONSTRAINT PK_UEBUNG PRIMARY KEY 
	( id );	
	
ALTER TABLE BASISTRAINING
	ADD CONSTRAINT PK_BASISTRAINING PRIMARY KEY 
	( id );

ALTER TABLE FUNKTION
	ADD CONSTRAINT PK_FUNKTION PRIMARY KEY 
	( id );	

ALTER TABLE ADRESSE
	ADD CONSTRAINT PK_ADRESSE PRIMARY KEY 
	( id );

ALTER TABLE ANGESTELLTER
	ADD CONSTRAINT PK_ANGESTELLTER PRIMARY KEY 
	( id );

ALTER TABLE KURS
	ADD CONSTRAINT PK_KURS PRIMARY KEY 
	( id );	

ALTER TABLE REHA_INFO
	ADD CONSTRAINT PK_REHA_INFO PRIMARY KEY 
	( id );

ALTER TABLE EINFUEHRUNG
	ADD CONSTRAINT PK_EINFUEHRUNG PRIMARY KEY 
	( id );
	
ALTER TABLE MASSAGE
	ADD CONSTRAINT PK_MASSAGE PRIMARY KEY 
	( id );
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT PK_VERTRAG PRIMARY KEY 
	( id );	

ALTER TABLE MITGLIEDSCHAFT
	ADD CONSTRAINT PK_MITGLIEDSCHAFT PRIMARY KEY 
	( id );	

ALTER TABLE KUNDE
	ADD CONSTRAINT PK_KUNDE PRIMARY KEY 
	( id );
	
ALTER TABLE SAUNA
	ADD CONSTRAINT PK_SAUNA PRIMARY KEY 
	( id );	
	
ALTER TABLE GETRAENK
	ADD CONSTRAINT PK_GETRAENK PRIMARY KEY 
	( id );
	
ALTER TABLE SPORTLER_NAHRUNG
	ADD CONSTRAINT PK_SPORTLER_NAHRUNG PRIMARY KEY 
	( id );
	
ALTER TABLE KAUF
	ADD CONSTRAINT PK_KAUF PRIMARY KEY 
	( id );
	
ALTER TABLE AKTION
	ADD CONSTRAINT PK_AKTION PRIMARY KEY 
	( id );
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT PK_ANGESTELLTER_FUNKTION PRIMARY KEY 
	( angestellter_id 
	, funktion_id );
	
ALTER TABLE ANGESTELLTER_KURS
	ADD CONSTRAINT PK_ANGESTELLTER_KURS PRIMARY KEY 
	( angestellter_id 
	, kurs_id );

ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT PK_MITGLIEDSCHAFT_AKTION PRIMARY KEY 
	( mitgliedschaft_id 
	, aktion_id );
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT PK_ANGESTELLTER_ADRESSE PRIMARY KEY 
	( angestellter_id 
	, adresse_id);
	
ALTER TABLE KUNDE_ADRESSE
	ADD CONSTRAINT PK_KUNDE_ADRESSE PRIMARY KEY 
	( kunde_id 
	, adresse_id );
	
ALTER TABLE UEBUNG
	ADD CONSTRAINT uebung_fitnessgeraet_fk FOREIGN KEY
	( fitnessgeraet_id )
	REFERENCES FITNESSGERAET
	( id ); 
	
ALTER TABLE UEBUNG
	ADD CONSTRAINT uebung_basistraining_fk FOREIGN KEY
	( basistraining_id )
	REFERENCES BASISTRAINING
	( id ); 
	
ALTER TABLE BASISTRAINING
	ADD CONSTRAINT basistraining_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id ); 

ALTER TABLE REHA_INFO
	ADD CONSTRAINT reha_info_kurs_fk FOREIGN KEY
	( kurs_id )
	REFERENCES KURS
	( id );

ALTER TABLE REHA_INFO
	ADD CONSTRAINT reha_info_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id );

ALTER TABLE EINFUEHRUNG
	ADD CONSTRAINT einfuehrung_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id );
	
ALTER TABLE EINFUEHRUNG
	ADD CONSTRAINT einfuehrung_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE MASSAGE
	ADD CONSTRAINT massage_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE MASSAGE
	ADD CONSTRAINT massage_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id );

ALTER TABLE MITGLIEDSCHAFT
	ADD CONSTRAINT mitgliedschaft_kunde_fk FOREIGN KEY
	( kunde_id )
	REFERENCES KUNDE
	( id );

ALTER TABLE KAUF
	ADD CONSTRAINT kauf_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id ); 
	
ALTER TABLE KAUF
	ADD CONSTRAINT kauf_getraenk_fk FOREIGN KEY
	( getraenk_id )
	REFERENCES GETRAENK
	( id );
	
ALTER TABLE KAUF
	ADD CONSTRAINT kauf_sportler_nahrung_fk FOREIGN KEY
	( sportler_nahrung_id )
	REFERENCES SPORTLER_NAHRUNG
	( id );
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id );
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_sauna_fk FOREIGN KEY
	( sauna_id )
	REFERENCES SAUNA
	( id );
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_basistraining_fk FOREIGN KEY
	( basistraining_id )
	REFERENCES BASISTRAINING
	( id );
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_kurs_fk FOREIGN KEY
	( kurs_id )
	REFERENCES KURS
	( id );
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT angestellter_funktion_ange_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT angestellter_funktion_funk_fk FOREIGN KEY
	( funktion_id )
	REFERENCES FUNKTION
	( id );
	
ALTER TABLE ANGESTELLTER_KURS
	ADD CONSTRAINT angestellter_kurs_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE ANGESTELLTER_KURS
	ADD CONSTRAINT angestellter_kurs_kurs_fk FOREIGN KEY
	( kurs_id )
	REFERENCES KURS
	( id );
	
ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT mitgliedschaft_aktion_mitg_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id );
	
ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT mitgliedschaft_aktion_akt_fk FOREIGN KEY
	( aktion_id )
	REFERENCES AKTION
	( id );
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_ange_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_adr_fk FOREIGN KEY
	( adresse_id )
	REFERENCES ADRESSE
	( id );
	
ALTER TABLE KUNDE_ADRESSE
	ADD CONSTRAINT kunde_adresse_kunde_fk FOREIGN KEY
	( kunde_id )
	REFERENCES KUNDE
	( id );
	
ALTER TABLE KUNDE_ADRESSE
	ADD CONSTRAINT kunde_adresse_adresse_fk FOREIGN KEY
	( adresse_id )
	REFERENCES ADRESSE
	( id );

	
/* Daten einfuegen: INSERT-Statements */

/* Datumsformat anpassen */
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

/* 1. KUNDE */

INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(1, 'Herr', 'Holstein', 'Peter', '1950-07-23', 'p.holstein@gmail.com', '015752356673', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(2, 'Herr', 'Meyer zu Wickern', 'Timo', '1948-06-10', null, '0571563118', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(3, 'Frau', 'Tischbein', 'Ulla', '1960-12-03', 'ullatisch@aol.com', '0571900174', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(4, 'Frau', 'Aslan', 'Aischa', '1996-05-20', 'Aaslan96@gmail.com', '01642789540', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(5, 'Herr', 'Aslan', 'Mehmet', '1995-11-08', 'Maslan95@gmail.com', '015754228790', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(6, 'Herr', 'Hildebrandt', 'Ben', '2000-11-19', 'Benjamin20@t-online.de', '0571035523', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(7, 'Herr', 'Petrow', 'Alexander', '1989-01-28', 'AlexPetrow89@t-online.de', '01642654408', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(8, 'Frau', 'Schmidt', 'Hilde', '1947-08-30', null, '0571254545', 'Schwiegermutter vom Chef');
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(9, 'Frau', 'Großer', 'Michelle', '1998-04-17', 'Michi17@gmail.com', '015754429887', null);
INSERT INTO KUNDE (id, anrede, name, vorname, geburtsdatum, email, telefon, notiz)
VALUES(10, 'Frau', 'Großer', 'Miriam', '1999-02-15', 'Miriam999@aol.com', '0164245529', null);

/* 2. ANGESTELLTER */

INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(1, 'Herr', 'Rösner', 'Harrald', '1968-01-31', 'Harrald.Roesner@gmail.com', '05713395623', null, null, null, null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(2, 'Herr', 'Morillio Mendoza', 'Viktor', '1984-06-25', 'Morillio@gmail.com', '015756690342', 13.10, 35, '2010-02-01', null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(3, 'Frau', 'Hagen', 'Jasmin', '1987-02-12', 'Jasmin97@aol.com', '05716442990', 13.50, 38, '2010-12-10', null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(4, 'Frau', 'Dudai', 'Birgit', '1975-05-18', 'Duda75@t-online.de', '05719823114', 12.00, 20, '2010-11-15', null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(5, 'Frau', 'Jaschinski', 'Magda', '1963-03-01', null, '015758842092', 9.19, 15, '2011-03-20', null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(6, 'Herr', 'Walter', 'Joshua', '1999-10-25', 'Josh2500@gmail.com', '01648729902', null, 35, null, 'Wohnt unentgeltlich über dem Gym, monatliches Entgelt 320?');
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(7, 'Herr', 'Götz', 'Fred', '2000-09-21', 'Götz2109@t-online.de', '015758200189', 9.19, 10, null, 'Student der Informatik an der FH');
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(8, 'Herr', 'Iwanow', 'Vladimir', '1983-04-03', 'VladTheImpaler@aol.com', '05713378290', 15.00, 10, '2013-07-01', null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(9, 'Herr', 'Brown', 'John', '1989-09-22', 'John.brown@gmail.com', '05715229073', 25.00, 25, '2012-08-01', null);
INSERT INTO ANGESTELLTER (id, anrede, name, vorname, geburtsdatum, email, telefon, stundenlohn, wochenarbeitszeit, einstellungsdatum, notiz)
VALUES(10, 'Herr', 'Peters', 'Manfred', '1972-01-30', 'Manfred92@aol.com', '015752039648', 11.00, 12, '2016-01-01', null);

/* 3. FUNKTION */

INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(1, 'Masseur', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(2, 'Physiotherapeut', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(3, 'Herzsport Übungsleiter', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(4, 'Diätassistent', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(5, 'Studentische Hilfskraft', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(6, 'FSJler', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(7, 'Fitness-Trainer', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(8, 'Chef', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(9, 'Hausmeister', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(10, 'Reinigungskraft', null);
INSERT INTO FUNKTION (id, funktion, notiz)
VALUES(11, 'Sekretär', null);

/* 4. ANGESTELLTER_FUNKTION */

INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(1, 2);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(1, 8);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(2, 7);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(3, 4);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(3, 2);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(4, 11);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(5, 10);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(6, 6);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(7, 5);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(8, 1);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(9, 3);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(9, 2);
INSERT INTO ANGESTELLTER_FUNKTION (angestellter_id, funktion_id)
VALUES(10, 9);

/* 5. ADRESSE */

INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(1, 'Zeugstraße', '11a', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(2, 'Bergweg', '3', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(3, 'Am Denkmal', '20', 32457, 'Porta Westfalica');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(4, 'Melittaweg', '4', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(5, 'Am Museum', '22', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(6, 'Berghof', '8', 32457, 'Porta WestfalicaMinden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(7, 'Rathausstraße', '28', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(8, 'Zwinger', '59', 32602, 'Vlotho');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(9, 'Ratstraße', '32', 32428, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(10, 'Schulstraße', '9', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(12, 'Schnurrviertel', '60', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(13, 'Altstadt', '6', 32429, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(14, 'Domstraße', '1c', 32428, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(15, 'Ahornweg', '11', 32469, 'Petershagen');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(16, 'Oeynhausenerweg', '6', 32545, 'Bad Oeynhausen');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(17, 'An der Schleuse', '34', 32427, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(19, 'Marktstraße', '17', 32429, 'Minden');
INSERT INTO ADRESSE (id, straße, haus_nr, plz, ort)
VALUES(20, 'Bäderstraße', '29', 32545, 'Bad Oeynhausen');

/* 6. ANGESTELLTER_ADRESSE */

INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(1, 3);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(2, 6);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(3, 15);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(4, 16);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(5, 20);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(6, 9);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(7, 4);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(8, 5);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(9, 8);
INSERT INTO ANGESTELLTER_ADRESSE (angestellter_id, adresse_id)
VALUES(10, 13);

/* 7. KUNDE_ADRESSE */

INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(1, 12);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(3, 17);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(9, 7);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(10, 7);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(4, 19);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(5, 19);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(8, 14);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(2, 10);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(6, 2);
INSERT INTO KUNDE_ADRESSE (kunde_id, adresse_id)
VALUES(7, 1);

/* 8. MITGLIEDSCHAFT */

INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(1, '2010-02-01', '2016-05-01', 'Lastschrift', 1);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(2, '2010-02-01', '2012-02-01', 'Rechnung', 2);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(3, '2010-02-01', null, 'Lastschrift', 3);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(4, '2013-10-01', '2015-10-01', 'Rechnung', 2);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(5, '2015-02-01', null, 'Lastschrift', 4);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(6, '2015-02-01', null, 'Lastschrift', 5);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(7, '2016-09-01', null, 'Rechnung', 8);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(8, '2015-02-01', null, 'PayPal', 7);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(9, '2017-03-01', null, 'Lastschrift', 9);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(10, '2018-01-01', null, 'Rechnung', 2);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(11, '2018-03-01', null, 'Lastschrift', 10);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(12, '2018-03-01', null, 'Lastschrift', 6);
INSERT INTO MITGLIEDSCHAFT (id, beitritt, austritt, zahlungsart, kunde_id)
VALUES(13, '2017-12-01', null, 'Lastschrift', 1);

/* 9. AKTION */

INSERT INTO AKTION (id, beschreibung)
VALUES(1, 'Kundenwerbung: Getränk umsonst');
INSERT INTO AKTION (id, beschreibung)
VALUES(2, 'Rabattwoche : Basistraining 95%');
INSERT INTO AKTION (id, beschreibung)
VALUES(3, 'Einführung umsonst');
INSERT INTO AKTION (id, beschreibung)
VALUES(4, 'Circel Training für Kunden mit Basistraining 75% Nachlass');
INSERT INTO AKTION (id, beschreibung)
VALUES(5, 'Zumba für Kunden mit Basistraining 75% Nachlass');

/* 10. MITGLIEDSCHAFT_AKTION */

INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(9, 1);
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(8, 2);
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(12, 3);
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(6, 4);
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(9, 5);
INSERT INTO MITGLIEDSCHAFT_AKTION (mitgliedschaft_id, aktion_id)
VALUES(11, 5);

/* 11. MASSAGE */

INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(1, '2015-03-12', 20.00, 'Ganzkörper', 8, 4);
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(2, '2018-01-30', 25.00, 'Ganzkörper', 8, 7);
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(3, '2018-04-02', 15.00, 'Schultergürtel', 1, 10);
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(4, '2018-05-23', 15.00, 'Untere Extremität', 1, 1);
INSERT INTO MASSAGE (id, datum, preis, typ, angestellter_id, mitgliedschaft_id)
VALUES(5, '2018-07-29', 20.00, 'Rücken', 8, 8);

/* 12. EINFUEHRUNG */

INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(1, '2010-02-01', 15.00, 76.0, null, null, 1, 1);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(2, '2010-02-01', 15.00, 82.0, null, null, 2, 1);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(3, '2010-02-01', 15.00, 56.0, null, null, 3, 1);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(4, '2013-10-15', 30.00, 91.0, 26, 21, 4, 2);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(5, '2015-02-15', 30.00, 52.0, 21, 16, 5, 1);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(6, '2015-02-15', 30.00, 78.0, 26, 22, 6, 2);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(7, '2018-03-02', 0.00, 120.0, 38, 41, 12, 2);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(8, '2017-12-12', 30.00, 97.0, null, 23, 8, 1);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(9, '2017-03-15', 30.00, 85.0, null, null, 9, 9);
INSERT INTO EINFUEHRUNG (id, datum, preis, gewicht, bmi, koerperfett, mitgliedschaft_id, angestellter_id)
VALUES(10, '2018-03-14', 30.00, null, null, null, 11, 9);


/* 13. GETRAENK */

INSERT INTO GETRAENK (id, typ, preis)
VALUES(1, 'Mineralwasser', 0.80);
INSERT INTO GETRAENK (id, typ, preis)
VALUES(2, 'Iso-Drink', 1.20);
INSERT INTO GETRAENK (id, typ, preis)
VALUES(3, 'Cola Light', 1.20);
INSERT INTO GETRAENK (id, typ, preis)
VALUES(4, 'Kaffee', 2.00);
INSERT INTO GETRAENK (id, typ, preis)
VALUES(5, 'Tee', 1.50);
INSERT INTO GETRAENK (id, typ, preis)
VALUES(6, 'Milchshake', 2.50);


/* 14. SPORTLER_NAHRUNG */

INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(1, 'Protein Riegel Schoko', 1.80);
INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(2, 'Power Protein Bar Erdbeer', 1.20);
INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(3, 'Müslimischung proteinreich', 5.50);
INSERT INTO SPORTLER_NAHRUNG (id, typ, preis)
VALUES(4, 'Proteinpulver Muskelaufbau', 39.50);

/* 15. KAUF */

INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(1, '2015-02-10', 5, 1, null);
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(2, '2015-04-12', 4, 4, null);
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(3, '2018-05-30', 12, null, 2);
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(4, '2015-02-23', 5, 6, null);
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(5, '2018-01-20', 8, null, 4);
INSERT INTO KAUF (id, kauf, mitgliedschaft_id, getraenk_id, sportler_nahrung_id)
VALUES(6, '2015-02-13', 5, 2, null);


/* 16. SAUNA */

INSERT INTO SAUNA (id, beginn, laufzeit)
VALUES(1, '2011-02-01', 6);
INSERT INTO SAUNA (id, beginn, laufzeit)
VALUES(2, '2017-12-01', 24);

/* 17. KURS */

INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(1, 'Gewichtsreduktion', '2018-04-02', '2018-06-18', 'Raum F', 12);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(2, 'Yoga', '2012-05-23', '2012-07-24', null, 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(3, 'Zumba', '2018-04-04', '2018-06-20', 'Halle', 12);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(4, 'Pilates', '2012-05-23', '2012-07-24', null, 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(5, 'Step', '2012-05-23', '2012-07-24', null, 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(6, 'Indoor-Cycling', '2012-05-23', '2012-07-24', null, 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(7, 'Herz-Kreislauf', '2012-05-23', '2012-07-24', null, 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(8, 'Circel Training', '2018-01-01', '2018-04-01', 'Vorhalle', 12);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(9, 'Koronarsport', '2018-01-04', '2018-02-22', 'Halle', 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(10, 'Rückengymnastik', '2018-04-03', '2018-05-23', 'Halle', 8);
INSERT INTO KURS (id, typ, beginn, ende, raum, terminanzahl)
VALUES(11, 'Beckenbodengymnastik', '2018-04-05', '2018-06-21', 'Spiegelsaal', 12);

/* 18. ANGESTELLTER_KURS */

INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 1);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(2, 2);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 3);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 4);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(6, 5);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(7, 6);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(9, 7);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(6, 8);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(9, 9);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(1, 10);
INSERT INTO ANGESTELLTER_KURS (angestellter_id, kurs_id)
VALUES(3, 11);

/* 19. REHA_INFO */

INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(1, 'Krankenkasse', 'Techniker', '75 Watt', 'Hausarzt Dr. Rüdiger, Herzinfarkt 06-06-2016', 9, 13);
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(2, 'Krankenkasse', 'Barmer', null, 'Hausarzt Dr. Hill', 1, 12);
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(3, 'Selbstzahler', null, null, 'Hausarzt Dr. Rüdiger', 1, 9);
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(4, 'Selbstzahler', null, null, 'Hausarzt Dr. Rüdiger', 10, 3);
INSERT INTO REHA_INFO (id, zahlung, krankenkasse, belastbarkeit, notiz, kurs_id, mitgliedschaft_id)
VALUES(5, 'Krankenkasse', 'AOK', null, 'Hausarzt Dr. Hill', 11, 7);


/* 20. BASISTRAINING */

INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(1, '2010-02-01', 6, 1, '2015-12-15', null, null, 1);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(2, '2010-02-01', 12, 2, '2011-12-15', null, null, 1);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(3, '2010-02-01', 24, 3, null, null, null, 1);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(4, '2013-10-01', 24, 3, '2015-06-15', null, null, 3);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(5, '2015-02-01', 12, 2, null, 'j', null, 3);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(6, '2015-02-01', 12, 2, null, null, null, 2);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(7, '2018-02-01', 12, 2, null, 'j', null, 1);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(8, '2017-12-01', 24, 3, null, null, null, 2);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(9, '2017-03-01', 12, 2, null, 'j', null, 9);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(10, '2018-03-01', 12, 2, null, null, null, 3);
INSERT INTO BASISTRAINING (id, beginn, mindestlaufzeit, kuendigungsfrist, kuendigung, getraenk, notiz, angestellter_id)
VALUES(11, '2018-03-01', 12, 2, null, null, null, 9);


/* 21. FITNESSGERAET */

INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(1, 'Laufband', 'emotion fitness GmbH', 'Motion Sprint 300', 3.0, '2010-03-20', '2012-04-23', 'j', 'reparaturanfällig');
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(2, 'Laufband', 'Intenza Fitness GmbH', 'Laufband 550 Ti', 3.0, '2014-12-01', '2017-05-03', null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(3, 'Ergometer', 'Intenza Fitness GmbH', 'Intenza Ergometer UBi', 2.5, '2014-05-20', '2017-05-03', null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(4, 'Überzug', 'gym80 International GmbH', 'pullover', 2.5, '2017-04-30', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(5, 'Beinpresse', 'gym80 International GmbH', 'Leg Press', 3.0, '2017-08-09', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(6, 'Abduktion', 'gym80 International GmbH', 'Abduction machine', 2.5, '2016-11-09', '2018-03-01', null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(7, 'Adduktion', 'gym80 International GmbH', 'Adduction machine', 2.5, '2016-03-11', '2018-03-01', null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(8, 'Rückenübung', 'gym80 International GmbH', 'Lat Pulley', 3.0, '2017-05-30', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(9, 'Rumpfstemme', 'gym80 International GmbH', 'Chest Press, Sygnum', 2.2, '2017-02-10', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(10, 'Glutaeus-Maschine', 'gym80 International GmbH', 'Glutaeus machine', 2.0, '2017-02-14', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(11, 'Beine strecken', 'gym80 International GmbH', 'Leg Extension', 2.0, '2017-05-04', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(12, 'Beine beugen', 'gym80 International GmbH', 'Leg Curl', 2.0, '2016-06-06', '2018-03-01', null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(13, 'Seilzugapparat', 'Lojer', 'Tree Pulley ', 2.0, '2016-04-01', '2018-03-01', null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(14, 'Bauchmuskulatur', 'gym80 International GmbH', 'Twister Basic', 3.5, '2017-03-24', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(15, 'Bruststabilisator', 'gym80 International GmbH', 'Chest Fixator',2.0, '2018-04-05', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(16, 'Bizepsgerät', 'gym80 International GmbH', 'Pure Kraft Bizepsgerät', 3.0, '2018-04-05', null, null, null);
INSERT INTO FITNESSGERAET (id, typ, firma, name, quadratmeter, kaufdatum, wartung, ausgemustert, notiz)
VALUES(17, 'Crosstrainer', 'Intenza Fitness GmbH', 'Crosstrainer 550ETi', 3.5, '2018-04-08', null, null, null);

/* 22. UEBUNG */

INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(1, '2018-09-04', '10 Minuten 80 Watt', null, null, null, 3, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(2, '2018-09-04', null, 20.0, 15, 3, 4, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(3, '2018-09-04', null, 35.0, 15, 3, 6, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(4, '2018-09-04', null, 35.0, 15, 3, 7, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(5, '2018-09-04', null, 15.0, 10, 3, 13, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(6, '2018-09-04', null, 20.0, 10, 3, 14, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(7, '2018-09-04', '10 Minuten 100 Watt', null, null, null, 17, 3);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(8, '2018-03-01', '15 Minuten 75 Watt', null, null, null, 2, 7);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(9, '2018-03-01', null, 105.0, 15, 3, 5, 7);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(10, '2018-03-01', null, 45.0, 15, 3, 8, 7);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(11, '2018-03-01', null, 25.0, 15, 3, 9, 7);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(12, '2018-03-01', null, 35.0, 15, 3, 14, 7);
INSERT INTO UEBUNG (id, datum, beschreibung, gewicht, anzahl, wiederholung, fitnessgeraet_id, basistraining_id)
VALUES(13, '2018-03-01', null, 10.0, 10, 3, 16, 7);


/* 23. VERTRAG */

INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(1, 38.00, null, null, 1, null, 1, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(2, 36.00, null, null, 2, null, 2, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(3, 32.00, null, null, 3, null, 3, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(4, 32.00, null, null, 4, null, 4, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(5, 35.00, null, null, 5, null, 5, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(6, 34.00, null, null, 6, null, 6, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(7, 35.00, null, null, 12, null, 7, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(8, 32.00, 5, null, 8, null, 8, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(9, 31.00, null, null, 9, null, 9, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(10, 34.00, null, null, 10, null, 10, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(11, 100.00, null, null, 13, null, null, 9);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(12, 120.00, null, null, 12, null, null, 1);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(13, 120.00, null, null, 9, null, null, 1);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(14, 80.00, null, null, 3, null, null, 10);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(15, 60.00, null, null, 7, null, null, 11);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(16, 40.00, 75, null, 6, null, null, 8);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(17, 40.00, 75, null, 9, null, null, 3);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(18, 40.00, 75, null, 11, null, null, 3);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(19, 33.00, null, null, 11, null, 11, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(20, 4.00, null, null, 8, 1, null, null);
INSERT INTO VERTRAG (id, preis, rabatt, notiz, mitgliedschaft_id, sauna_id, basistraining_id, kurs_id)
VALUES(21, 3.00, null, null, 3, 2, null, null);