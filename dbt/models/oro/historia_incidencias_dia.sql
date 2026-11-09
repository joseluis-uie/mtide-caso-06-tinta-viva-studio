SELECT
    CAST(fecha AS DATE) AS dia,
    COUNT(*) AS sesiones,
    SUM(con_incidencia) AS sesiones_con_incidencia,
    ROUND(
        SUM(con_incidencia) * 6000.0
        / NULLIF(SUM(minutos), 0),
        2
    ) AS incidencias_100h
FROM {{ ref('fact_sesiones') }}
GROUP BY CAST(fecha AS DATE)
ORDER BY dia