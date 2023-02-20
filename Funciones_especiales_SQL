SELECT * FROM instructor
ORDER BY instructor.salary DESC, instructor.name ASC;

SELECT COUNT(*) FROM instructor
WHERE dept_name = 'Physics';

SELECT dept_name, AVG(salary) :: integer AS promedio, COUNT(*) AS cantidad_teachers FROM instructor
GROUP BY  dept_name 
ORDER BY promedio ASC;
