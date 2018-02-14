/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  14/02/2018 11:23:53                      */
/*==============================================================*/


drop table if exists ACHATTICKET;

drop table if exists AFFECTION;

drop table if exists AGENTACCUEIL;

drop table if exists ALIMENT;

drop table if exists ANIMAL;

drop table if exists ATELIER;

drop table if exists COMPOSEDE;

drop table if exists COMPREND;

drop table if exists CONTIENT;

drop table if exists CORRESPOND;

drop table if exists DISTRIBUE;

drop table if exists EFFECTUE;

drop table if exists EMPLOYE;

drop table if exists ENTREE_CLASSIQUE;

drop table if exists ESPACE;

drop table if exists ESPACESPECTACLE;

drop table if exists ESPECE;

drop table if exists ESTLEPREDATEURDE;

drop table if exists EST_ASSOCIE_A;

drop table if exists FOURNISSEUR;

drop table if exists GROUPEPETITSANIMAUX;

drop table if exists LOTALIMENT;

drop table if exists LOTMEDICAMENT;

drop table if exists MEDICAMENT;

drop table if exists MENUALIMENTAIRE;

drop table if exists PARENTDE;

drop table if exists PLACEDANS;

drop table if exists RECOIT;

drop table if exists SOIGNEUR;

drop table if exists SOINS;

drop table if exists SPECTACLE;

drop table if exists STOCKAGE;

drop table if exists TARIF_TICKET;

drop table if exists VETERINAIRE;

drop table if exists VISITEUR;

drop table if exists ZONEZOO;

/*==============================================================*/
/* Table : ACHATTICKET  N                                        */
/*==============================================================*/
create table ACHATTICKET
(
   NUMERO_ACHAT          varchar(30) not null,
   CODE_VISITEUR         varchar(30) not null,
   NUM_EMPLOYE          varchar(30) not null,
   DATE_ACHAT            date,
   DATE_VISITE           date,
   primary key (NUMEROACHAT)
);

/*==============================================================*/
/* Table : AFFECTION  N                                          */
/*==============================================================*/
create table AFFECTION
(
   CODEAFFECTION        varchar(30) not null,
   LIBELLEAFFECTION     varchar(100),
   primary key (CODEAFFECTION)
);

/*==============================================================*/
/* Table : AGENTACCUEIL  N à vérifier                                     */
/*==============================================================*/
create table AGENTACCUEIL
(
   
   NUM_EMPLOYE          varchar(30) not null,
   NUMAGENTACCEUIL     varchar(30) 
   NOMEMPLOYE           varchar(30),
   PRENOMEMPLOYE        varchar(30),
   TELEPHONEEMPLOYE     numeric(10,0),
   ADRESSEMAILEMPLOYE   varchar(30),
   
   primary key (NUM_EMPLOYE)
);

/*==============================================================*/
/* Table : ALIMENT N                                            */
/*==============================================================*/
create table ALIMENT
(
   CODEALIMENT          varchar(30) not null,
   NOMALIMENT           varchar(30),
   TYPEALIMENT          char(30),
   TEMPERATURECONSERVATIONALIMENT numeric(8,0),
   
   primary key (CODEALIMENT)
);

/*==============================================================*/
/* Table : ANIMAL                                               */
/*==============================================================*/
create table ANIMAL
(
   NUMANIMAL            varchar(30) not null,
   CODEESPECE           varchar(30) not null,
   CODEGROUPE           numeric(10,0),
   NOMANIMAL        varchar(30),
   DATENAISSANCEANIMAL  datetime,
   DATEARRIVEEANIMAL    date,
   POIDSANIMALKG          numeric(8,0),
   SEXEANIMAL           char(10),
   PROVENANCEANIMAL     varchar(30),
   DATEDECESANIMAL      datetime,
   APTE                 bool,
   COMMENTAIREANIMAL    longtext,
   primary key (NUMANIMAL)
);

/*==============================================================*/
/* Table : ATELIER                                              */
/*==============================================================*/
create table ATELIER
(
   CODE_ATELIER         varchar(30) not null,
   NOM_ATELIER          varchar(50),
   PRIX_ATELIER         numeric(8,0),
   CAPACITEMAXATELIER   numeric(8,0),
   DATEDEBUTATELIER     datetime,
   DATEFINATELIER       datetime,
   primary key (CODE_ATELIER)
);

