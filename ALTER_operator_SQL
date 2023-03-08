CREATE TABLE empleado(
	id int,
	nombre varchar(30),
	codigo int

);

CREATE TABLE departamento(
	codigo int,
	nombre varchar(30)

);






ALTER TABLE departamento
	ADD CONSTRAINT dep_pk
	PRIMARY KEY(codigo);
	
ALTER TABLE empleado
	ADD CONSTRAINT emp_pk
	PRIMARY KEY(codigo);

ALTER TABLE empleado
	ADD CONSTRAINT emp_dep_fk
	FOREIGN KEY(codigo) REFERENCES departamento(codigo);
	
ALTER TABLE departamento
	ALTER COLUMN nombre SET NOT NULL;

ALTER TABLE empleado
	ADD COLUMN genero char(1) NOT NULL;

ALTER TABLE empleado
	ADD CONSTRAINT emp_chk_gen
	CHECK(genero IN ('F', 'M','B'));
	
INSERT into empleado(id,nombre,genero) VALUES(555,'Juan', '' );
