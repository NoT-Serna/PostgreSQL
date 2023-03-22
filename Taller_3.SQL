--1)
--a)
CREATE TYPE nombre_persona AS (varchar(40), NOT NULL))

--b)
CREATE TYPE genero AS ENUM
	('comedia', 'accion');
--c)
ALTER TABLE pelicula
	ALTER COLUMN presupuesto SET DEFAULT 3000000.00;

--d)
CREATE TYPE sexo AS ENUM
	('F', 'M', 'NB');

--e)
CREATE TYPE duracion AS RANGE
