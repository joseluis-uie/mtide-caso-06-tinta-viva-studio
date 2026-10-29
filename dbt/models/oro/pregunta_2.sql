-- Pregunta 2: ¿Qué tatuador consume más tinta por hora?
-- Calculamos los mililitros consumidos por hora trabajada.

SELECT
    tatuador,
    COUNT(*) AS sesiones,
    ROUND(SUM(ml_tinta), 2) AS tinta_total_ml,
    ROUND(SUM(minutos) / 60.0, 2) AS horas_totales,
    ROUND(
        SUM(ml_tinta) * 60.0 / NULLIF(SUM(minutos), 0),
        2
    ) AS ml_hora
FROM {{ ref('fact_sesiones') }}
GROUP BY tatuador
ORDER BY ml_hora DESC