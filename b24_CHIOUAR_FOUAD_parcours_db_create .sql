/**************************************************************

CREATION des tables pour la SAE 204

@author CHIOUAR Yanis
@author FOUAD Yanis

***************************************************************/


/*Création du schema 'parcoursup'*/
DROP SCHEMA IF EXISTS parcoursup CASCADE;
CREATE SCHEMA parcoursup;
SET SCHEMA 'parcoursup';



/*Création de la table _region*/
CREATE TABLE _region(
    region_nom  VARCHAR NOT NULL,
     CONSTRAINT  _region_pk PRIMARY KEY (region_nom)
);

/*Création de la table _departement*/
CREATE TABLE _departement(
    departement_code  VARCHAR NOT NULL,
    departement_nom  VARCHAR NOT NULL,
    region_nom  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
     CONSTRAINT  _departement_pk PRIMARY KEY (departement_code)
);

/*Création de la table _commune*/
CREATE TABLE _commune(
    commune_nom  VARCHAR NOT NULL,
    departement_code  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
     CONSTRAINT  _commune_pk PRIMARY KEY (commune_nom,departement_code)
);

/*Création de la table _formation*/
CREATE TABLE _formation(
    cod_aff_form  VARCHAR NOT NULL,
    filiere_libelle_detaille  VARCHAR NOT NULL,
    coordonnees_gps  VARCHAR NOT NULL,
    list_com  VARCHAR NOT NULL,
    concours_communs_banque_epreuve  VARCHAR NOT NULL,
    url_formation  VARCHAR NOT NULL,
    tri  VARCHAR NOT NULL,
    commune_nom  VARCHAR NOT NULL, /*CLE ETRANGERE*/
    departement_code  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
    etablissement_code_uai  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
    academie_nom  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
    filiere_id INT  NOT NULL,  /*CLE ETRANGERE*/ 
     CONSTRAINT  _formation_pk PRIMARY KEY (cod_aff_form)
);

/*Création de la table _etablissement*/
CREATE TABLE _etablissement(
    etablissement_code_uai  VARCHAR NOT NULL,
    etablissement_nom  VARCHAR NOT NULL, 
    etablissement_statut  VARCHAR NOT NULL,
     CONSTRAINT  _etablissement_pk PRIMARY KEY (etablissement_code_uai)
);

/*Création de la table _academie*/
CREATE TABLE _academie(
    academie_nom  VARCHAR NOT NULL,
     CONSTRAINT  _academie_pk PRIMARY KEY (academie_nom)
);

/*Création de la table _filiere*/
CREATE TABLE _filiere(
    filiere_id SERIAL  NOT NULL,
    filiere_libelle  VARCHAR NOT NULL,
    filiere_libelle_tres_abrege  VARCHAR NOT NULL,
    filiere_libelle_abrege  VARCHAR NOT NULL,
    filiere_libelle_detaille_bis  VARCHAR NOT NULL,
     CONSTRAINT  _filiere_pk PRIMARY KEY (filiere_id)
);

/*Création de la table _rang_dernier_appele_selon_regroupement*/
CREATE TABLE _rang_dernier_appele_selon_regroupement(
    rang_dernier_appele INT  NOT NULL,
    cod_aff_form  VARCHAR NOT NULL, /*CLE ETRANGERE*/
    libelle_regroupement  VARCHAR NOT NULL, /*CLE ETRANGERE*/
    session_annee INT  NOT NULL, /*CLE ETRANGERE*/
     CONSTRAINT  _rang_dernier_appele_selon_regroupement_pk PRIMARY KEY (cod_aff_form, libelle_regroupement, session_annee)
);

/*Création de la table _regroupement*/
CREATE TABLE _regroupement(
    libelle_regroupement  VARCHAR NOT NULL,
     CONSTRAINT  _regroupement_pk PRIMARY KEY (libelle_regroupement)
);

/*Création de la table _session*/
CREATE TABLE _session(
    session_annee INT NOT NULL,
     CONSTRAINT  _session_pk PRIMARY KEY (session_annee)
);

/*Création de la table _admission_generalites*/
CREATE TABLE _admissions_generalites(
    cod_aff_form  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
    session_annee INT  NOT NULL,  /*CLE ETRANGERE*/
    selectivite  VARCHAR NOT NULL,
    capacite INT  NOT NULL,
    effectif_total_candidats INT  NOT NULL,
    effectif_total_candidates INT  NOT NULL,
     CONSTRAINT  _admissions_generalites_pk PRIMARY KEY (cod_aff_form, session_annee)
);

/*Création de la table _admission_selon_type_neo_bac*/
CREATE TABLE _admission_selon_type_neo_bac(
    cod_aff_form  VARCHAR NOT NULL, /*CLE ETRANGERE*/
    type_bac  VARCHAR NOT NULL, /*CLE ETRANGERE*/
    session_annee INT NOT NULL, /*CLE ETRANGERE*/
    effectif_candidat_neo_bac_classes INT  NOT NULL,
     CONSTRAINT  _admission_selon_type_neo_bac_pk PRIMARY KEY (cod_aff_form, session_annee, type_bac)
);

/*Création de la table _type_bac*/
CREATE TABLE _type_bac(
    type_bac  VARCHAR NOT NULL,
     CONSTRAINT  _type_bac_pk PRIMARY KEY(type_bac)
);

