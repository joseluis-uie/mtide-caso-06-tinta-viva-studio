# 3 · Fuentes nuevas

## ¿Qué datos nuevos hemos incorporado?

En esta fase hemos incorporado dos fuentes nuevas a nuestro Lakehouse: una agenda de citas y un registro de eventos de la web.

La agenda nos permite conocer las citas programadas, sus horarios y las posibles reprogramaciones. Por otro lado, el registro de eventos recoge las reservas y cancelaciones realizadas por los clientes, con **{{ stg_eventos.filas }} eventos procesados en Plata**.

## ¿Qué tenían de especial estos datos?

El principal problema de la agenda era que algunas citas aparecían varias veces porque habían sido reprogramadas. Por ejemplo, la cita `AG-0008` tenía dos versiones con distintos horarios.

Si tratásemos todas las versiones como citas independientes, podríamos contar reservas duplicadas o detectar conflictos de horarios que realmente no existen.

Para solucionarlo, en `stg_agenda.sql` utilizamos `ROW_NUMBER()` para conservar únicamente la versión más reciente de cada cita. También calculamos las horas de inicio y fin para comprobar posibles solapamientos.

En el registro de eventos normalizamos los estilos, evitamos duplicados por identificador de evento y calculamos la antelación de cada cancelación respecto a la fecha prevista de la cita.

## Test protagonista: citas solapadas

La regla de negocio que comprobamos es que un tatuador no puede tener dos citas diferentes que coincidan en el tiempo.

Al analizar la agenda original de Bronce, incluyendo todas las versiones históricas, encontramos **8 parejas de citas solapadas**.

El problema era que algunas citas habían sido reprogramadas y sus versiones anteriores seguían apareciendo en los datos. Esto podía provocar conflictos aparentes al analizar la agenda.

Para solucionarlo, modificamos la transformación de Plata para conservar únicamente la versión más reciente de cada cita mediante `ROW_NUMBER()`.

Después ejecutamos el test `citas_solapadas.sql`, que compara los horarios de las citas de cada tatuador.

**El resultado fue PASS, con cero solapamientos detectados en la agenda depurada.**

Así conseguimos trabajar con una agenda vigente, sin confundir las versiones antiguas con citas actuales.

## Pregunta 4. ¿Cuánto cuestan las cancelaciones de última hora?

Consideramos cancelaciones de última hora aquellas realizadas con menos de 24 horas de antelación.

El estilo que concentra el mayor importe estimado es **{{ pregunta_4.estilo[0] }}**, con **{{ pregunta_4.cancelaciones[0] }} cancelaciones** y **{{ pregunta_4.importe_perdido[0] }} €**.

Para obtener este resultado hemos tenido en cuenta el tipo de evento, el momento de la cancelación y la fecha prevista de la cita.

Sin este tratamiento, podríamos contabilizar todas las cancelaciones como si fueran de última hora, incluyendo aquellas realizadas con varios días de antelación. Esto sobreestimaría el importe asociado a las cancelaciones de última hora.

Estos importes representan ingresos potenciales no realizados, no necesariamente pérdidas netas, porque no sabemos si las citas fueron ocupadas posteriormente o si se cobraron anticipos.

## Conclusión

Con las nuevas fuentes hemos conseguido disponer de una agenda actualizada y analizar el impacto de las cancelaciones de última hora.

Además, hemos incorporado transformaciones y comprobaciones automáticas para evitar errores cuando lleguen nuevas entregas de datos.