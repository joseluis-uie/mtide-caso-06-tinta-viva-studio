# Cómo se construyó la historia

La portada cuenta el destino. Aquí queda el viaje: la decisión que hay detrás, lo que buscamos en los datos y lo que dejamos fuera.

## Paso 1 · De tema a decisión

| Nivel | En Tinta Viva Studio |
|---|---|
| Tema | Incidencias de las máquinas de tatuaje |
| Pregunta | ¿Qué máquina acumula más incidencias por cada 100 horas de uso? |
| Decisión | ¿Debe la persona responsable del estudio programar una revisión técnica de la MQ-38 antes del 13 de marzo de 2026 y de cerrar la siguiente asignación de sesiones? |

**La prueba:** después de leer la portada, la persona responsable del estudio programa o no una revisión técnica de la MQ-38 antes del 13 de marzo de 2026 y de cerrar la siguiente asignación de sesiones.

La decisión se sitúa al cierre de los datos de marzo de 2026; el plazo es una propuesta del ejercicio, no una fecha de mantenimiento ya realizada.

## Paso 2 · Qué se mueve en los datos

### 2a · El terreno

```cifras
{{ historia_terreno.sesiones[0] }} | sesiones
{{ historia_terreno.maquinas[0] }} | máquinas
{{ historia_terreno.tatuadores[0] }} | tatuadores
{{ historia_terreno.horas_totales[0] }} | horas de uso
```

El periodo analizado va del {{ historia_terreno.fecha_inicio[0] }}
al {{ historia_terreno.fecha_fin[0] }}.

```grafico
titular: Sesiones con incidencia por cada 100 horas de uso, por máquina
modelo: pregunta_3
barras: maquina → incidencias_100h
orden: desc
```

La MQ-38 presenta la mayor tasa: {{ pregunta_3.incidencias_100h[0] }}
sesiones con incidencia por cada 100 horas de uso. Esta comparación
tiene en cuenta las horas utilizadas, pero no demuestra la causa
de las incidencias.

```grafico
tipo: linea
titular: Sesiones con incidencia por cada 100 horas de uso, por día
modelo: historia_incidencias_dia
x: dia
y: incidencias_100h
```

La tasa diaria presenta picos y días sin sesiones con incidencia,
sin una subida o bajada sostenida claramente visible.
La serie corresponde al conjunto de máquinas: no permite atribuir
sus picos a la MQ-38. Además, la tasa puede variar mucho en días
con pocas horas de uso.

```grafico
tipo: histograma
titular: Distribución de la duración de las sesiones
modelo: fact_sesiones
columna: minutos
```

Las duraciones se concentran en los intervalos intermedios.
El intervalo con más sesiones es el de 100 a 120 minutos,
y aparecen pocas sesiones entre 260 y 280 minutos.
La media y la mediana están próximas, como muestran las marcas
calculadas en el gráfico.

### 2b · El disparador: la MQ-38 frente al resto

```grafico
titular: La MQ-38 presenta la mayor tasa de sesiones con incidencia
modelo: pregunta_3
barras: maquina → incidencias_100h
orden: desc
destacar: MQ-38
```

**El hallazgo:** la {{ pregunta_3.maquina[0] }} registra
{{ pregunta_3.incidencias_100h[0] }} sesiones con incidencia por cada
100 horas de uso, frente a {{ pregunta_3.incidencias_100h[1] }}
de la siguiente máquina, {{ pregunta_3.maquina[1] }}.

La diferencia se mantiene al ajustar por horas de uso. Una posible
explicación es el estado de la máquina, pero es una hipótesis:
estos datos no permiten separar su efecto del tatuador, el estilo
o las condiciones de cada sesión.



```grafico
tipo: calor
titular: La MQ-38 registra sesiones con incidencia en varias semanas
modelo: historia_maquina_semana
filas: maquina
columnas: semana
valor: incidencias_100h
destacar: MQ-38
```

La MQ-38 registra sesiones con incidencia en varias semanas. La última semana es parcial y tiene pocas horas de uso: no interpretamos su tasa como prueba de mejora. La comparación semanal no demuestra una tendencia ni la causa del problema.

### 2c · Qué lo puede explicar

