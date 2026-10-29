# Memo para la dirección de Tinta Viva Studio

## ¿Qué hemos encontrado?

Después de procesar y analizar los datos de las sesiones, las máquinas, los tatuadores y las cancelaciones, hemos obtenido cuatro conclusiones principales:

**1. Ingresos por estilo.** El estilo **{{ pregunta_1.estilo[0] }}** es el que menos ingresos genera por hora de trabajo, con **{{ pregunta_1.ingreso_hora[0] }} €/hora**.

**2. Consumo de tinta.** El tatuador con mayor consumo por hora es **{{ pregunta_2.tatuador[0] }}**, con **{{ pregunta_2.ml_hora[0] }} ml/hora**.

**3. Incidencias de las máquinas.** La máquina **{{ pregunta_3.maquina[0] }}** presenta la tasa de incidencias más alta, con **{{ pregunta_3.incidencias_100h[0] }} incidencias por cada 100 horas de utilización**.

**4. Cancelaciones de última hora.** El estilo **{{ pregunta_4.estilo[0] }}** concentra el mayor importe asociado a cancelaciones realizadas con menos de 24 horas de antelación, con **{{ pregunta_4.cancelaciones[0] }} cancelaciones** y **{{ pregunta_4.importe_perdido[0] }} €** de ingresos potencialmente perdidos.

## ¿Qué recomendamos?

**Revisar los precios y tiempos del estilo con menos ingresos por hora.** Sería interesante analizar si los precios actuales compensan el tiempo que se dedica a estos tatuajes. Antes de modificar las tarifas, habría que conocer también los costes.

**Analizar el consumo de tinta por tatuador.** El mayor consumo no significa necesariamente un desperdicio. Recomendaríamos comparar los trabajos realizados, sus estilos y su complejidad para identificar si existen diferencias justificadas.

**Priorizar la revisión de la máquina con mayor tasa de incidencias.** Su indicador es superior al del resto de máquinas, por lo que convendría revisar su mantenimiento y averiguar si los problemas se repiten por una causa concreta.

**Reducir las cancelaciones de última hora.** Podríamos implantar recordatorios automáticos de las citas y estudiar una política de anticipos o cancelaciones. También sería interesante disponer de una lista de espera para intentar ocupar los huecos que queden libres.

## ¿Qué información nos falta?

Aunque los resultados permiten identificar posibles mejoras, todavía existen algunas limitaciones.

Para conocer la rentabilidad real de cada estilo necesitaríamos incorporar los costes de materiales, personal y otros gastos.

En el consumo de tinta nos falta información sobre el tamaño y la complejidad de los tatuajes. Sin estos datos no podemos concluir que un mayor consumo sea ineficiente.

En las incidencias necesitaríamos conocer su gravedad, las causas y el historial de mantenimiento de las máquinas.

Por último, hemos supuesto que el importe estimado de una cita cancelada representa un ingreso potencial perdido. Sin embargo, no sabemos si se cobraron anticipos o si la cita fue ocupada posteriormente, por lo que no podemos considerarlo directamente una pérdida económica real.

## ¿Cómo hemos realizado el análisis?

Hemos construido un pequeño Lakehouse con tres capas: Bronce, Plata y Oro, utilizando DuckDB y dbt.

En Bronce conservamos los ficheros originales, mientras que en Plata corregimos los errores de calidad y preparamos los datos para su análisis.

Uno de los problemas que encontramos fue que algunos estilos de tatuaje venían escritos de diferentes maneras. Los normalizamos para evitar que se interpretaran como categorías distintas y añadimos comprobaciones para controlar los valores permitidos.

También detectamos que la agenda contenía varias versiones de algunas citas debido a las reprogramaciones. Para solucionarlo conservamos la versión más reciente de cada una.

Además, creamos el test `citas_solapadas.sql`, que comprueba que un tatuador no tenga dos citas diferentes al mismo tiempo. En los datos originales encontramos ocho parejas potencialmente solapadas, mientras que en la agenda depurada no se detectaron conflictos.

Finalmente, construimos un modelo en estrella en la capa Oro, con una tabla de hechos de sesiones, sus dimensiones y cuatro consultas de negocio.

Todo el proceso se valida mediante tests automáticos de dbt, lo que nos permite repetirlo cuando recibamos nuevas entregas de datos sin tener que rehacer manualmente el análisis.