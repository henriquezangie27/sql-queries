--==============================================================================
-- 📊 ANÁLISIS DE EFICIENCIA OPERATIVA Y PROYECTOS (SQL AVANZADO)
-- Autora: Angie Henriquez
--==============================================================================

-- Ejercicio 1: Total de horas asignadas por departamento administrativo
-- Optimización: Estructuración de JOINs y ordenamiento limpio por alias.
SELECT 
    d.nombre AS departamento,
    SUM(ap.horas_asignadas) AS total_horas_asignadas
FROM Departamentos AS d
INNER JOIN Empleados AS e 
    ON d.depto_id = e.depto_id
INNER JOIN AsignacionesDeProyectos AS ap 
    ON e.empleado_id = ap.empleado_id
GROUP BY d.nombre
ORDER BY total_horas_asignadas DESC;


-- Ejercicio 2: Ranking de empleados con más horas trabajadas por sucursal/departamento
-- Optimización: Corrección de sintaxis en el ORDER BY para utilizar la función de ventana de forma nativa.
SELECT 
    e.nombre,
    e.apellido,
    SUM(ap.horas_asignadas) AS total_horas_trabajadas,
    RANK() OVER (
        PARTITION BY e.depto_id 
        ORDER BY SUM(ap.horas_asignadas) DESC
    ) AS ranking_departamental
FROM Empleados AS e
INNER JOIN AsignacionesDeProyectos AS ap 
    ON e.empleado_id = ap.empleado_id
GROUP BY e.empleado_id, e.nombre, e.apellido, e.depto_id
ORDER BY e.depto_id ASC, ranking_departamental ASC;
