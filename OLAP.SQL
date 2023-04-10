--OLAP
--EXCEL FUNCTION: =CONCATENAR("INSERT INTO ventas VALUES ('";C3;"','";D3;"','";E3;"',";F3;");")


CREATE TABLE ventas(
	item_name varchar(10) not null,
	color varchar(10) not null,
	clothes_size varchar(10) not null,
	quantity int not null

);




SELECT * FROM ventas

--Crear la funcion prodcuto cruzado
CREATE EXTENSION tablefunc;

--SELECT principal para usar en crosstab
SELECT item_name, color, sum(quantity)
FROM ventas
GROUP BY item_name,color
ORDER BY item_name, color


--Tabla de producto cruzado
SELECT *
FROM crosstab('SELECT item_name::text, color, sum(quantity):: numeric
	FROM ventas
	GROUP BY item_name,color
	ORDER BY item_name, color')
AS datos_cruzados(item_name text, dark numeric, pastel numeric, white numeric);
