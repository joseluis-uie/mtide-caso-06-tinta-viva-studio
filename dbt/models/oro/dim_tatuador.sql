-- Dimensión de tatuadores.
-- Obtenemos una única fila por tatuador
-- a partir de las sesiones depuradas en Plata.

SELECT DISTINCT
    tatuador
FROM {{ ref('stg_parte') }}