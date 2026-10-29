-- Pregunta 1: ¿Qué estilo genera menos ingresos por hora?
-- Convertimos los minutos a horas para calcular la rentabilidad.

SELECT
    estilo,
    COUNT(*) AS sesiones,
    ROUND(SUM(importe_eur), 2) AS ingresos_totales,
    ROUND(SUM(minutos) / 60.0, 2) AS horas_totales,
    ROUND(
        SUM(importe_eur) * 60.0 / NULLIF(SUM(minutos), 0),
        2
    ) AS ingreso_hora
FROM {{ ref('fact_sesiones') }}
GROUP BY estilo
ORDER BY ingreso_hora ASC