/*==============================================================*/
/* Table : COMPOSEDE                                            */
/*==============================================================*/
create table COMPOSEDE
(
   CODEMENUALIMENTAIRE  varchar(30) not null,
   CODEALIMENT          varchar(30) not null,
   POURCENTAGEALIMENT1  numeric(8,0),
   POURCENTAGEALIMENT2  numeric(8,0),
   POURCENTAGEALIMENT3  numeric(8,0),
   primary key (CODEMENUALIMENTAIRE, CODEALIMENT)
);

/*==============================================================*/
/* Table : COMPREND                                             */
/*==============================================================*/
create table COMPREND
(
   CODESOIN             varchar(30) not null,
   CODEMEDICAMENT       varchar(30) not null,
   QUANTITEMEDICAMENT   numeric(8,0),
   primary key (CODESOIN, CODEMEDICAMENT)
);

/*==============================================================*/
/* Table : CONTIENT                                             */
/*==============================================================*/
create table CONTIENT
(
   NUMEROACHAT          varchar(30) not null,
   CODE_ATELIER         varchar(30) not null,
   primary key (NUMEROACHAT, CODE_ATELIER)
);

/*==============================================================*/
/* Table : CORRESPOND                                           */
/*==============================================================*/
create table CORRESPOND
(
   CODE_TARIF_TICKET    varchar(30) not null,
   NUMEROACHAT          varchar(30) not null,
   primary key (CODE_TARIF_TICKET, NUMEROACHAT)
);

/*==============================================================*/
/* Table : DISTRIBUE                                            */
/*==============================================================*/
create table DISTRIBUE
(
   NUM_EMPLOYE          varchar(30) not null,
   CODEMENUALIMENTAIRE  varchar(30) not null,
   NUMESPACE            numeric(8,0) not null,
   QUANTITEKGDISTRIBUEE numeric(8,0),
   DATEDISTRIBUTION     datetime,
   primary key (NUM_EMPLOYE, CODEMENUALIMENTAIRE, NUMESPACE)
);

/*==============================================================*/
/* Table : EFFECTUE                                             */
/*==============================================================*/
create table EFFECTUE
(
   NUM_EMPLOYE          varchar(30) not null,
   CODESOIN             varchar(30) not null,
   DATEDEBUTSUIVI       datetime,
   DATEFINSUIVI         datetime,
   primary key (NUM_EMPLOYE, CODESOIN)
);

/*==============================================================*/
/* Table : EMPLOYE                                              */
/*==============================================================*/
create table EMPLOYE
(
   NUM_EMPLOYE          varchar(30) not null,
   NOMEMPLOYE           varchar(30),
   PRENOMEMPLOYE        varchar(30),
   TELEPHONEEMPLOYE     numeric(10,0),
   ADRESSEMAILEMPLOYE   varchar(30),
   DATEEMBAUCHEEMPLOYE  date,
   primary key (NUM_EMPLOYE)
);

/*==============================================================*/
/* Table : ENTREE_CLASSIQUE                                     */
/*==============================================================*/
create table ENTREE_CLASSIQUE
(
   CODEENTREE           varchar(30) not null,
   NUMEROACHAT          varchar(30) not null,
   PRIXENTREECLASSIQUE  numeric(10,0),
   primary key (CODEENTREE)
);

/*==============================================================*/
/* Table : ESPACE                                               */
/*==============================================================*/
create table ESPACE
(
   NUMESPACE            numeric(8,0) not null,
   NUMZONE              numeric(8,0) not null,
   LIBELLEESPACE        varchar(30),
   TYPEESPACE           varchar(30),
   TAILLEESPACEM_       numeric(8,0),
   TEMPERATUREMINIMUMESPACE numeric(8,0),
   TEMPERATUREMAXIMUMESPACE numeric(8,0),
   TAUXHUMIDITEESPACE   numeric(8,0),
   LOCALISATIONESPACE   varchar(5),
   SURCAPACITE          bool,
   primary key (NUMESPACE)
);

/*==============================================================*/
/* Table : ESPACESPECTACLE                                      */
/*==============================================================*/
create table ESPACESPECTACLE
(
   CODEESPACESPECTACLE  varchar(30) not null,
   NUMZONE              numeric(8,0) not null,
   CAPACITEMAXESPACE    numeric(10,0),
   TYPEESPACESPECTACLE  varchar(30),
   primary key (CODEESPACESPECTACLE)
);

