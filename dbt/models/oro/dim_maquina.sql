-- Dimensión de máquinas.
-- Una fila por cada máquina utilizada en el estudio.

SELECT DISTINCT
    maquina
FROM {{ ref('stg_parte') }}