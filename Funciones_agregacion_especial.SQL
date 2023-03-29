SELECT *
FROM takes
---RANK ORDER FUNCTION----
SELECT grade, RANK() OVER(
		ORDER BY grade
		  ) rank_n

FROM takes;

SELECT id, course_id, sec_id, semester, year, grade, RANK() OVER(
		ORDER BY grade
		  ) rank_n

FROM takes;

--Clasificar datos por semestre y año
SELECT id, course_id, sec_id, semester, year, grade, RANK() OVER(
		PARTITION BY semester
		ORDER BY grade
		  ) rank_n
FROM takes;

--Clasificar los instructores por departamento ordenando por el salario--
SELECT instructor.* , RANK() OVER(
		PARTITION BY dept_name
		ORDER BY salario
		  ) rank_n
FROM instructor;
