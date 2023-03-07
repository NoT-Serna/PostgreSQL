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
SELECT COUNT(genero = 'male')
FROM actor, protagonizar p JOIN productor pp ON (p.codigo_peliucla = pp.codigo_pelicula)
WHERE pp.nombre = 'Steven Spielberg' AND anio > 2020; 


--b)
SELECT nombre
FROM actor NATURAL JOIN protagonizar
WHERE codigo_pelicula = NULL AND anio = 2022
ORDER BY nombre ASC;

--c)
SELECT trailer.* 
FROM trailer t JOIN protagonizar p ON (t.codigo_pelicula = p.codigo_pelicula)
WHERE id_actor = '345';

--d)
SELECT productor.*
FROM productor NATURAL JOIN producir
WHERE codigo_pelicula = NULL;

--e)
SELECT actor.* 
FROM actor, protagonizar p JOIN producir pp ON (p.codigo_pelicula = pp.codigo_pelicula)
WHERE codigo_productor = '4';

--f)
SELECT pelicula.* 
FROM pelicula NATURAL JOIN protagonizar
WHERE id_actor != 3 AND id_actor != 4;
