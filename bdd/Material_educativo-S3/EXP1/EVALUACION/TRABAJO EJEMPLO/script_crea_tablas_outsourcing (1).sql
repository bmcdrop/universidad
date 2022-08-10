DROP TABLE asesoria;
DROP TABLE empresa;
DROP TABLE profesional;
DROP TABLE sector;
DROP TABLE comuna;
DROP TABLE profesion;
DROP TABLE afp;
DROP TABLE isapre;
DROP TABLE porc_asesorias;
DROP TABLE remuneracion_mensual;

--------------------------------------------------------
--  DDL for Table AFP
--------------------------------------------------------
CREATE TABLE afp (
  idafp NUMBER(1,0) NOT NULL,
  nomafp VARCHAR2(20) NOT NULL,
  porc NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_afp PRIMARY KEY (idafp)
);
--------------------------------------------------------
--  DDL for Table ASESORIA
--------------------------------------------------------

CREATE TABLE asesoria (
  rutprof VARCHAR2(10) NOT NULL,
  idempresa NUMBER NOT NULL,  
  inicio DATE NOT NULL, 
  fin DATE NOT NULL,
  CONSTRAINT pk_asesoria PRIMARY KEY (rutprof, idempresa)
);
--------------------------------------------------------
--  DDL for Table COMUNA
--------------------------------------------------------

CREATE TABLE comuna (
  codcomuna NUMBER NOT NULL, 
  nomcomuna VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_comuna PRIMARY KEY (codcomuna)
);
--------------------------------------------------------
--  DDL for Table EMPRESA
--------------------------------------------------------

CREATE TABLE empresa (
  idempresa NUMBER NOT NULL, 
  codcomuna NUMBER NOT NULL, 
  codsector NUMBER NOT NULL, 
  nomempresa VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_empresa PRIMARY KEY (idempresa)
);

--------------------------------------------------------
--  DDL for Table ISAPRE
--------------------------------------------------------

CREATE TABLE isapre (
  idisapre NUMBER(1,0) NOT NULL, 
  nomisapre VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_isapre PRIMARY KEY (idisapre)
);

--------------------------------------------------------
--  DDL for Table PROFESION
--------------------------------------------------------

CREATE TABLE profesion (
  idprofesion NUMBER NOT NULL, 
  nomprofesion VARCHAR2(25) NOT NULL, 
  asignacion NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_profesion PRIMARY KEY (idprofesion)
);

--------------------------------------------------------
--  DDL for Table PROFESIONAL
--------------------------------------------------------

CREATE TABLE profesional (
  rutprof VARCHAR2(10) NOT NULL, 
  idprofesional NUMBER NOT NULL,
  codcomuna NUMBER, 
  idprofesion NUMBER, 
  apppro VARCHAR2(15) NOT NULL, 
  apmpro VARCHAR2(15) NOT NULL, 
  nompro VARCHAR2(20) NOT NULL, 
  ecivper VARCHAR2(15) NOT NULL
    CONSTRAINT ckc_ecivper_profesional CHECK (ecivper IN ('Soltero','Casado','Divorciado','Viudo')), 
  sueldo_base NUMBER(8) NOT NULL, 
  idafp NUMBER(1,0) NOT NULL, 
  idisapre NUMBER(1,0) NOT NULL,
  CONSTRAINT pk_profesional PRIMARY KEY (rutprof)
);

--------------------------------------------------------
--  DDL for Table SECTOR
--------------------------------------------------------

CREATE TABLE sector (
  codsector NUMBER NOT NULL, 
  nomsector VARCHAR2(20) NOT NULL,
  incentivo_sector NUMBER(3) NOT NULL,
  CONSTRAINT pk_sector PRIMARY KEY (codsector)
);

--------------------------------------------------------
--  DDL for Table PORC_ASESORIAS
--------------------------------------------------------

CREATE TABLE porc_asesorias (
  cod_porc_ase NUMBER(3) NOT NULL, 
  cant_inf NUMBER(3) NOT NULL,
  cant_sup NUMBER(3) NOT NULL,
  porc_bonif_ase NUMBER(3) NOT NULL,
  CONSTRAINT pk_porc_asesorias PRIMARY KEY (cod_porc_ase)
);