/*==============================================================*/
/* Table : ESPECE                                               */
/*==============================================================*/
create table ESPECE
(
   CODEESPECE           varchar(30) not null,
   CODEMENUALIMENTAIRE  varchar(30) not null,
   LIBELLEESPECE        longtext,
   DESCRIPTIONESPECE    longtext,
   MILIEUDEVIE          varchar(30),
   ESPACEMINDEVIE       numeric(8,0),
   TEMPERATUREMINESPECE numeric(8,0),
   TEMPERATUREMAXESPECE numeric(8,0),
   TAUXHUMIDITEESPECE   numeric(8,0),
   INSCRIPTIONPROGRAMMECONSERVATION bool,
   primary key (CODEESPECE)
);

/*==============================================================*/
/* Table : ESTLEPREDATEURDE                                     */
/*==============================================================*/
create table ESTLEPREDATEURDE
(
   CODEESPECE           varchar(30) not null,
   ESP_CODEESPECE       varchar(30) not null,
   primary key (CODEESPECE, ESP_CODEESPECE)
);

/*==============================================================*/
/* Table : EST_ASSOCIE_A                                        */
/*==============================================================*/
create table EST_ASSOCIE_A
(
   CODEENTREE           varchar(30) not null,
   CODESPECTACLE        varchar(30) not null,
   primary key (CODEENTREE, CODESPECTACLE)
);

/*==============================================================*/
/* Table : FOURNISSEUR                                          */
/*==============================================================*/
create table FOURNISSEUR
(
   SIRET_DUNSFOURNISSEUR varchar(14) not null,
   NOMFOURNISSEUR       varchar(30),
   TYPEMARCHANDISEFOURNISSEUR varchar(30),
   ADRESSEFOURNISSEUR   longtext,
   PAYSFOURNISSEUR      longtext,
   TELFOURNISSEUR       numeric(30,0),
   primary key (SIRET_DUNSFOURNISSEUR)
);

/*==============================================================*/
/* Table : GROUPEPETITSANIMAUX                                  */
/*==============================================================*/
create table GROUPEPETITSANIMAUX
(
   CODEGROUPE           numeric(10,0) not null,
   POIDSGLOBALGROUPE    numeric(8,0),
   DATEDEBUTGROUPE      date,
   DATEFINGROUPE        date,
   POIDSMAXANIMAUXGROUPE numeric(10,0),
   primary key (CODEGROUPE)
);

/*==============================================================*/
/* Table : LOTALIMENT                                           */
/*==============================================================*/
create table LOTALIMENT
(
   NUMLOTALIMENT        numeric(8,0) not null,
   CODEALIMENT          varchar(30) not null,
   SIRET_DUNSFOURNISSEUR varchar(14) not null,
   CODESTOCKAGE         varchar(30) not null,
   QUANTITEALIMENTLOT   numeric(8,0),
   DATEPEREMPTIONLOT    date,
   DATEACHATLOTALIMENT  datetime,
   DATEENTREEALIMENTSTOCKAGE datetime,
   DATESORTIEALIMENTSTOCKAGE datetime,
   COUTALIMENTAUKILOS   numeric(8,0),
   primary key (NUMLOTALIMENT)
);

/*==============================================================*/
/* Table : LOTMEDICAMENT                                        */
/*==============================================================*/
create table LOTMEDICAMENT
(
   NUMLOTMEDICAMENT     numeric(8,0) not null,
   CODEMEDICAMENT       varchar(30) not null,
   CODESTOCKAGE         varchar(30) not null,
   SIRET_DUNSFOURNISSEUR varchar(14) not null,
   QUANTITEMEDICAMENTDULOT numeric(8,0),
   DATEPEREMPTIONLOTMEDICAMENT date,
   PRIXACHATLOTMEDICAMENT numeric(8,0),
   DATEENTREEMEDICAMENTSTOCKAGE datetime,
   DATESORTIEMEDICAMENTSTOCKAGE datetime,
   primary key (NUMLOTMEDICAMENT)
);

/*==============================================================*/
/* Table : MEDICAMENT                                           */
/*==============================================================*/
create table MEDICAMENT
(
   CODEMEDICAMENT       varchar(30) not null,
   LIBELLEMEDICAMENT    varchar(30),
   TEMPERATURECONSERVATIONMEDICAMENT numeric(8,0),
   TYPEMEDICAMENT       varchar(30),
   DUREEEFFETMEDICAMENT time,
   CONTRE_INDICATIONMEDICAMENT longtext,
   FREQUENCEJOURPRISEMEDICAMENT numeric(8,0),
   primary key (CODEMEDICAMENT)
);

