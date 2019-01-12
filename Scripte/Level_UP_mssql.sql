
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
															'SHK',
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
												'Circle Training',
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