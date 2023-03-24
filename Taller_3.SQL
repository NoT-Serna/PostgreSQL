--1)
--a)
CREATE TYPE nombre_persona AS (np varchar(40));

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
CREATE DOMAIN max_dur
	AS int NOT NULL CHECK(value > 90 AND  value < 180);

--2)
--a)
CREATE USER productor
PASSWORD 'peli123%';

GRANT SELECT ON pelicula TO productor WITH GRANT OPTION
