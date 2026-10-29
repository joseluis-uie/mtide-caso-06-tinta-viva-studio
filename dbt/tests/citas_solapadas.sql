-- Comprueba que un tatuador no tenga
-- dos citas distintas solapadas.

SELECT
    a.tatuador,
    a.cita AS cita_1,
    b.cita AS cita_2,
    a.inicio AS inicio_1,
    a.fin AS fin_1,
    b.inicio AS inicio_2,
    b.fin AS fin_2

FROM {{ ref('stg_agenda') }} a

JOIN {{ ref('stg_agenda') }} b
    ON a.tatuador = b.tatuador
    AND a.cita < b.cita
    AND a.inicio < b.fin
    AND b.inicio < a.fin