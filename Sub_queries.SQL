SELECT course_id FROM section
WHERE semester = 'Fall' AND year = 2009 AND course_id NOT IN(SELECT course_id
								FROM section
								WHERE semester = 'Spring' AND year=2010)

SELECT id,name FROM instructor
WHERE salary > ALL(SELECT salary FROM instructor
		   WHERE dept_name = 'Comp. Sci.');



-----JOIN AND NATURAL JOIN-------------------

SELECT DISTINCT id,name, s.dept_name,tot_cred 
FROM student s JOIN department d ON (s.dept_name  = d.dept_name) //Specifying the join
WHERE d.dept_name = 'Physics' ORDER BY id;

SELECT DISTINCT id,name, s.dept_name,tot_cred //SQL specifies its join depending on the columns name
FROM student s NATURAL JOIN department d
WHERE d.dept_name = 'Physics' ORDER BY id;



SELECT *
FROM instructor NATURAL JOIN teaches;


SELECT *
FROM instructor i JOIN teaches t ON (i.id =t.id);


SELECT * 
FROM instructor i INNER JOIN teaches t USING (id);


--Instructores que no han enseñado ningun curso
SELECT 	instructor.*
FROM instructor NATURAL LEFT JOIN teaches
WHERE course_id IS NULL;
------------------------------------------

SELECT * FROM instructor
WHERE salary IS NULL;


SELECT *
FROM instructor i  NATURAL LEFT JOIN teaches t;

SELECT *
FROM instructor i  NATURAL LEFT JOIN teaches t USING (id);

----JOIN que une sin importar si hay relacion----------

SELECT *
FROM instructor i FULL JOIN teaches t USING (id);


SELECT a.nombre, a.fecha_nacimiento, a.id
FROM actor a, protagonizar pp, pelicula p
WHERE a.id=pp.id_actor AND p.codigo=pp.codigo_pelicula AND EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento))>=18 AND p.ano>2020
	AND EXTRACT(YEAR FROM age(now(), a.fecha_nacimiento)) > SOME 
		(SELECT EXTRACT(YEAR FROM age(now(), aa.fecha_nacimiento))
		 FROM actor aa
		 WHERE genero='Mujer'
		);
		

