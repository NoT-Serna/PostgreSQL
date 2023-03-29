--a) 
SELECT nombre, fecha_nacimiento, id 
FROM actor a, protagonizar pp, pelicula p
WHERE a.id = pp.id_actor AND p.codigo= pp.codigo_pelicula AND EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento))>=18 AND p.anio>2020
	AND EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento))> SOME
		(SELECT EXTRACT(YEAR FROM age(now(), fecha_nacimiento))
		FROM actor
		WHERE genero= 'Mujer');
		
--b) 
SELECT codigo, nombre
FROM productor p, producir pp
WHERE pp.codigo_productor NOT IN (SELECT codigo_productor
				FROM  producir );

--c) 
SELECT p.codigo,nombre 
FROM productor p, pelicula,producir
WHERE p.codigo = producir.codigo_pelicula AND duracion > ALL(SELECT MAX(duracion),
							FROM pelicula);
							
--d)
SELECT actor.* 
FROM protagonizar p ,pelicula,producir,actor
WHERE p.codigo_pelicula IN (SELECT codigo_pelicula
						   FROM producir,productor,pelicula
						   WHERE nombre = 'Steven Spielberg');
						   
						   
--e)
SELECT titulo, duracion FROM pelicula,actor
WHERE nombre = 'Jenna Ortega' AND duracion > SOME (SELECT codigo_pelicula
												  FROM protagonizar,pelicula,actor
												  WHERE nombre = 'Ana de Armas');
												  
--2)

--a)
SELECT COUNT(actor.id)
FROM actor,pelicula, productor, protagonizar p JOIN producir pp ON(p.codigo_pelicula = pp.codigo_pelicula)
WHERE actor.genero = 'M' AND productor.nombre ='Steven Spielberg' AND anio > 2020;

--b)
SELECT a.nombre 
FROM pelicula, actor a NATURAL JOIN protagonizar
WHERE codigo_pelicula = NULL AND anio = 2022
ORDER BY a.nombre ASC;

--c)
SELECT t.*
FROM protagonizar p JOIN trailer t ON(p.codigo_pelicula = t.codigo_pelicula)
WHERE id_actor = 4;

--d)
SELECT p.*
FROM productor p NATURAL JOIN producir pp 
WHERE codigo_pelicula = NULL;

--e)
SELECT a.*
FROM actor a, protagonizar p JOIN producir pp ON (p.codigo_pelicula = pp.codigo_pelicula)
WHERE codigo_productor = 11;

--f)
SELECT p.*
FROM pelicula p NATURAL JOIN protagonizar pp 
WHERE id_actor != 777 AND id_actor != 345;

--3)
--a)
CREATE MATERIALIZED VIEW num_pelxpro
AS
SELECT COUNT(pelicula.codigo) FROM pelicula NATURAL JOIN producir
GROUP BY(codigo_productor);

SELECT * FROM num_pelxpro;

--b)
CREATE VIEW avg_duracion
AS
SELECT AVG(duracion) FROM pelicula NATURAL JOIN producir
WHERE duracion IN (SELECT * FROM num_pelxpro);

SELECT * FROM avg_duracion;

--c)
CREATE VIEW count_pelxhombre
AS
SELECT COUNT(pelicula.codigo) FROM actor, pelicula NATURAL JOIN protagonizar
WHERE actor.genero = 'male';

SELECT * FROM count_pelxhombre;

--d)
CREATE VIEW trailer_x20
AS
SELECT DISTINCT actor.nombre, EXTRACT(YEAR FROM age(now(), actor.fecha_nacimiento)) 
FROM trailer, actor NATURAL JOIN protagonizar
WHERE trailer.duracion < 20;

SELECT * FROM trailer_x20;

--4)
--Restricciones--
--a)
ALTER TABLE actor
	ADD CONSTRAINT gen_check
	CHECK(genero IN ('F', 'M', 'NB'));

--b)
ALTER TABLE pelicula
	ADD CONSTRAINT duracion_max
	CHECK(duracion >= 60);

--c)
ALTER TABLE pelicula
	ADD CONSTRAINT anio_min
	CHECK(anio > 2000);

