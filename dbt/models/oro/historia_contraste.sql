WITH bruto AS (
    SELECT
        maquina,
        COUNT(*) AS sesiones_brutas,
        SUM(
            CASE
                WHEN incidencia IS NOT NULL
                     AND TRIM(incidencia) <> ''
                THEN 1 ELSE 0
            END
        ) AS incidencias_brutas,
        SUM(minutos::INTEGER) AS minutos_brutos
    FROM {{ source('bronce', 'parte') }}
    GROUP BY maquina
),
limpio AS (
    SELECT
        maquina,
        COUNT(*) AS sesiones_limpias,
        SUM(con_incidencia) AS incidencias_limpias,
        SUM(minutos) AS minutos_limpios
    FROM {{ ref('fact_sesiones') }}
    GROUP BY maquina
)
SELECT
    COALESCE(b.maquina, l.maquina) AS maquina,
    b.sesiones_brutas,
    l.sesiones_limpias,
    ROUND(
        b.incidencias_brutas * 6000.0
        / NULLIF(b.minutos_brutos, 0), 2
    ) AS sin_limpiar,
    ROUND(
        l.incidencias_limpias * 6000.0
        / NULLIF(l.minutos_limpios, 0), 2
    ) AS limpio
FROM bruto b
FULL OUTER JOIN limpio l ON b.maquina = l.maquina
ORDER BY limpio DESC NULLS LAST, maquina