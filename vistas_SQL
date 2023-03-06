-- Crear una vista para los cursos de Physics en Fall 2009: idcurso,salon edificio
CREATE 	VIEW phy_fall_2009(curso,salon,edificio)
AS
SELECT s.course_id, room_no, building
FROM section s NATURAL JOIN course
WHERE semester = 'Fall' AND year= '2009' AND dept_name = 'Physics';



SELECT * FROM phy_fall_2009;

CREATE MATERIALIZED VIEW phy_fall_2009_m
AS
SELECT s.course_id, room_no, building
FROM section s NATURAL JOIN course
WHERE semester = 'Fall' AND year= '2009' AND dept_name = 'Physics';

INSERT into course VALUES('PHY-102', 'Thermodynamics', 'Physics', 3);

INSERT into section VALUES('PHY-102', 1, 'Fall',2009,'Packard',101,'A','M','8:00:00');

REFRESH MATERIALIZED VIEW phy_fall_2009_m;