/*==============================================================*/
/* Table : MENUALIMENTAIRE                                      */
/*==============================================================*/
create table MENUALIMENTAIRE
(
   CODEMENUALIMENTAIRE  varchar(30) not null,
   LIBELLEMENUALIMENTAIRE varchar(30),
   TYPEMENUALIMENTAIRE  varchar(30),
   QUANTITEKGRECOMMANDEEPARKG numeric(8,0),
   primary key (CODEMENUALIMENTAIRE)
);

/*==============================================================*/
/* Table : PARENTDE                                             */
/*==============================================================*/
create table PARENTDE
(
   NUMANIMAL            varchar(30) not null,
   ANI_NUMANIMAL        varchar(30) not null,
   primary key (NUMANIMAL, ANI_NUMANIMAL)
);

/*==============================================================*/
/* Table : PLACEDANS                                            */
/*==============================================================*/
create table PLACEDANS
(
   NUMESPACE            numeric(8,0) not null,
   NUMANIMAL            varchar(30) not null,
   DATEDEBUTPLACEMENT   datetime,
   DATEFINPLACEMENT     datetime,
   primary key (NUMESPACE, NUMANIMAL)
);

/*==============================================================*/
/* Table : RECOIT                                               */
/*==============================================================*/
create table RECOIT
(
   CODESOIN             varchar(30) not null,
   NUMANIMAL            varchar(30) not null,
   DATEDEBUTSOIN        datetime,
   DATEFINSOIN          datetime,
   QUANTITESOIN         numeric(8,0),
   primary key (CODESOIN, NUMANIMAL)
);

/*==============================================================*/
/* Table : SOIGNEUR                                             */
/*==============================================================*/
create table SOIGNEUR
(
   NUM_EMPLOYE          varchar(30) not null,
   NOMEMPLOYE           varchar(30),
   PRENOMEMPLOYE        varchar(30),
   TELEPHONEEMPLOYE     numeric(10,0),
   ADRESSEMAILEMPLOYE   varchar(30),
   DATEEMBAUCHEEMPLOYE  date,
   CODESOIGNEUR         varchar(30),
   primary key (NUM_EMPLOYE)
);

/*==============================================================*/
/* Table : SOINS                                                */
/*==============================================================*/
create table SOINS
(
   CODESOIN             varchar(30) not null,
   CODEAFFECTION        varchar(30) not null,
   LIBELLESOIN          longtext,
   TYPESOIN             varchar(30),
   RECOMMANDATIONSOIN   longtext,
   primary key (CODESOIN)
);

/*==============================================================*/
/* Table : SPECTACLE                                            */
/*==============================================================*/
create table SPECTACLE
(
   CODESPECTACLE        varchar(30) not null,
   CODEESPACESPECTACLE  varchar(30) not null,
   NOMSPECTACLE         varchar(50),
   HEUREDEBUTSPECTACLE  datetime,
   HEUREFINSPECTACLE    datetime,
   primary key (CODESPECTACLE)
);

/*==============================================================*/
/* Table : STOCKAGE                                             */
/*==============================================================*/
create table STOCKAGE
(
   CODESTOCKAGE         varchar(30) not null,
   TYPESTOCKAGE         varchar(30),
   TEMPERATURESTOCKAGE  numeric(10,0),
   LOCALISATIONSTOCKAGE varchar(30),
   primary key (CODESTOCKAGE)
);

/*==============================================================*/
/* Table : TARIF_TICKET                                         */
/*==============================================================*/
create table TARIF_TICKET
(
   CODE_TARIF_TICKET    varchar(30) not null,
   LIBELLE_TARIF_TICKET varchar(30),
   RATIOTARIFTICKET     float,
   primary key (CODE_TARIF_TICKET)
);

/*==============================================================*/
/* Table : VETERINAIRE                                          */
/*==============================================================*/
create table VETERINAIRE
(
   NUM_EMPLOYE          varchar(30) not null,
   NOMEMPLOYE           varchar(30),
   PRENOMEMPLOYE        varchar(30),
   TELEPHONEEMPLOYE     numeric(10,0),
   ADRESSEMAILEMPLOYE   varchar(30),
   DATEEMBAUCHEEMPLOYE  date,
   CODEORDINALVETERINAIRE numeric(8,0),
   SPECIALISATIONVETERINAIRE longtext,
   PROVENANCEVETERINAIRE varchar(30),
   primary key (NUM_EMPLOYE)
);

