-- Pregunta 3: ¿Qué máquina tiene más incidencias
-- por cada 100 horas de uso?

SELECT
    maquina,
    COUNT(*) AS sesiones,
    SUM(con_incidencia) AS total_incidencias,
    ROUND(SUM(minutos) / 60.0, 2) AS horas_totales,
    ROUND(
        SUM(con_incidencia) * 6000.0 /
        NULLIF(SUM(minutos), 0),
        2
    ) AS incidencias_100h
FROM {{ ref('fact_sesiones') }}
GROUP BY maquina
ORDER BY incidencias_100h DESC