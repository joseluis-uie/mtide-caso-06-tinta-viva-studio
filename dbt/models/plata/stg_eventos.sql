
-- PLATA: eventos de reservas y cancelaciones.
-- Normalizamos los estilos y calculamos la antelación.
-- Eliminamos eventos repetidos por evento_id.

WITH eventos AS (
    SELECT
        evento_id,
        reserva_id,
        lower(trim(tipo)) AS tipo,
        ts::timestamp AS fecha_evento,
        fecha_cita::timestamp AS fecha_cita,
        upper(trim(tatuador)) AS tatuador,
        lower(replace(trim(estilo), ' ', '_')) AS estilo,
        importe_estimado::double AS importe_estimado
    FROM {{ source('bronce', 'eventos') }}
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY evento_id
        ORDER BY ts DESC
    ) = 1
),

calculados AS (
    SELECT
        *,
        date_diff(
            'minute',
            fecha_evento,
            fecha_cita
        ) AS minutos_antelacion
    FROM eventos
)

SELECT
    *,
    CASE
        WHEN tipo = 'cancelacion'
         AND minutos_antelacion >= 0
         AND minutos_antelacion < 1440
        THEN 1
        ELSE 0
    END AS cancelacion_ultima_hora
FROM calculados
