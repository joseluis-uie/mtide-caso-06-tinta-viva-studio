SELECT
    1 AS id,
    COUNT(*) AS sesiones,
    COUNT(DISTINCT maquina) AS maquinas,
    COUNT(DISTINCT tatuador) AS tatuadores,
    MIN(fecha) AS fecha_inicio,
    MAX(fecha) AS fecha_fin,
    ROUND(SUM(minutos) / 60.0, 2) AS horas_totales,
    SUM(con_incidencia) AS sesiones_con_incidencia
FROM {{ ref('fact_sesiones') }}