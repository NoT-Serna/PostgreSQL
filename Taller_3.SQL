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

GRANT SELECT ON pelicula TO productor
GRANT INSERT ON pelicula TO productor 
GRANT UPDATE ON pelicula TO productor
GRANT DELETE ON pelicula TO productor

REVOKE DELETE ON pelicula FROM productor


--b)
CREATE USER asistente
PASSWORD 'actor23*';

GRANT SELECT ON actor TO asistente
GRANT UPDATE ON actor TO asistente

--2)
--a)
CREATE FUNCTION productorXpeliculas(i int)
RETURNS int
AS
$$
	DECLARE
			peliculas int;
	
	BEGIN	
		SELECT COUNT(codigo_pelicula) INTO peliculas
		FROM pelicula NATURAL JOIN producir
		WHERE producir.codigo_productor = i;
		RETURN peliculas;
		
	END;
$$
LANGUAGE plpgsql;
SELECT productorXpeliculas(14);
--b)

CREATE OR REPLACE FUNCTION edad_actor(i int)
RETURNS int
AS
$$	
	DECLARE
		edad int;
		i int;
	BEGIN
		IF EXISTS (SELECT id FROM actor a WHERE a.id = i)THEN
		edad = EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento));
		RETURN edad;
		END IF;
	END;
$$
LANGUAGE plpgsql;
SELECT edad_actor(4);

SELECT * from actor;

EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento))
