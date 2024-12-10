CREATE TABLE Lieu (
    idLieu INTEGER PRIMARY KEY,
    NomLieu VARCHAR2(30) NOT NULL,
    ville VARCHAR2(100) NOT NULL,
    Adresse VARCHAR2(100) NOT NULL,
    capacite NUMBER NOT NULL,
    estSupprime VARCHAR2(3) DEFAULT 'NON' NOT NULL, 
    CONSTRAINT chk_lieu_estSupprime CHECK (UPPER(estSupprime) IN ('OUI', 'NON'))
);

CREATE TABLE Artiste
	(idArt INTEGER PRIMARY KEY,
	NomArt VARCHAR2 (30) NOT NULL,
	PrenomArt VARCHAR2 (30) NOT NULL,
    specialite VARCHAR2 (10) NOT NULL,
	CONSTRAINT chk_specialite_artiste CHECK (UPPER(specialite) IN ('DANSEUR', 'ACTEUR', 'MUSICIEN', 'MAGICIEN', 'IMITATEUR', 'HUMORISTE', 'CHANTEUR'))
	);

CREATE TABLE SPECTACLE 
	(idSpec INTEGER PRIMARY KEY,
	 Titre VARCHAR2 (40) NOT NULL,
     dateS DATE,
     h_debut NUMBER(4,2) NOT NULL,
	 dureeS NUMBER(4,2) NOT NULL,
     nbrSpectateur INTEGER NOT NULL,
     nbrRubriques NUMBER DEFAULT 0 NOT NULL,
	 idLieu INTEGER,	
	 CONSTRAINT chk_spect_durees CHECK (dureeS BETWEEN 1 AND 4),
     CONSTRAINT FK_spect_Lieux FOREIGN KEY(idLieu)REFERENCES Lieu (idLieu)
	);

CREATE TABLE Rubrique
	(idRub INTEGER PRIMARY KEY, 
	 idSpec INTEGER NOT NULL, 
	 idArt INTEGER NOT NULL, 
	 H_debutR NUMBER(4,2) NOT NULL, 
     dureeRub NUMBER(4,2) NOT NULL, 
     type VARCHAR2(10), 
	 CONSTRAINT fk_rub_spect FOREIGN KEY(idSpec) REFERENCES SPECTACLE(idSpec) ON DELETE CASCADE,
	 CONSTRAINT fk_rub_art FOREIGN KEY(idArt)  REFERENCES Artiste(idArt) ON DELETE CASCADE,
	 CONSTRAINT chk_type_rubrique CHECK (UPPER(type) IN ('COMEDIE', 'THEATRE', 'DANCE', 'IMITATION', 'MAGIE', 'MUSIQUE', 'CHANT'))
	);

CREATE TABLE CATEGORIEBILLET(
    idspec INTEGER NOT NULL,
	categorie VARCHAR2(10) NOT NULL,
	prix NUMBER(5,2) NOT NULL,
	CONSTRAINT fk_billet_spec FOREIGN KEY (idspec)REFERENCES spectacle,
	CONSTRAINT chk_billet_PRIX CHECK(prix BETWEEN 10 AND 300),
	CONSTRAINT chk_billet_categorie CHECK(UPPER(categorie) IN ('GOLD', 'SILVER','NORMALE')),
    PRIMARY KEY (idspec,categorie)
	);

CREATE TABLE BILLET(
    idBillet INTEGER PRIMARY KEY,
    categorie VARCHAR2(10),
    idspec INTEGER NOT NULL ,
    Vendu VARCHAR(3) NOT NULL, 
    CONSTRAINT fk_billetSpec FOREIGN KEY (idspec)REFERENCES spectacle,
    CONSTRAINT chk_billet_vendu CHECK(UPPER(vendu) IN ('OUI','NON')),
    CONSTRAINT chk_billetCategorie CHECK(UPPER(categorie) IN ('GOLD', 'SILVER','NORMALE')),
    FOREIGN KEY (idspec,categorie) REFERENCES CATEGORIEBILLET(idspec,categorie)
);