--------------------------------------------------------
--  DDL for Table REMUNERACION_MENSUAL
--------------------------------------------------------

CREATE TABLE remuneracion_mensual (
  rutprof VARCHAR2(10) NOT NULL, 
  mes_remuneracion NUMBER(4) NOT NULL, 
  anno_remuneracion NUMBER(4) NOT NULL,
  sueldo_base NUMBER(10) NOT NULL, 
  bono_imagen NUMBER(8) NOT NULL,
  bono_asesorias NUMBER(8) NOT NULL,
  bono_colacion NUMBER(8) NOT NULL,
  bono_movilizacion NUMBER(8) NOT NULL,
  bono_profesion NUMBER(8) NOT NULL,
  bono_incentivo NUMBER(8) NOT NULL,
  afp NUMBER(8) NOT NULL,
  isapre NUMBER(8) NOT NULL,
  liquido_a_pagar NUMBER(8) NOT NULL, 
  CONSTRAINT remuneracion_mensual_pk PRIMARY KEY (rutprof, mes_remuneracion, anno_remuneracion)
);

ALTER TABLE empresa
   ADD CONSTRAINT fk_empresa_pertenece_sector FOREIGN KEY (codsector)
      REFERENCES sector (codsector);
      
ALTER TABLE empresa
   ADD CONSTRAINT fk_empresa_ubica_comuna FOREIGN KEY (codcomuna)
      REFERENCES comuna (codcomuna);

ALTER TABLE profesional
   ADD CONSTRAINT fk_profesional_vive_comuna FOREIGN KEY (codcomuna)
      REFERENCES comuna (codcomuna);

ALTER TABLE profesional
   ADD CONSTRAINT fk_profesional_profesion FOREIGN KEY (idprofesion)
      REFERENCES profesion (idprofesion);

ALTER TABLE profesional
   ADD CONSTRAINT fk_afp_profesional FOREIGN KEY (idafp)
      REFERENCES afp (idafp);

ALTER TABLE profesional
   ADD CONSTRAINT fk_isapre_profesional FOREIGN KEY (idisapre)
      REFERENCES isapre (idisapre);

ALTER TABLE asesoria
   ADD CONSTRAINT fk_asesoria_profesional FOREIGN KEY (rutprof)
      REFERENCES profesional (rutprof);

ALTER TABLE asesoria
   ADD CONSTRAINT fk_asesoria_empresa FOREIGN KEY (idempresa)
      REFERENCES empresa (idempresa);

ALTER TABLE remuneracion_mensual 
   ADD CONSTRAINT fk_remuneracion_profesional FOREIGN KEY (rutprof)
      REFERENCES profesional (rutprof);

INSERT INTO afp VALUES (1, 'CAPITAL', 11.44);
INSERT INTO afp VALUES (2, 'CUPRUM',	11.48);   
INSERT INTO afp VALUES (3, 'HABITAT',	11.27); 
INSERT INTO afp VALUES (4, 'MODELO',	10.77); 
INSERT INTO afp VALUES (5, 'PLANVITAL',	12.36);
INSERT INTO afp VALUES (6, 'PROVIDA',	11.54); 

INSERT INTO sector VALUES (1,'Comunicaciones',5);
INSERT INTO sector VALUES (2,'Servicios',7);
INSERT INTO sector VALUES (3,'Banca',9);
INSERT INTO sector VALUES (4,'Retail',10);

INSERT INTO comuna VALUES (80,'Las Condes');
INSERT INTO comuna VALUES (81,'Providencia');
INSERT INTO comuna VALUES (82,'Santiago');
INSERT INTO comuna VALUES (83,'Ñuñoa');
INSERT INTO comuna VALUES (84,'Vitacura');
INSERT INTO comuna VALUES (85,'La Reina');
INSERT INTO comuna VALUES (86,'La Florida');
INSERT INTO comuna VALUES (87,'Maipú');
INSERT INTO comuna VALUES (88,'Lo Barnechea');
INSERT INTO comuna VALUES (89,'Macul');
INSERT INTO comuna VALUES (90,'San Miguel');
INSERT INTO comuna VALUES (91,'Peñalolén');

