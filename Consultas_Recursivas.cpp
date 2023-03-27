CREATE TABLE empleado_3(
	id int NOT NULL,
	nombre varchar(30),
	jefe_fk int,
	PRIMARY KEY(id)

);

ALTER TABLE empleado_3
	ADD CONSTRAINT jefe_fk
	FOREIGN KEY(jefe_fk) REFERENCES empleado_3(id);

INSERT INTO empleado_3(id,nombre,jefe_fk)
VALUES
(56045,'Fabian', NULL),
(34354,'Hugo', 56045),
(86834,'Diana',56045),
(49493,'Juana',34354),
(24234,'Jose',34354),
(56945,'Maria',86834);

---Consultas Recursivas-----
WITH RECURSIVE organigrama AS
(
	SELECT id, nombre, jefe_fk as jefe, 1 as nivel
	FROM empleado_3
	WHERE id = 56045
	UNION ALL
	SELECT e.id, e.nombre, e.jefe_fk, o.nivel+1 as nivel
	FROM empleado_3 e JOIN organigama o ON e.jefe_fk = o.id
)

---Consultas Recursivas (En dos tablas)----
WITH RECURSIVE full_prereq AS
(
	--Caso inicial
	SELECT course_id, prereq_id
	FROM prereq
	WHERE course_id = 'CS-347'
	
	UNION 
	--Iteraciòn
	SELECT p.prereq_id, f.course_id
	FROM prereq p JOIN full_prereq f ON (p.course_id = f.prereq_id)
	
)

SELECT * FROM full_prereq;
