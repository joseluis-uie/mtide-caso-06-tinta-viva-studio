-- PLATA: agenda de citas.
-- La fuente contiene varias versiones de algunas citas
-- debido a reprogramaciones.
-- Conservamos la versión más reciente de cada cita.

WITH versiones AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY cita
            ORDER BY version DESC
        ) AS rn
    FROM {{ source('bronce', 'agenda') }}
),

agenda_actual AS (
    SELECT
        cita,
        upper(trim(tatuador)) AS tatuador,
        fecha::date AS fecha,
        hora_inicio,
        duracion_min::integer AS duracion_min,
        version
    FROM versiones
    WHERE rn = 1
)

SELECT
    *,
    fecha + hora_inicio AS inicio,
    fecha + hora_inicio
        + duracion_min * INTERVAL '1 minute' AS fin
FROM agenda_actual