INSERT INTO empresa VALUES (1,81,4,'Falabella');
INSERT INTO empresa VALUES (2,81,4,'Almacenes Paris');
INSERT INTO empresa VALUES (3,82,3,'Banco Santander');
INSERT INTO empresa VALUES (4,81,3,'Banco Estado');
INSERT INTO empresa VALUES (5,82,2,'Chilectra');
INSERT INTO empresa VALUES (6,82,2,'Aguas Andinas');
INSERT INTO empresa VALUES (7,81,2,'CGE');
INSERT INTO empresa VALUES (8,81,1,'Entel');
INSERT INTO empresa VALUES (9,81,1,'MaleStar');
INSERT INTO empresa VALUES (10,81,1,'Claro');
INSERT INTO empresa VALUES (11,82,4,'Ripley');

INSERT INTO isapre VALUES (1,'Masvida');
INSERT INTO isapre VALUES (2,'Vida Tres');
INSERT INTO isapre VALUES (3,'Banmédica');
INSERT INTO isapre VALUES (4,'Ferrosalud');
INSERT INTO isapre VALUES (5,'Colmena');
INSERT INTO isapre VALUES (6,'Consalud');
INSERT INTO isapre VALUES (7,'Cruz Blanca');

INSERT INTO profesion VALUES (1, 'Contador Auditor', 12.3);
INSERT INTO profesion VALUES (2, 'Contador', 8.0);
INSERT INTO profesion VALUES (3, 'Ingeniero Informático', 14.36);
INSERT INTO profesion VALUES (4, 'Ingeniero Prevencionista', 21.34);
INSERT INTO profesion VALUES (5, 'Ingeniero Comercial', 14.32);
INSERT INTO profesion VALUES (6, 'Ingeniero Industrial', 22.44);

INSERT INTO profesional VALUES ('60579696',1,89,4,'Parsons','Marquez','Rachael','Soltero',550000,4,6);
INSERT INTO profesional VALUES ('69467678',2,83,2,'Walton','Marquez','Melissa','Soltero',1000000,5,1);
INSERT INTO profesional VALUES ('170676427',3,85,3,'Shepard','Carney','Herman','Viudo',340000,5,3);
INSERT INTO profesional VALUES ('206248954',4,80,1,'Lester','Moran','Kisha','Casado',200000,5,3);
INSERT INTO profesional VALUES ('206522999',5,81,2,'Bolton','Choi','Bradford','Divorciado',400000,4,6);
INSERT INTO profesional VALUES ('207184768',6,82,3,'Sweeney','Landry','Stephanie','Casado',600000,4,3);
INSERT INTO profesional VALUES ('208231386',7,83,4,'Morrow','Daniels','Noel','Divorciado',800000,4,4);
INSERT INTO profesional VALUES ('208232220',8,84,5,'Morris','Ware','Devon','Viudo',900000,4,2);
INSERT INTO profesional VALUES ('208993164',9,85,6,'Randall','Bolton','Wanda','Soltero',500000,5,2);
INSERT INTO profesional VALUES ('209300844',10,86,1,'Joyce','Townsend','Hilary','Casado',300000,4,2);
INSERT INTO profesional VALUES ('210435832',11,87,2,'Thornton','Pugh','Shane','Divorciado',2600000,1,2);
INSERT INTO profesional VALUES ('210475308',12,88,3,'Bates','Villegas','Regina','Soltero',1100000,3,5);
INSERT INTO profesional VALUES ('62752020',13,80,5,'Frost','Pineda','Marci','Divorciado',700000,2,5);
INSERT INTO profesional VALUES ('65020661',14,81,6,'Wilcox','Key','Leonard','Soltero',600000,1,1);
INSERT INTO profesional VALUES ('6694138K',15,82,1,'Phelps','Shepherd','Marcie','Divorciado',300000,2,2);

