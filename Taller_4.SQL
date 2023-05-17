--1)
--a)
WITH RECURSIVE actoresxDago_Garcia AS
(
	--Caso inicial
	SELECT *
	FROM director
	WHERE director = 'Sofia'
	
	UNION
	--ITERACION
	SELECT id, nombre
	FROM actor a JOIN director d ON(a.id = d.id_actor)

)

SELECT * FROM actoresxDago_Garcia;

--b)

WITH RECURSIVE directoresxAna_de_Armas AS
(
	--Caso Inicial 
	SELECT id, nombre
	FROM actor
	WHERE nombre = 'Ana de Armas'
	
	UNION
	--iteracion
	SELECT id_actor, director
	FROM director d JOIN actor a ON(d.id_actor = a.id)

)

SELECT * FROM directoresxAna_de_Armas;

--2)
--a)
SELECT titulo, SUM(presupuesto), RANK() OVER(
		PARTITION BY genero
		ORDER BY SUM(presupuesto) ASC
		) rank_n

FROM pelicula
GROUP BY genero, titulo;
