
/* Anlegen der ER-entitys */
CREATE TABLE FITNESSGERAET
	( id decimal(5,0) NOT NULL
	, typ varchar(300) NOT NULL
	, firma varchar(100) NOT NULL
	, name varchar(100)
	, quadratmeter decimal(3,1)
	, kaufdatum date
	, wartung date
	, ausgemustert varchar(1)
	, notiz varchar(1000)
);

CREATE TABLE UEBUNG
	( id decimal(5,0) NOT NULL
	, datum date NOT NULL
	, beschreibung varchar(1000) NOT NULL
	, gewicht decimal(3,1) 
	, anzahl decimal(3,0)
	, wiederholung decimal(3,0)
	, fitnessgeraet_id decimal(5,0)
	, basistraining_id decimal(5,0) NOT NULL
);

CREATE TABLE BASISTRAINING
	( id decimal(5,0) NOT NULL
	, beginn date NOT NULL
	, mindestlaufzeit decimal(2,0) NOT NULL
	, kuendigungsfrist decimal(2,0) NOT NULL
	, kuendigung date
	, getraenk varchar(1)
	, notiz varchar(1000)
	, angestellter_id decimal(5,0)
);

CREATE TABLE FUNKTION
	( id decimal(5,0) NOT NULL
	, funktion varchar(50) NOT NULL
	, notiz varchar(1000)
);

CREATE TABLE ADRESSE
	( id decimal(5,0) NOT NULL
	, straße varchar(50) NOT NULL
	, haus_nr varchar(10) NOT NULL
	, plz decimal(5,0) NOT NULL
	, ort varchar(50)
);

CREATE TABLE ANGESTELLTER
	( id decimal(5,0) NOT NULL
	, anrede varchar(20) NOT NULL
	, name varchar(100) NOT NULL
	, vorname varchar(100) NOT NULL
	, geburtsdatum date NOT NULL
	, email varchar(50)
	, telefon varchar(50)
	, stundenlohn decimal(3,2)
	, wochenarbeitszeit decimal(2,2)
	, einstellungsdatum date
	, notiz varchar(1000)
);

CREATE TABLE KURS
	( id decimal(5,0) NOT NULL
	, typ varchar(50) NOT NULL
	, beginn date NOT NULL
	, ende date NOT NULL
	, raum varchar(50)
	, terminanzahl decimal(2,0)
);

CREATE TABLE REHA_INFO
	( id decimal(5,0) NOT NULL
	, zahlung varchar(200) NOT NULL
	, krankenkasse varchar(100) NOT NULL
	, belastbarkeit varchar(1000)
	, notiz varchar(1000)
	, kurs_id decimal(5,0) NOT NULL
	, mitgliedschaft_id decimal(5,0) NOT NULL
);

CREATE TABLE EINFUEHRUNG
	( id decimal(5,0) NOT NULL
	, datum date NOT NULL
	, preis decimal(3,2)
	, gewicht decimal(3,1)
	, bmi decimal(2,1)
	, koerperfett decimal(2,2)
	, mitgliedschaft_id decimal(5,0) NOT NULL
	, angestellter_id decimal(5,0) NOT NULL
);

CREATE TABLE MASSAGE
	( id decimal(5,0) NOT NULL
	, datum date NOT NULL
	, preis decimal(2,2) NOT NULL
	, typ varchar(500)
	, angestellter_id decimal(5,0) NOT NULL
	, mitgliedschaft_id decimal(5,0) NOT NULL
);

CREATE TABLE VERTRAG
	( id decimal(5,0) NOT NULL
	, preis decimal(3,2) NOT NULL
	, rabatt decimal(2,2)
	, notiz varchar(1000)
	, mitgliedschaft_id decimal(5,0) NOT NULL
	, sauna_id decimal(5,0)
	, basistraining_id decimal(5,0)
	, kurs_id decimal(5,0)
);

CREATE TABLE MITGLIEDSCHAFT
	( id decimal(5,0) NOT NULL
	, beitritt date NOT NULL
	, austritt date 
	, zahlungsart varchar(50)
	, kunde_id decimal(5,0) NOT NULL
);

CREATE TABLE KUNDE
	( id decimal(5,0) NOT NULL
	, anrede varchar(100) NOT NULL
	, name varchar(100) NOT NULL
	, vorname varchar(100) NOT NULL
	, geburtsdatum date NOT NULL
	, email varchar(50)
	, telefon varchar(50)
	, notiz varchar(1000)
);

CREATE TABLE SAUNA
	( id decimal(5,0) NOT NULL
	, beginn date NOT NULL
	, laufzeit decimal(2,0) NOT NULL
);

