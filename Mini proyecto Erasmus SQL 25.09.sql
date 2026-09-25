-- ¿Cuál es la edad promedio de los estudiantes que tienen calificaciones sobresalientes? 
-- Complete la tabla con EXCELENTE si tienen un 9 o un 10, BUENO si tienen un 7 u 8, APROBADO si tienen un 5 o un 6, y REPROBADO si tienen menos de 5.
SELECT
ROUND(AVG(TIMESTAMPDIFF(YEAR, s.dob, CURDATE())), 2) AS edad_promedio
FROM students s
INNER JOIN (
SELECT DISTINCT student_id
FROM grades
WHERE grades >= 9
) g
ON s.student_id = g.student_id;

SELECT
student_id,
subject_id,
grades,
CASE
WHEN grades >= 9 THEN 'EXCELENTE'
WHEN grades >= 7 THEN 'BUENO'
WHEN grades >= 5 THEN 'APROBADO'
ELSE 'REPROBADO'
END AS clasificacion
FROM grades;

-- ¿Cuál es la edad media de los estudiantes por universidad?
SELECT u.uni_name,
ROUND(
AVG(TIMESTAMPDIFF(YEAR, s.dob, CURDATE())),2
) AS edad_media
FROM students s
INNER JOIN campus c
ON s.campus_id = c.campus_id
INNER JOIN university u
ON c.university_id = u.university_id
GROUP BY u.university_id, u.uni_name
ORDER BY u.uni_name;

-- ¿Cuál es la proporción de alumnos que suspendieron cada asignatura? 
-- Indique el nombre de la asignatura, el número de alumnos que suspendieron, el número total de alumnos y la proporción de alumnos que suspendieron (en porcentaje) para cada asignatura. 
-- Muestre los resultados en orden descendente según la proporción de alumnos que suspendieron.
SELECT
    sub.subj_name AS asignatura,
    COUNT(DISTINCT CASE
        WHEN g.grades < 5 THEN g.student_id
    END) AS alumnos_suspendidos,
    COUNT(DISTINCT g.student_id) AS total_alumnos,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN g.grades < 5 THEN g.student_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT g.student_id), 0),
        2
    ) AS porcentaje_suspendidos
FROM subjects sub
LEFT JOIN grades g
    ON sub.subject_id = g.subject_id
GROUP BY
    sub.subject_id,
    sub.subj_name
ORDER BY porcentaje_suspendidos DESC;

-- ¿Cuál es la nota media de los estudiantes que han realizado un Erasmus en comparación con los que no lo han hecho?
SELECT
    CASE
        WHEN ia.student_id IS NOT NULL THEN 'w_erasmus'
        ELSE 'wo_erasmus'
    END AS Erasmus_Status,
    AVG(g.grades) AS AVG_Grade
FROM students s
INNER JOIN grades g
    ON s.student_id = g.student_id
LEFT JOIN (
    SELECT DISTINCT student_id
    FROM international_agreement
) ia
    ON s.student_id = ia.student_id
GROUP BY Erasmus_Status;

-- 5.
SELECT u.university_id, u.uni_name,
    SUM(
        CASE
            WHEN b.bachelor_id LIKE 'B%' THEN 1
            ELSE 0
        END
    ) AS Bachelor_Count,
    SUM(
        CASE
            WHEN b.bachelor_id LIKE 'M%' THEN 1
            ELSE 0
        END
    ) AS Master_Count,
    SUM(
        CASE
            WHEN b.bachelor_id LIKE 'D%' THEN 1
            ELSE 0
        END
    ) AS Phd_Count
FROM university u
LEFT JOIN bachelor b
    ON u.university_id = b.university_id
GROUP BY u.university_id, u.uni_name
ORDER BY u.university_id;

-- 6 
SELECT
    u.university_id AS University_ID,
    u.uni_name AS University_Name,
    ROUND(AVG(r.intl_ranking), 0) AS Average_Ranking
FROM university u
INNER JOIN ranking r
    ON u.university_id = r.university_id
GROUP BY
    u.university_id,
    u.uni_name
ORDER BY Average_Ranking DESC
LIMIT 5;

-- 7
SELECT s.student_id, s.f_name, s.l_name, u.uni_name AS Home_University, s.email, COUNT(ia.agreement_code) AS Agreement_Count
FROM students s
INNER JOIN international_agreement ia
    ON s.student_id = ia.student_id
INNER JOIN university u
    ON ia.home_university = u.university_id
GROUP BY s.student_id, s.f_name, s.l_name, u.uni_name, s.email
ORDER BY Agreement_Count DESC
LIMIT 10;

-- 8
SELECT
    s.student_id,
    CONCAT(s.f_name, ' ', s.l_name) AS student_name,
    u.uni_name AS Home_University,
    GROUP_CONCAT(
        DISTINCT c.city
        ORDER BY c.city
        SEPARATOR ', '
    ) AS Exchange_City
FROM international_agreement ia
INNER JOIN students s
    ON ia.student_id = s.student_id
INNER JOIN university u
    ON ia.home_university = u.university_id
INNER JOIN campus c
    ON ia.away_university = c.university_id
WHERE ia.agreement_code = '123BH'
GROUP BY
    s.student_id,
    s.f_name,
    s.l_name,
    u.uni_name;
    
-- 9
SELECT
    s.subject_id,
    s.subj_name,
    COUNT(DISTINCT us.university_id) AS Num_Universities,
    ROUND(AVG(g.grades), 2) AS Average_Grade
FROM subjects s
LEFT JOIN uni_subj us
    ON s.subject_id = us.subject_id
LEFT JOIN grades g
    ON s.subject_id = g.subject_id
GROUP BY
    s.subject_id,
    s.subj_name
ORDER BY s.subject_id;

-- 10
SELECT
    s.city AS City,
    s.state AS State,
    ROUND(
        COUNT(CASE WHEN g.grades >= 9 THEN 1 END) * 100.0
        / COUNT(*),
        2
    ) AS Percentage_Outstanding
FROM students s
INNER JOIN grades g
    ON s.student_id = g.student_id
GROUP BY
    s.city,
    s.state
ORDER BY Percentage_Outstanding DESC
LIMIT 5;

-- 11
SELECT
    u.uni_name,
    COUNT(*) AS sent_students
FROM international_agreement ia
INNER JOIN university u
    ON ia.home_university = u.university_id
GROUP BY u.uni_name
ORDER BY sent_students DESC
LIMIT 5;