/*==============================================================*/
/* Table : VISITEUR                                             */
/*==============================================================*/
create table VISITEUR
(
   CODEVISITEUR         varchar(30) not null,
   CATEGORIEVISITEUR    varchar(30),
   GENREVISITEUR        char(6),
   AGEVISITEUR          numeric(3,0),
   CODEPOSTALVISITEUR   numeric(8,0),
   ADRESSEMAILVISITEUR  longtext,
   primary key (CODEVISITEUR)
);

/*==============================================================*/
/* Table : ZONEZOO                                              */
/*==============================================================*/
create table ZONEZOO
(
   NUMZONE              numeric(8,0) not null,
   LIBELLEZONE          longtext,
   CARACTERISTIQUESZONE longtext,
   LOCALISATIONZONE     varchar(30),
   primary key (NUMZONE)
);

alter table ACHATTICKET add constraint FK_PASSE foreign key (CODEVISITEUR)
      references VISITEUR (CODEVISITEUR) on delete restrict on update restrict;

alter table ACHATTICKET add constraint FK_REALISE foreign key (NUM_EMPLOYE)
      references AGENTACCUEIL (NUM_EMPLOYE) on delete restrict on update restrict;

alter table AGENTACCUEIL add constraint FK_HERITAGE_2 foreign key (NUM_EMPLOYE)
      references EMPLOYE (NUM_EMPLOYE) on delete restrict on update restrict;

alter table ANIMAL add constraint FK_APPARTIENT foreign key (CODEGROUPE)
      references GROUPEPETITSANIMAUX (CODEGROUPE) on delete restrict on update restrict;

alter table ANIMAL add constraint FK_ASSOCIEA foreign key (CODEESPECE)
      references ESPECE (CODEESPECE) on delete restrict on update restrict;

alter table COMPOSEDE add constraint FK_COMPOSEDE foreign key (CODEALIMENT)
      references ALIMENT (CODEALIMENT) on delete restrict on update restrict;

alter table COMPOSEDE add constraint FK_COMPOSEDE2 foreign key (CODEMENUALIMENTAIRE)
      references MENUALIMENTAIRE (CODEMENUALIMENTAIRE) on delete restrict on update restrict;

alter table COMPREND add constraint FK_COMPREND foreign key (CODEMEDICAMENT)
      references MEDICAMENT (CODEMEDICAMENT) on delete restrict on update restrict;

alter table COMPREND add constraint FK_COMPREND2 foreign key (CODESOIN)
      references SOINS (CODESOIN) on delete restrict on update restrict;

alter table CONTIENT add constraint FK_CONTIENT foreign key (CODE_ATELIER)
      references ATELIER (CODE_ATELIER) on delete restrict on update restrict;

alter table CONTIENT add constraint FK_CONTIENT2 foreign key (NUMEROACHAT)
      references ACHATTICKET (NUMEROACHAT) on delete restrict on update restrict;

alter table CORRESPOND add constraint FK_CORRESPOND foreign key (NUMEROACHAT)
      references ACHATTICKET (NUMEROACHAT) on delete restrict on update restrict;

alter table CORRESPOND add constraint FK_CORRESPOND2 foreign key (CODE_TARIF_TICKET)
      references TARIF_TICKET (CODE_TARIF_TICKET) on delete restrict on update restrict;

alter table DISTRIBUE add constraint FK_DISTRIBUE foreign key (NUMESPACE)
      references ESPACE (NUMESPACE) on delete restrict on update restrict;

alter table DISTRIBUE add constraint FK_DISTRIBUE2 foreign key (CODEMENUALIMENTAIRE)
      references MENUALIMENTAIRE (CODEMENUALIMENTAIRE) on delete restrict on update restrict;

alter table DISTRIBUE add constraint FK_DISTRIBUE3 foreign key (NUM_EMPLOYE)
      references SOIGNEUR (NUM_EMPLOYE) on delete restrict on update restrict;

alter table EFFECTUE add constraint FK_EFFECTUE foreign key (CODESOIN)
      references SOINS (CODESOIN) on delete restrict on update restrict;

alter table EFFECTUE add constraint FK_EFFECTUE2 foreign key (NUM_EMPLOYE)
      references VETERINAIRE (NUM_EMPLOYE) on delete restrict on update restrict;

alter table ENTREE_CLASSIQUE add constraint FK_CONCERNE foreign key (NUMEROACHAT)
      references ACHATTICKET (NUMEROACHAT) on delete restrict on update restrict;