CREATE TABLE GETRAENK
	( id decimal(5,0) NOT NULL
	, typ varchar(50) NOT NULL
	, preis decimal(2,2) NOT NULL
);

CREATE TABLE SPORTLER_NAHRUNG
	( id decimal(5,0) NOT NULL
	, typ varchar(50) NOT NULL
	, preis decimal(2,2) NOT NULL
);

CREATE TABLE KAUF
	( id decimal(5,0) NOT NULL
	, kauf date NOT NULL
	, mitgliedschaft_id decimal(5,0) NOT NULL
	, getraenk_id decimal(5,0)
	, sportler_nahrung_id decimal(5,0)
);

CREATE TABLE AKTION
	( id decimal(5,0) NOT NULL
	, beschreibung varchar(1000) NOT NULL
);

CREATE TABLE ANGESTELLTER_FUNKTION
	( angestellter_id decimal(5,0) NOT NULL
	, funktion_id decimal(5,0) NOT NULL 
);

CREATE TABLE ANGESTELLTER_KURS
	( angestellter_id decimal(5,0) NOT NULL
	, kurs_id decimal(5,0) NOT NULL
);
	
CREATE TABLE MITGLIEDSCHAFT_AKTION
	( mitgliedschaft_id decimal(5,0) NOT NULL
	, aktion_id decimal(5,0) NOT NULL
);
	
CREATE TABLE ANGESTELLTER_ADRESSE
	( angestellter_id decimal(5,0) NOT NULL
	, adresse_id decimal(5,0) NOT NULL
);

CREATE TABLE KUNDE_ADRESSE
	( kunde_id decimal(5,0) NOT NULL
	, adresse_id decimal(5,0) NOT NULL
);

/* CONSTRAINTS anlegen */

ALTER TABLE FITNESSGERAET
	ADD CONSTRAINT fitnessgeraet_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE UEBUNG
	ADD CONSTRAINT uebung_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE BASISTRAINING
	ADD CONSTRAINT basistraining_id_pk PRIMARY KEY 
	( id );

ALTER TABLE FUNKTION
	ADD CONSTRAINT funktion_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE ADRESSE
	ADD CONSTRAINT adresse_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE ANGESTELLTER
	ADD CONSTRAINT angestellter_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE KURS
	ADD CONSTRAINT kurs_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE REHA_INFO
	ADD CONSTRAINT reha_info_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE EINFUEHRUNG
	ADD CONSTRAINT einfuehrung_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE MASSAGE
	ADD CONSTRAINT massage_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE VERTRAG
	ADD CONSTRAINT vertrag_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE MITGLIEDSCHAFT
	ADD CONSTRAINT mitgliedschaft_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE KUNDE
	ADD CONSTRAINT kunde_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE SAUNA
	ADD CONSTRAINT sauna_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE GETRAENK
	ADD CONSTRAINT getraenk_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE SPORTLER_NAHRUNG
	ADD CONSTRAINT sportler_nahrung_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE KAUF
	ADD CONSTRAINT kauf_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE AKTION
	ADD CONSTRAINT aktion_id_pk PRIMARY KEY 
	( id );
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT angestellter_funktion_id_pk PRIMARY KEY 
	( angestellter_id
	, funktion_id );
	
ALTER TABLE ANGESTELLTER_KURS
	ADD CONSTRAINT angestellter_kurs_id_pk PRIMARY KEY
	( angestellter_id
	, kurs_id );

ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT mitgliedschaft_aktion_id_pk PRIMARY KEY
	( mitgliedschaft_id
	, aktion_id );
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_id_pk PRIMARY KEY
	( angestellter_id
	, adresse_id );
	
ALTER TABLE KUNDE_ADRESSE
	ADD CONSTRAINT kunde_adresse_id_pk PRIMARY KEY
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
	ADD CONSTRAINT angestellter_funktion_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE ANGESTELLTER_FUNKTION
	ADD CONSTRAINT angestellter_funktion_funktion_fk FOREIGN KEY
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
	ADD CONSTRAINT mitgliedschaft_aktion_mitgliedschaft_fk FOREIGN KEY
	( mitgliedschaft_id )
	REFERENCES MITGLIEDSCHAFT
	( id );
	
ALTER TABLE MITGLIEDSCHAFT_AKTION
	ADD CONSTRAINT mitgliedschaft_aktion_aktion_fk FOREIGN KEY
	( aktion_id )
	REFERENCES AKTION
	( id );
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_angestellter_fk FOREIGN KEY
	( angestellter_id )
	REFERENCES ANGESTELLTER
	( id );
	
ALTER TABLE ANGESTELLTER_ADRESSE
	ADD CONSTRAINT angestellter_adresse_adresse_fk FOREIGN KEY
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