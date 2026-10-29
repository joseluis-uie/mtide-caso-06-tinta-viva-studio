-- Dimensión de estilos de tatuaje.
-- Obtenemos los estilos ya normalizados en Plata.

SELECT DISTINCT
    estilo
FROM {{ ref('stg_parte') }}
