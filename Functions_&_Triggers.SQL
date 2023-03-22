----CREATE PROCEDURE SQL-----
CREATE FUNCTION suma2(int,int)	
	RETURNS int
	AS 'SELECT $1 + $2;'
	LANGUAGE SQL;

SELECT suma2(100,700);

--CREATE PROCEDURE PL/SQL-----
CREATE FUNCTION suma(i int, j int)	
	RETURNS int
	AS $$
	BEGIN
		RETURN i+j;
	END
	$$
	LANGUAGE plpgsql;



CREATE TABLE empleado_2(
	id int not null,
	nombre varchar(30) not null,
	cargo varchar(30) not null,
	salario real not null,
	PRIMARY KEY(id)

);

INSERT INTO empleado_2(id,nombre,cargo,salario)
VALUES
(1020, 'juan Rodriguez', 'Asesor',3500000),
(1030, 'Diana', 'Jefe', 2500000),
(1040, 'Jorge', 'Jefe de Finanzas', 4500000),
(1050, 'Sol', 'Jefe de Recursos Humanos',3500000);

---Procedimientos-----
CREATE FUNCTION sumas(i int, j int)
RETURNS int
AS $$
BEGIN
	return i + j;

END;
$$
LANGUAGE plpgsql;

SELECT sumas(100,500);

SELECT sumas(
	(SELECT salario :: int
	FROM empleado_2
	WHERE id = 1040),100000
	);

---------------------------------
CREATE FUNCTION listar_empleados()
RETURNS SETOF empleado_2
AS
'SELECT * FROM empleado_2;'
LANGUAGE SQL;

SELECT listar_empleados();
------------------------------------

CREATE FUNCTION obtener_empleados()
RETURNS SETOF empleado_2
AS
$$
DECLARE 
	e empleado_2;
BEGIN
	FOR e IN SELECT * FROM empleado_2 LOOP
		return next e;
	END LOOP;

END;
$$
LANGUAGE plpgsql;

SELECT obtener_empleados();

----Procedimientos sobre caracteres---
CREATE FUNCTION nombre_empleados()
RETURNS SETOF varchar
AS
$$
DECLARE
	e varchar;
BEGIN
	FOR e IN SELECT nombre FROM empleado_2 LOOP
		return next e;
	END LOOP;

END
$$
LANGUAGE plpgsql;
		

SELECT nombre_empleados();
SELECT split_part(nombre_empleados()::text, ' ',1) as nombre,
		split_part(nombre_empleados()::text, ' ',2) as apellido;

SELECT id, split_part(nombre::text, ' ',1) as nombre,
		split_part(nombre::text, ' ',2) as apellido,
		cargo,salario
		
FROM empleado_2;

CREATE TABLE empleado_nuevo
AS

SELECT id, split_part(nombre::text, ' ',1) as nombre,
		split_part(nombre::text, ' ',2) as apellido,
		cargo,salario
		
FROM empleado_2;


----Triggers-------

CREATE TABLE empleado_antiguo(
	id int not null,
	nombre varchar(30) not null,
	cargo varchar(30) not null,
	salario real not null,
	PRIMARY KEY(id)

);

SELECT * FROM empleado_antiguo;

CREATE FUNCTION emp_antiguo()
RETURNS trigger
AS
$$
BEGIN
	INSERT into empleado_antiguo VALUES(OLD.id, OLD.nombre, OLD.cargo, OLD.salario);
	RETURN OLD;
	
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER emp_antiguo_tr
	AFTER DELETE 
	ON empleado_2
	FOR EACH ROW
	EXECUTE FUNCTION emp_antiguo();

DELETE FROM empleado_2 
WHERE id = 1040;

SELECT * FROM empleado_antiguo;

---empleado antiguo con fecha exacta de su retiro---
ALTER TABLE empleado_antiguo
	ADD COLUMN fecha_hora timestamp;

ALTER TABLE empleado_antiguo
	ADD COLUMN usuario varchar(30);

CREATE OR REPLACE FUNCTION emp_antiguo()
RETURNS trigger
AS
$$
BEGIN
	INSERT into empleado_antiguo VALUES(OLD.id, OLD.nombre, OLD.cargo, OLD.salario, now(), user);
	RETURN OLD;
	
END;
$$
LANGUAGE plpgsql;
	
DELETE from empleado_2 WHERE id = 1030;
SELECT * FROM empleado_antiguo;
SELECT * FROM empleado_2;


CREATE OR REPLACE FUNCTION emp_id(i int)
RETURNS varchar
AS 
$$
	DECLARE
		nombre_n varchar;
	BEGIN
		SELECT e.nombre INTO nombre_n
		FROM empleado_2 e
		WHERE e.id = i;
		RETURN nombre_n;

	END;
$$
LANGUAGE plpgsql;

SELECT emp_id(1060);

CREATE OR REPLACE FUNCTION ver_empleados_for
RETURNS void
AS
$$
DECLARE
emp record;
	FOR emp IN SELECT id,nombre FROM empleado_2 LOOP
	RAISE NOTICE 'id % nom', emp.id, emmp.nombre
