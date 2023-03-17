
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


SELECT * FROM empleado_nuevo;
