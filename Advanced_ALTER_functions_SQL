


ALTER TABLE estudiante
	ADD CONSTRAINT est_uq
		UNIQUE (id,nombre);

ALTER TABLE estudiante
	ADD CONSTRAINT est_fecha_uq
		UNIQUE (nombre, fecha_nto);
		
		
INSERT into estudiante VALUES(23,'pedrocraft','2003-03-04');


--INVENTAR TIPOS DE DATOS

CREATE TYPE status AS ENUM
	('Activo', 'Inactivo');

ALTER TABLE estudiante
	ADD COLUMN estado status;

ALTER TABLE estudiante
	ALTER COLUMN estado SET DEFAULT 'Activo';

INSERT into estudiante VALUES(1,'owo','2003-03-04');

SELECT * FROM estudiante;

ALTER TABLE estudiante
	DROP CONSTRAINT est_uq;

--DOMINIO

CREATE DOMAIN no_espacios
	AS varchar NOT NULL CHECK(value !~ '\s');
	

ALTER TABLE estudiante
	ALTER COLUMN nombre TYPE no_espacios;

--Contadores autonúmericos

ALTER TABLE estudiante
	ADD COLUMN contador serial;

CREATE sequence est_con2_seq
	INCREMENT BY 2
	MINVALUE 10 MAXVALUE 20
	START 10 CYCLE;

ALTER TABLE estudiante
	ALTER COLUMN contador_2 SET DEFAULT next_val('est_con2_seq'::regclass);

SELECT contador_2 FROM estudiante;
