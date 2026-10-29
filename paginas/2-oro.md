# 2 · El oro

## Nuestro modelo en estrella

En esta fase hemos construido la capa Oro a partir de los datos que limpiamos previamente en Plata.

La tabla principal es `fact_sesiones`, que contiene **{{ fact_sesiones.filas }} sesiones**. Cada fila representa una sesión de tatuaje, con su duración, importe, tinta consumida y posibles incidencias.

Alrededor de esta tabla hemos creado tres dimensiones: `dim_tatuador`, `dim_maquina` y `dim_estilo`. Esto nos permite analizar las sesiones desde diferentes perspectivas sin tener que trabajar directamente con los ficheros originales.

## Pregunta 1. ¿Qué estilo genera menos ingresos por hora?

El estilo que menos ingresos genera es **{{ pregunta_1.estilo[0] }}**, con **{{ pregunta_1.ingreso_hora[0] }} €/hora**.

Este indicador nos permite comparar los estilos teniendo en cuenta el tiempo dedicado a cada uno, aunque no podemos hablar directamente de rentabilidad porque no estamos considerando los costes.

## Pregunta 2. ¿Qué tatuador consume más tinta por hora?

El tatuador con mayor consumo es **{{ pregunta_2.tatuador[0] }}**, con **{{ pregunta_2.ml_hora[0] }} ml/hora**.

Esto no significa necesariamente que esté desperdiciando tinta, ya que el consumo puede depender del estilo, el tamaño y la complejidad de los tatuajes realizados.

## Pregunta 3. ¿Qué máquina tiene más incidencias por cada 100 horas?

La máquina con mayor tasa de incidencias es **{{ pregunta_3.maquina[0] }}**, con **{{ pregunta_3.incidencias_100h[0] }} incidencias por cada 100 horas de uso**.

Este dato nos permite identificar qué máquinas convendría revisar primero, teniendo en cuenta su tiempo de utilización y no únicamente el número de incidencias.

## Comparación con la Jornada 3

Con la incorporación de la nueva remesa hemos ampliado los datos disponibles para el análisis.

En esta ocasión, además de limpiar los nuevos registros, hemos construido un modelo dimensional y automatizado los cálculos con dbt. Esto nos permite obtener las respuestas directamente de los datos y actualizarlas cuando recibamos nuevas entregas.

Para comprobar si se mantienen las conclusiones de la Jornada 3, debemos comparar los resultados anteriores con los actuales. Aunque los indicadores se calculan de la misma manera, los valores pueden variar al incorporar nuevas sesiones.

También hemos añadido tests de calidad para comprobar que no existan claves duplicadas, valores nulos o referencias incorrectas entre hechos y dimensiones.