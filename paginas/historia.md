# La MQ-38 registra {{ pregunta_3.incidencias_100h[0] }} sesiones con incidencia por cada 100 horas: prioricemos su revisión

Proponemos que la persona responsable de Tinta Viva Studio programe una revisión técnica de la MQ-38 antes de cerrar su próxima asignación de sesiones. La MQ-38 registra {{ pregunta_3.incidencias_100h[0] }} sesiones con incidencia por cada 100 horas, frente a {{ pregunta_3.incidencias_100h[1] }} de la siguiente máquina, {{ pregunta_3.maquina[1] }}. La comparación de la MQ-38 se apoya en {{ pregunta_3.sesiones[0] }} sesiones y {{ pregunta_3.horas_totales[0] }} horas de uso.

La propuesta se sitúa al cierre del periodo analizado, el {{ historia_terreno.fecha_fin[0] }}. Como supuesto de planificación de esta propuesta, fijamos el plazo en el 13 de marzo de 2026; no es una evaluación del estado actual de la máquina.

```grafico
titular: La MQ-38 encabeza la tasa al ajustar por horas de uso
modelo: pregunta_3
barras: maquina → incidencias_100h
orden: desc
destacar: MQ-38
```

```grafico
tipo: calor
titular: La MQ-38 registra sesiones con incidencia en varias semanas
modelo: historia_maquina_semana
filas: maquina
columnas: semana
valor: incidencias_100h
destacar: MQ-38
```

El patrón de la MQ-38 aparece en varias semanas. Otras máquinas la superan en algunas semanas. La última semana es parcial y la MQ-38 tiene pocas horas de uso; su ausencia de sesiones con incidencia en ese tramo no demuestra una mejora. Las tasas semanales no demuestran una avería ni una tendencia creciente.

```grafico
titular: La limpieza mantiene a la MQ-38 como primera prioridad de revisión
modelo: historia_contraste
barras: maquina → sin_limpiar, limpio
leyenda: tal como llegan, limpios
```

La tasa de la MQ-38 pasa de {{ historia_contraste.sin_limpiar[0] }} a {{ historia_contraste.limpio[0] }} tras limpiar. La prioridad se mantiene, pero la magnitud depende de corregir la calidad de los datos.

## Qué proponemos

1. **Programar la revisión técnica.** La persona responsable del estudio contactará con mantenimiento antes del 13 de marzo de 2026, en el escenario del ejercicio y antes de cerrar la siguiente asignación de sesiones. La revisión determinará si hacen falta ajustes o reparaciones.
2. **Definir el seguimiento.** El equipo de datos y la persona responsable del estudio acordarán antes de esa misma fecha registrar durante las siguientes cuatro semanas las sesiones, las horas, el tatuador y el tipo de incidencia, además del diagnóstico técnico. Compararán las tasas con exposición suficiente antes de dar por resuelto el problema.

## Qué no sabemos todavía

- Los datos cubren del {{ historia_terreno.fecha_inicio[0] }} al {{ historia_terreno.fecha_fin[0] }}: {{ historia_terreno.sesiones[0] }} sesiones de {{ historia_terreno.maquinas[0] }} máquinas. No describen el estado actual del estudio.
- Contamos sesiones con texto en el campo de incidencia, no el número de averías ni su gravedad.
- No hemos separado el efecto de la máquina del tatuador, el estilo o las condiciones de trabajo, ni contrastado registros de mantenimiento.
- Las duraciones corregidas influyen en las tasas por hora. La última semana es parcial y las tasas con pocas horas pueden ser inestables.
- No hemos demostrado causalidad, significación estadística ni una tendencia de deterioro. Proponemos revisar, no sustituir la máquina.

## La misma historia para cada audiencia

- **Comité de dirección (5 segundos):** «La MQ-38 registra {{ pregunta_3.incidencias_100h[0] }} sesiones con incidencia por cada 100 horas: prioricemos su revisión».
- **Responsable del estudio (1 minuto):** «Programa la revisión y acuerda el seguimiento antes del 13 de marzo de 2026, en el escenario del ejercicio». Acciones: contactar con mantenimiento y dejar definido el registro posterior.
- **Equipo de datos (5 minutos):** «La prioridad resiste la limpieza, pero no demuestra causalidad». Fuente: parte diario en bronce; última entrega por cita, normalización y corrección de duraciones en plata; tasas por hora y comparación semanal en oro. El método y los filtros están en [Cómo se construyó la historia](historia-pasos.html).