/*Création de la table _effectif_selon_mention*/
CREATE TABLE _effectif_selon_mention(
    session_annee INT  NOT NULL,  /*CLE ETRANGERE*/
    libelle_mention  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
    cod_aff_form  VARCHAR NOT NULL,  /*CLE ETRANGERE*/
    effectif_admis_neo_bac_selon_mention INT  NOT NULL,
     CONSTRAINT  _effectif_selon_mention_pk PRIMARY KEY (libelle_mention, cod_aff_form, session_annee)
);

/*Création de la table _mention_bac*/
CREATE TABLE _mention_bac(
    libelle_mention  VARCHAR NOT NULL,
     CONSTRAINT  _mention_bac_pk PRIMARY KEY (libelle_mention)

);


/**************************************************************

Ajout des clés étrangères dans les tables pour la SAE 204

***************************************************************/

/*Ajout de la clé étrangère (region_nom) dans la table _departement*/
ALTER TABLE _departement
    ADD CONSTRAINT  _departement_fk_region
        FOREIGN KEY (region_nom) REFERENCES _region(region_nom);



/*Ajout de la clé étrangère (departement_code) dans la table _commune*/
ALTER TABLE _commune
    ADD CONSTRAINT  _commune_fk_departement
        FOREIGN KEY (departement_code) REFERENCES _departement(departement_code);


/*Ajout de la clé étrangère (etablissement_code_uai) dans la table _formation*/
ALTER TABLE _formation
    ADD CONSTRAINT  _formation_fk_etablissement
        FOREIGN KEY (etablissement_code_uai) REFERENCES _etablissement(etablissement_code_uai);


/*Ajout de la clé étrangère (commune_nom, departement_code) dans la table _formation*/
ALTER TABLE _formation
    ADD CONSTRAINT  _formation_fk_commune
        FOREIGN KEY (commune_nom, departement_code) REFERENCES _commune(commune_nom, departement_code);


/*Ajout de la clé étrangère (academie_nom) dans la table _formation*/
ALTER TABLE _formation
    ADD CONSTRAINT  _formation_fk_academie
        FOREIGN KEY (academie_nom) REFERENCES _academie(academie_nom);


/*Ajout de la clé étrangère (filiere_id) dans la table _formation*/
ALTER TABLE _formation
    ADD CONSTRAINT  _formation_fk_filiere
        FOREIGN KEY (filiere_id) REFERENCES _filiere(filiere_id);


/*Ajout de la clé étrangère (cod_aff_form) dans la table _rang_dernier_appele_selon_regroupement*/
ALTER TABLE _rang_dernier_appele_selon_regroupement
    ADD CONSTRAINT   _rang_dernier_appele_selon_regroupement_fk_formation
        FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form);


/*Ajout de la clé étrangère (libelle_regroupement) dans la table _rang_dernier_appele_selon_regroupement*/
ALTER TABLE _rang_dernier_appele_selon_regroupement
    ADD CONSTRAINT   _rang_dernier_appele_selon_regroupement_fk_regroupement
        FOREIGN KEY (libelle_regroupement) REFERENCES _regroupement(libelle_regroupement);


/*Ajout de la clé étrangère (session_annee) dans la table _rang_dernier_appele_selon_regroupement*/
ALTER TABLE _rang_dernier_appele_selon_regroupement
    ADD CONSTRAINT   _rang_dernier_appele_selon_regroupement_fk_session
        FOREIGN KEY (session_annee) REFERENCES _session(session_annee);


/*Ajout de la clé étrangère (cod_aff_form) dans la table _admissions_generalites*/
ALTER TABLE _admissions_generalites
    ADD CONSTRAINT  _admissions_generalites_fk_formation
        FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form);


/*Ajout de la clé étrangère (session_annee) dans la table _admissions_generalites*/
ALTER TABLE _admissions_generalites
    ADD CONSTRAINT  _admissions_generalites_fk_session
        FOREIGN KEY (session_annee) REFERENCES _session(session_annee);


/*Ajout de la clé étrangère (cod_aff_form) dans la table _admission_selon_type_neo_bac*/
ALTER TABLE _admission_selon_type_neo_bac
    ADD CONSTRAINT  _admission_selon_type_neo_bac_fk_formation
        FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form);


/*Ajout de la clé étrangère (type_bac) dans la table _admission_selon_type_neo_bac*/
ALTER TABLE _admission_selon_type_neo_bac
    ADD CONSTRAINT  _admission_selon_type_neo_bac_fk_type_bac
        FOREIGN KEY (type_bac) REFERENCES _type_bac(type_bac);


/*Ajout de la clé étrangère (session_annee) dans la table _admission_selon_type_neo_bac*/
ALTER TABLE _admission_selon_type_neo_bac
    ADD CONSTRAINT  _admission_selon_type_neo_bac_fk_session
        FOREIGN KEY (session_annee) REFERENCES _session(session_annee);


/*Ajout de la clé étrangère (session_annee) dans la table _effectif_selon_mention*/
ALTER TABLE _effectif_selon_mention
    ADD CONSTRAINT  _effectif_selon_mention_fk_session
        FOREIGN KEY (session_annee) REFERENCES _session(session_annee);


/*Ajout de la clé étrangère (libelle_mention) dans la table _effectif_selon_mention*/
ALTER TABLE _effectif_selon_mention
    ADD CONSTRAINT  _effectif_selon_mention_fk_mention_bac
        FOREIGN KEY (libelle_mention) REFERENCES _mention_bac(libelle_mention);


/*Ajout de la clé étrangère (cod_aff_form) dans la table _effectif_selon_mention*/
ALTER TABLE _effectif_selon_mention
    ADD CONSTRAINT  _effectif_selon_mention_fk_formation
        FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form);