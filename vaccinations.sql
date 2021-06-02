create database vaccinations;
drop database vaccinations;

#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: categorie_vaccin
#------------------------------------------------------------

CREATE TABLE categorie_vaccin(
        id_vaccin   Int  Auto_increment  NOT NULL ,
        code_vaccin Varchar (50) NOT NULL
	,CONSTRAINT categorie_vaccin_PK PRIMARY KEY (id_vaccin)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ecoles
#------------------------------------------------------------

CREATE TABLE ecoles(
        Ecole_id    Int  Auto_increment  NOT NULL ,
        nb_eleves   Int NOT NULL ,
        nom_ecole   Varchar (30) NOT NULL ,
        adresse     Varchar (30) NOT NULL ,
        code_postal Varchar (5) NOT NULL ,
        ville       Varchar (30) NOT NULL
	,CONSTRAINT ecoles_PK PRIMARY KEY (Ecole_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: centres_medicaux
#------------------------------------------------------------

CREATE TABLE centres_medicaux(
        centre_medicaux_id Int  Auto_increment  NOT NULL ,
        nom                Varchar (30) NOT NULL ,
        adresse            Varchar (30) NOT NULL ,
        code_postal        Varchar (5) NOT NULL ,
        ville              Varchar (30) NOT NULL
	,CONSTRAINT centres_medicaux_PK PRIMARY KEY (centre_medicaux_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: medecins
#------------------------------------------------------------

CREATE TABLE medecins(
        medecins_id        Varchar (5) NOT NULL ,
        nom                Varchar (30) NOT NULL ,
        prenom             Varchar (30) NOT NULL ,
        centre_medicaux_id Int NOT NULL
	,CONSTRAINT medecins_PK PRIMARY KEY (medecins_id)

	,CONSTRAINT medecins_centres_medicaux_FK FOREIGN KEY (centre_medicaux_id) REFERENCES centres_medicaux(centre_medicaux_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: spécialités
#------------------------------------------------------------

CREATE TABLE specialites(
        specialite_id  Int  Auto_increment  NOT NULL ,
        Nom_Specialite Varchar (30) NOT NULL
	,CONSTRAINT specialites_PK PRIMARY KEY (specialite_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: enfants
#------------------------------------------------------------

CREATE TABLE enfants(
        enfant_id Int  Auto_increment  NOT NULL ,
        nom       Varchar (30) NOT NULL ,
        prenom    Varchar (30) NOT NULL ,
        age       Int NOT NULL ,
        sexe      Char (1) NOT NULL ,
        poids     Int NOT NULL ,
        taille    Int NOT NULL ,
        Ecole_id  Int
	,CONSTRAINT enfants_PK PRIMARY KEY (enfant_id)

	,CONSTRAINT enfants_ecoles_FK FOREIGN KEY (Ecole_id) REFERENCES ecoles(Ecole_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: vaccinations
#------------------------------------------------------------

CREATE TABLE vaccinations(
        Vaccination_id   Int  Auto_increment  NOT NULL ,
        date_vaccination Date NOT NULL ,
        medecins_id      Varchar (5) NOT NULL ,
        enfant_id        Int NOT NULL ,
        id_vaccin        Int NOT NULL
	,CONSTRAINT vaccinations_PK PRIMARY KEY (Vaccination_id)

	,CONSTRAINT vaccinations_medecins_FK FOREIGN KEY (medecins_id) REFERENCES medecins(medecins_id)
	,CONSTRAINT vaccinations_enfants0_FK FOREIGN KEY (enfant_id) REFERENCES enfants(enfant_id)
	,CONSTRAINT vaccinations_categorie_vaccin1_FK FOREIGN KEY (id_vaccin) REFERENCES categorie_vaccin(id_vaccin)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: medecins_Specialites
#------------------------------------------------------------

CREATE TABLE medecins_Specialites(
        medecins_id   Varchar (5) NOT NULL ,
        specialite_id Int NOT NULL
	,CONSTRAINT medecins_Specialites_PK PRIMARY KEY (medecins_id,specialite_id)

	,CONSTRAINT medecins_Specialites_medecins_FK FOREIGN KEY (medecins_id) REFERENCES medecins(medecins_id)
	,CONSTRAINT medecins_Specialites_specialites0_FK FOREIGN KEY (specialite_id) REFERENCES specialites(specialite_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: medecins_ecoles
#------------------------------------------------------------

CREATE TABLE medecins_ecoles(
        Ecole_id    Int NOT NULL ,
        medecins_id Varchar (5) NOT NULL
	,CONSTRAINT medecins_ecoles_PK PRIMARY KEY (Ecole_id,medecins_id)

	,CONSTRAINT medecins_ecoles_ecoles_FK FOREIGN KEY (Ecole_id) REFERENCES ecoles(Ecole_id)
	,CONSTRAINT medecins_ecoles_medecins0_FK FOREIGN KEY (medecins_id) REFERENCES medecins(medecins_id)
)ENGINE=InnoDB;