- **Anomalía:** sí. La MQ-38 presenta la mayor tasa de sesiones con incidencia por cada 100 horas de uso. Es una diferencia descriptiva; todavía no hemos comprobado su significación estadística.
- **Cambio significativo:** todavía no está comprobado. La línea diaria representa al conjunto de máquinas y no permite afirmar que la MQ-38 haya empeorado con el tiempo.
- **Fuerzas del mercado:** no tenemos datos externos que permitan relacionar las incidencias con proveedores, materiales u otros factores del mercado.
- **Iniciativas propias:** no hemos comprobado si hubo cambios de mantenimiento, configuración o asignación de máquinas. Su posible influencia es una hipótesis pendiente de contrastar.

## Paso 3 · Qué datos entran y cuáles se quedan fuera
| Dato candidato | ¿Pasa el filtro? | Dónde se usa |
|---|---|---|
| Tasa de sesiones con incidencia por máquina | Sí: permite priorizar la revisión ajustando por uso | Gráfico principal de la portada |
| Sesiones y horas de uso por máquina | Sí: muestran la exposición que sostiene la comparación | Contexto y comprobaciones |
| Tasa antes y después de limpiar | Sí: comprueba si la prioridad depende de errores de datos | Contraste de robustez de la portada |
| Tasa por máquina y semana | Sí: comprueba si el patrón aparece en varias semanas | Mapa de calor de la portada |
| Evolución diaria del conjunto de máquinas | No para atribuir el problema a la MQ-38 | Exploración del apartado 2a |
| Distribución de la duración de las sesiones | No decide qué máquina revisar, pero ayuda a entender las duraciones | Exploración del apartado 2a |
| Ingreso por hora según estilo | No cambia directamente la decisión de revisión | Fuera de la portada |

### Contraste entre datos originales y limpios

```grafico
titular: La MQ-38 encabeza la tasa antes y después de limpiar
modelo: historia_contraste
barras: maquina → sin_limpiar, limpio
leyenda: tal como llegan, limpios
```

La MQ-38 pasa de {{ historia_contraste.sin_limpiar[0] }} a
{{ historia_contraste.limpio[0] }} sesiones con incidencia por cada
100 horas de uso. Mantiene {{ historia_contraste.sesiones_brutas[0] }}
sesiones antes de limpiar y {{ historia_contraste.sesiones_limpias[0] }}
después.

La prioridad de revisión se mantiene. La limpieza cambia la magnitud
de la diferencia, por lo que la decisión debe apoyarse en las tasas
calculadas con los datos limpios.
### El efecto del eje cortado

```grafico
tipo: eje
titular: Las mismas tasas con dos escalas distintas
modelo: pregunta_3
barras: maquina → incidencias_100h
corte: 0.5
```

El eje cortado exagera visualmente las diferencias entre máquinas.
Por eso las barras de la portada empiezan en cero: su longitud
debe ser proporcional a la tasa que representan.

### Alcance de los datos

Los datos proceden del parte diario del estudio, conservado en
bronce y transformado mediante `stg_parte` y `fact_sesiones`.
El periodo va del {{ historia_terreno.fecha_inicio[0] }}
al {{ historia_terreno.fecha_fin[0] }}, con
{{ historia_terreno.sesiones[0] }} sesiones y
{{ historia_terreno.maquinas[0] }} máquinas.

La limpieza conserva la última entrega de cada cita, normaliza
estilos y nombres de tatuadores y sustituye las duraciones fuera
del intervalo de 1 a 600 minutos por la mediana válida de su estilo.

Una sesión cuenta como sesión con incidencia cuando el campo
`incidencia` contiene texto. Esta medida no cuenta varios problemas
dentro de una misma sesión ni permite conocer su gravedad.
La comparación es descriptiva y no demuestra que la máquina
sea la causa de las incidencias.


## Las cinco comprobaciones

- **Decisión:** la persona responsable del estudio programa o no la revisión de la MQ-38 antes del plazo propuesto en el ejercicio.
- **Titular que afirma:** la portada comunica la mayor tasa de sesiones con incidencia y propone priorizar la revisión.
- **Fuente:** todas las cifras de resultados proceden de modelos del lakehouse; el alcance y la limpieza están documentados.
- **Evidencia diversa:** barras para comparar máquinas, mapa de calor para comparar semanas y contraste de datos originales frente a limpios.
- **Lo que no cuadra:** la última semana es parcial y la tasa cambia con la limpieza; no se demuestra una avería ni causalidad.
