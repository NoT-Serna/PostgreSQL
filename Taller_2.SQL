
a) SELECT nombre, fecha_nacimiento, id 
FROM actor a, protagonizar pp, pelicula p
WHERE a.id = pp.id_actor AND p.codigo= pp.codigo_pelicula AND EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento))>=18 AND p.anio>2020
	AND EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento))> SOME
		(SELECT EXTRACT(YEAR FROM age(now(), fecha_nacimiento))
		FROM actor
		WHERE genero= 'Mujer');
		
b) SELECT codigo, nombre
FROM productor p, producir pp
WHERE pp.codigo_productor IN (SELECT codigo_productor
							 FROM productor p, producir pp
							 WHERE codigo_pelicula = NULL );

c) SELECT p.codigo,nombre 
FROM productor p, pelicula,producir
WHERE p.codigo = producir.codigo_pelicula AND duracion > ALL(SELECT MAX(duracion)
																FROM pelicula);
						   

SELECT MAX(duracion)
FROM pelicula;