alter table ESPACE add constraint FK_COMPRISDANS foreign key (NUMZONE)
      references ZONEZOO (NUMZONE) on delete restrict on update restrict;

alter table ESPACESPECTACLE add constraint FK_SE_SITUE foreign key (NUMZONE)
      references ZONEZOO (NUMZONE) on delete restrict on update restrict;

alter table ESPECE add constraint FK_POSSEDE foreign key (CODEMENUALIMENTAIRE)
      references MENUALIMENTAIRE (CODEMENUALIMENTAIRE) on delete restrict on update restrict;

alter table ESTLEPREDATEURDE add constraint FK_ESTLEPREDATEURDE foreign key (ESP_CODEESPECE)
      references ESPECE (CODEESPECE) on delete restrict on update restrict;

alter table ESTLEPREDATEURDE add constraint FK_ESTLEPREDATEURDE2 foreign key (CODEESPECE)
      references ESPECE (CODEESPECE) on delete restrict on update restrict;

alter table EST_ASSOCIE_A add constraint FK_EST_ASSOCIE_A foreign key (CODESPECTACLE)
      references SPECTACLE (CODESPECTACLE) on delete restrict on update restrict;

alter table EST_ASSOCIE_A add constraint FK_EST_ASSOCIE_A2 foreign key (CODEENTREE)
      references ENTREE_CLASSIQUE (CODEENTREE) on delete restrict on update restrict;

alter table LOTALIMENT add constraint FK_CONSERVEDANS foreign key (CODESTOCKAGE)
      references STOCKAGE (CODESTOCKAGE) on delete restrict on update restrict;

alter table LOTALIMENT add constraint FK_FOURNIPAR foreign key (SIRET_DUNSFOURNISSEUR)
      references FOURNISSEUR (SIRET_DUNSFOURNISSEUR) on delete restrict on update restrict;

alter table LOTALIMENT add constraint FK_PROVIENTDE foreign key (CODEALIMENT)
      references ALIMENT (CODEALIMENT) on delete restrict on update restrict;

alter table LOTMEDICAMENT add constraint FK_ACHETEA foreign key (SIRET_DUNSFOURNISSEUR)
      references FOURNISSEUR (SIRET_DUNSFOURNISSEUR) on delete restrict on update restrict;

alter table LOTMEDICAMENT add constraint FK_ACHETEEN foreign key (CODEMEDICAMENT)
      references MEDICAMENT (CODEMEDICAMENT) on delete restrict on update restrict;

alter table LOTMEDICAMENT add constraint FK_STOCKEDANS foreign key (CODESTOCKAGE)
      references STOCKAGE (CODESTOCKAGE) on delete restrict on update restrict;

alter table PARENTDE add constraint FK_ENFANT foreign key (NUMANIMAL)
      references ANIMAL (NUMANIMAL) on delete restrict on update restrict;

alter table PARENTDE add constraint FK_PARENT foreign key (ANI_NUMANIMAL)
      references ANIMAL (NUMANIMAL) on delete restrict on update restrict;

alter table PLACEDANS add constraint FK_PLACEDANS foreign key (NUMANIMAL)
      references ANIMAL (NUMANIMAL) on delete restrict on update restrict;

alter table PLACEDANS add constraint FK_PLACEDANS2 foreign key (NUMESPACE)
      references ESPACE (NUMESPACE) on delete restrict on update restrict;

alter table RECOIT add constraint FK_RECOIT foreign key (NUMANIMAL)
      references ANIMAL (NUMANIMAL) on delete restrict on update restrict;

alter table RECOIT add constraint FK_RECOIT2 foreign key (CODESOIN)
      references SOINS (CODESOIN) on delete restrict on update restrict;

alter table SOIGNEUR add constraint FK_HERITAGE_1 foreign key (NUM_EMPLOYE)
      references EMPLOYE (NUM_EMPLOYE) on delete restrict on update restrict;

alter table SOINS add constraint FK_SOIGNE foreign key (CODEAFFECTION)
      references AFFECTION (CODEAFFECTION) on delete restrict on update restrict;

alter table SPECTACLE add constraint FK_ALIEUDANS foreign key (CODEESPACESPECTACLE)
      references ESPACESPECTACLE (CODEESPACESPECTACLE) on delete restrict on update restrict;

alter table VETERINAIRE add constraint FK_HERITAGE_3 foreign key (NUM_EMPLOYE)
      references EMPLOYE (NUM_EMPLOYE) on delete restrict on update restrict;

