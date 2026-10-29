# 1 · La remesa nueva

## ¿Qué llegó y qué problema encontramos?

El 11 de marzo de 2026 recibimos una nueva remesa de datos con las sesiones realizadas en Tinta Viva Studio.

Al procesar los datos detectamos un problema en la columna `estilo`. Algunos estilos de tatuaje venían escritos de distintas formas, principalmente por diferencias entre mayúsculas, minúsculas y espacios.

Por ejemplo, `Fine Line`, `FINE LINE` y `fine line` representaban el mismo estilo, pero el sistema los interpretaba como categorías diferentes.

En la primera ejecución de dbt, el test detectó 16 registros que no cumplían los valores permitidos.

## ¿Cómo descubrimos el problema?

Ejecutamos `dbt build` para transformar los datos y comprobar su calidad.

El test `accepted_values` de la columna `estilo` falló, mientras que el resto de las comprobaciones pasaron correctamente.

Para investigar el problema, consultamos los distintos valores de `estilo` y comprobamos que había nombres duplicados por diferencias de formato.

## ¿Cómo lo solucionamos?

Modificamos el modelo `stg_parte.sql` de la capa Plata para normalizar los nombres de los estilos.

Utilizamos las funciones `LOWER`, `TRIM` y `REPLACE` para convertir los textos a minúsculas, eliminar espacios innecesarios y sustituir los espacios interiores por guiones bajos.

También aplicamos esta transformación antes de calcular las medianas de duración, para que todas las sesiones de un mismo estilo se agruparan correctamente.

Realizamos la corrección en Plata porque Bronce debe conservar los datos originales tal como llegaron, permitiendo consultar su contenido y rastrear posibles errores.

## Resultado final

Después de normalizar los estilos en stg_parte.sql, volvimos a ejecutar dbt build. Los errores iniciales se redujeron de 16 a 2, pero el test accepted_values seguía fallando.

Al revisar los resultados comprobamos que los dos valores que seguían apareciendo eran fine_line y flash_day, precisamente dos de los estilos válidos. Por tanto, el problema ya no parecía estar en la normalización de los datos, sino en la configuración o ejecución del test.

Para solucionarlo, también modificamos el archivo _plata.yml, donde se definen las comprobaciones de calidad de la capa Plata.

Finalmente, ejecutamos de nuevo dbt build y conseguimos que todas las comprobaciones terminaran en verde.

La capa Plata contiene ahora {{ stg_parte.filas }} sesiones, con los estilos unificados y los datos preparados para construir el modelo dimensional de la capa Oro.