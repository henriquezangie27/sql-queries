--==============================================================================
-- 🎬 NETFLIX DATA ANALYTICS: OPTIMIZACIÓN DE CONSULTAS Y CTES
-- Autora: Angie Henriquez
--==============================================================================

-- 1. Actor o actriz con mayor volumen de participaciones
-- Optimización: Se añade el LIMIT 1 para responder de forma exacta a la pregunta técnica.
SELECT 
    actor_id, 
    COUNT(serie_id) AS numero_de_series 
FROM actuaciones 
GROUP BY actor_id
ORDER BY numero_de_series DESC
LIMIT 1;


-- 2. Top 3 de series con mayor calificación y su volumen de episodios
-- Optimización: Reemplaza las subconsultas pesadas del archivo original por una arquitectura limpia.
WITH TopGeneros AS (
    -- Identificamos rápidamente los 3 géneros con más contenido
    SELECT genero
    FROM Series 
    GROUP BY genero 
    ORDER BY COUNT(*) DESC
    LIMIT 3
)
SELECT 
    s.titulo AS titulo_serie, 
    s.año_lanzamiento, 
    s.genero, 
    ROUND(AVG(e.rating_imdb), 2) AS rating_promedio_imdb
FROM Series AS s
INNER JOIN Episodios AS e 
    ON s.serie_id = e.serie_id
WHERE s.genero IN (SELECT genero FROM TopGeneros)
GROUP BY s.serie_id, s.titulo, s.año_lanzamiento, s.genero
ORDER BY rating_promedio_imdb DESC;


-- 3. Consolidación de métricas de series mediante CTEs Múltiples
-- Optimización: Formateo estricto de las expresiones de tabla comunes para máxima legibilidad.
WITH EpisodiosRecientes AS (
    SELECT 
        serie_id,
        COUNT(episodio_id) AS num_episodios
    FROM Episodios
    GROUP BY serie_id
),
Calificaciones AS (
    SELECT 
        serie_id,
        AVG(rating_imdb) AS promedio_imdb
    FROM Episodios
    GROUP BY serie_id
)
SELECT 
    s.titulo,
    er.num_episodios,
    ROUND(c.promedio_imdb, 2) AS promedio_imdb
FROM Series AS s
INNER JOIN EpisodiosRecientes AS er 
    ON s.serie_id = er.serie_id
INNER JOIN Calificaciones AS c 
    ON s.serie_id = c.serie_id
ORDER BY promedio_imdb DESC, er.num_episodios DESC;


-- 4. Diagnóstico de rendimiento: Episodio de mayor duración
-- Optimización Avanzada: En producción, evitar "SELECT *" es una regla de oro. Especificamos columnas.
SELECT 
    episodio_id, 
    titulo, 
    duracion 
FROM episodios
ORDER BY duracion DESC
LIMIT 1;
