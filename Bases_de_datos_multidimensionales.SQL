--Operaciones de Bases multidimensionales
SELECT *
FROM ventas;

--Grouping sets (apartir de la columna numèrica) y por GROUP BY (INEFICIENTE)--
--(a,b,c): (a,b,c) (a,b), (b,c), (a,c), (a), (b), (c), ()---
SELECT item_name, color, clothes_size, SUM(quantity)
FROM ventas
GROUP BY(item_name, color, clothes_size)

UNION ALL

SELECT item_name, color, NULL, SUM(quantity)
FROM ventas
GROUP BY(item_name, color)

UNION ALL

SELECT item_name, NULL, clothes_size, SUM(quantity)
FROM ventas
GROUP BY(item_name, clothes_size)

UNION ALL

SELECT NULL, color, clothes_size, SUM(quantity)
FROM ventas
GROUP BY(color, clothes_size)

UNION ALL

SELECT item_name, NULL, NULL, SUM(quantity)
FROM ventas
GROUP BY(item_name)

UNION ALL

SELECT NULL, color, NULL, SUM(quantity)
FROM ventas
GROUP BY(color)

UNION ALL

SELECT NULL, NULL, clothes_size, SUM(quantity)
FROM ventas
GROUP BY(clothes_size)

UNION

SELECT NULL, NULL, NULL, SUM(quantity)
FROM ventas

--GROUPING SETS(EFICIENTE)
SELECT item_name, color, clothes_size, SUM(quantity)
FROM ventas
GROUP BY
	GROUPING SETS(
			(item_name, color, clothes_size),
			(item_name,color),
			(item_name,clothes_size),
			(color,clothes_size),
			(item_name),
			(color),
			(clothes_size),
			()
			);
--Operador Cube (MAS EFICIENTE)---
SELECT item_name, color, clothes_size, SUM(quantity)
FROM ventas
GROUP BY CUBE(item_name,color,clothes_size)

--Operaciones de dimensiones---
--ROLLUP
--(a,b,c): (a,b,c) (a,b), (a), ()---
SELECT item_name, color, clothes_size, SUM(quantity)
FROM ventas
GROUP BY ROLLUP(item_name,color,clothes_size)
