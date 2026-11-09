SELECT
    maquina || '|' || CAST(date_trunc('week', fecha) AS DATE)::VARCHAR AS id,
    maquina,
    CAST(date_trunc('week', fecha) AS DATE) AS semana,
    COUNT(*) AS sesiones,
    SUM(con_incidencia) AS sesiones_con_incidencia,
    ROUND(SUM(minutos) / 60.0, 2) AS horas,
    ROUND(SUM(con_incidencia) * 6000.0 / NULLIF(SUM(minutos), 0), 2) AS incidencias_100h
FROM {{ ref('fact_sesiones') }}
GROUP BY maquina, date_trunc('week', fecha)
ORDER BY maquina, semana
