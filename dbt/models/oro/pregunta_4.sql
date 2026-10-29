
-- Pregunta 4: ¿Cuánto dinero se pierde por cancelaciones
-- de última hora y qué estilo concentra más pérdidas?
-- Consideramos última hora menos de 24 horas de antelación.

SELECT
    estilo,
    COUNT(*) AS cancelaciones,
    ROUND(SUM(importe_estimado), 2) AS importe_perdido
FROM {{ ref('stg_eventos') }}
WHERE cancelacion_ultima_hora = 1
GROUP BY estilo
ORDER BY importe_perdido DESC
