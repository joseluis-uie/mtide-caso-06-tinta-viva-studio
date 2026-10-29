-- Tabla de hechos de sesiones de tatuaje.
-- Granularidad: una fila por cita/sesión.

SELECT
    cita,
    fecha,
    tatuador,
    maquina,
    estilo,
    minutos,
    ml_tinta,
    importe_eur,
    CASE
        WHEN incidencia IS NOT NULL
             AND trim(incidencia) <> ''
        THEN 1
        ELSE 0
    END AS con_incidencia
FROM {{ ref('stg_parte') }}