INSERT INTO asesoria VALUES ('60579696',1,'01/07/2017','31/07/2017');
INSERT INTO asesoria VALUES ('60579696',2,'02/07/2017','18/09/2017');
INSERT INTO asesoria VALUES ('60579696',3,'10/07/2017','18/07/2017');
INSERT INTO asesoria VALUES ('60579696',4,'29/01/2017','17/06/2017');
INSERT INTO asesoria VALUES ('60579696',5,'13/02/2017','14/06/2017');
INSERT INTO asesoria VALUES ('60579696',6,'29/07/2017','17/08/2017');
INSERT INTO asesoria VALUES ('60579696',7,'22/05/2017','18/10/2017');
INSERT INTO asesoria VALUES ('60579696',8,'24/07/2017','20/09/2017');
INSERT INTO asesoria VALUES ('60579696',9,'17/02/2017','14/09/2017');
INSERT INTO asesoria VALUES ('60579696',10,'08/03/2017','05/07/2017');
INSERT INTO asesoria VALUES ('60579696',11,'28/07/2017','05/08/2017');
INSERT INTO asesoria VALUES ('69467678',1,'06/05/2017','11/08/2017');
INSERT INTO asesoria VALUES ('69467678',2,'27/03/2017','12/07/2017');
INSERT INTO asesoria VALUES ('69467678',3,'07/07/2017','10/07/2017');
INSERT INTO asesoria VALUES ('69467678',4,'25/03/2017','18/08/2017');
INSERT INTO asesoria VALUES ('69467678',5,'21/07/2017','18/07/2017');
INSERT INTO asesoria VALUES ('69467678',6,'09/07/2017','13/08/2017');
INSERT INTO asesoria VALUES ('69467678',7,'09/06/2017','13/09/2017');
INSERT INTO asesoria VALUES ('69467678',8,'25/06/2017','19/08/2017');
INSERT INTO asesoria VALUES ('69467678',9,'26/07/2017','18/12/2017');
INSERT INTO asesoria VALUES ('69467678',10,'29/07/2017','10/09/2017');
INSERT INTO asesoria VALUES ('69467678',11,'22/02/2017','13/07/2017');
INSERT INTO asesoria VALUES ('170676427',1,'19/07/2017','09/08/2017');
INSERT INTO asesoria VALUES ('170676427',2,'21/07/2017','17/08/2017');
INSERT INTO asesoria VALUES ('170676427',3,'29/07/2017','02/11/2017');
INSERT INTO asesoria VALUES ('170676427',4,'12/02/2017','02/09/2017');
INSERT INTO asesoria VALUES ('206248954',1,'12/07/2017','08/08/2017');
INSERT INTO asesoria VALUES ('206248954',2,'20/07/2017','13/08/2017');
INSERT INTO asesoria VALUES ('206248954',3,'22/06/2017','09/11/2017');
INSERT INTO asesoria VALUES ('206522999',1,'11/07/2017','02/08/2017');
INSERT INTO asesoria VALUES ('206522999',2,'23/07/2017','16/08/2017');
INSERT INTO asesoria VALUES ('206522999',3,'25/07/2017','07/11/2017');
INSERT INTO asesoria VALUES ('206522999',4,'12/02/2017','08/09/2017');
INSERT INTO asesoria VALUES ('207184768',1,'19/06/2017','30/09/2017');
INSERT INTO asesoria VALUES ('207184768',2,'05/06/2017','12/08/2017');
INSERT INTO asesoria VALUES ('207184768',3,'16/09/2017','10/12/2017');
INSERT INTO asesoria VALUES ('207184768',4,'09/07/2017','15/09/2017');
INSERT INTO asesoria VALUES ('208231386',1,'08/05/2017','05/07/2017');
INSERT INTO asesoria VALUES ('208231386',2,'13/07/2017','14/10/2017');
INSERT INTO asesoria VALUES ('208231386',3,'02/06/2017','18/09/2017');
INSERT INTO asesoria VALUES ('208231386',4,'29/05/2017','17/08/2017');
INSERT INTO asesoria VALUES ('208231386',5,'22/07/2017','18/10/2017');
INSERT INTO asesoria VALUES ('208231386',6,'28/07/2017','05/09/2017');
INSERT INTO asesoria VALUES ('208232220',1,'12/07/2017','07/08/2017');
INSERT INTO asesoria VALUES ('208232220',2,'22/07/2017','14/08/2017');
INSERT INTO asesoria VALUES ('208232220',3,'22/04/2017','08/11/2017');
INSERT INTO asesoria VALUES ('208232220',4,'13/02/2017','09/09/2017');
INSERT INTO asesoria VALUES ('208993164',1,'05/07/2017','12/10/2017');
INSERT INTO asesoria VALUES ('208993164',2,'16/07/2017','10/11/2017');
INSERT INTO asesoria VALUES ('208993164',3,'09/07/2017','15/08/2017');
INSERT INTO asesoria VALUES ('208993164',4,'08/05/2017','05/09/2017');
INSERT INTO asesoria VALUES ('208993164',5,'13/01/2017','14/11/2017');
INSERT INTO asesoria VALUES ('208993164',6,'02/07/2017','18/07/2017');
INSERT INTO asesoria VALUES ('208993164',7,'29/07/2017','17/08/2017');
INSERT INTO asesoria VALUES ('209300844',1,'23/03/2017','16/08/2017');
INSERT INTO asesoria VALUES ('209300844',2,'25/07/2017','07/11/2017');
INSERT INTO asesoria VALUES ('209300844',3,'12/01/2017','08/09/2017');
INSERT INTO asesoria VALUES ('209300844',4,'19/08/2017','30/09/2017');
INSERT INTO asesoria VALUES ('209300844',5,'05/02/2017','12/08/2017');
INSERT INTO asesoria VALUES ('209300844',6,'16/07/2017','10/12/2017');
INSERT INTO asesoria VALUES ('210435832',1,'19/07/2017','09/08/2017');
INSERT INTO asesoria VALUES ('210435832',2,'21/07/2017','17/08/2017');
INSERT INTO asesoria VALUES ('210435832',3,'29/07/2017','02/11/2017');
INSERT INTO asesoria VALUES ('210435832',4,'12/07/2017','02/09/2017');
INSERT INTO asesoria VALUES ('210435832',5,'12/05/2017','08/08/2017');
INSERT INTO asesoria VALUES ('210435832',6,'20/07/2017','13/08/2017');
INSERT INTO asesoria VALUES ('210435832',7,'22/07/2017','09/11/2017');
INSERT INTO asesoria VALUES ('210475308',9,'12/07/2017','08/08/2017');
INSERT INTO asesoria VALUES ('210475308',8,'20/07/2017','13/08/2017');
INSERT INTO asesoria VALUES ('210475308',7,'22/07/2017','09/11/2017');
INSERT INTO asesoria VALUES ('62752020',8,'11/07/2017','02/08/2017');
INSERT INTO asesoria VALUES ('62752020',4,'23/07/2017','16/08/2017');
INSERT INTO asesoria VALUES ('62752020',3,'25/07/2017','07/11/2017');
INSERT INTO asesoria VALUES ('62752020',7,'12/07/2017','08/09/2017');
INSERT INTO asesoria VALUES ('65020661',3,'25/07/2017','07/11/2017');
INSERT INTO asesoria VALUES ('65020661',4,'12/07/2017','08/09/2017');
INSERT INTO asesoria VALUES ('6694138K',1,'25/07/2017','07/11/2017');
INSERT INTO asesoria VALUES ('6694138K',3,'12/07/2017','08/09/2017');

INSERT INTO porc_asesorias VALUES (1,1,10,2);
INSERT INTO porc_asesorias VALUES (2,11,20,3);
INSERT INTO porc_asesorias VALUES (3,21,30,5);
INSERT INTO porc_asesorias VALUES (4,31,50,7);

COMMIT;