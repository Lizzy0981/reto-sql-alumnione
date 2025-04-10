# 📊 Reto SQL AlumniONE - Soluciones Optimizadas

Una colección de soluciones SQL optimizadas para el Reto del Comité AlumniONE, implementando técnicas avanzadas de consulta y buenas prácticas en PostgreSQL 17.

## 📱 Vista Previa de las Soluciones 📱

![SQL Challenge Preview]![Imagen Script Creacion Tablas](https://github.com/user-attachments/assets/d108756d-380a-43b3-82f0-83bfb2e46b36)


## ✨ Características

- 🔍 Implementación de 8 ejercicios SQL con soluciones optimizadas
- 📊 Uso de técnicas avanzadas como subconsultas, JOIN, UNION y CASE WHEN
- 🧠 Soluciones con enfoque en rendimiento y buenas prácticas
- 📝 Documentación detallada de cada consulta
- 🌓 Formato SQL profesional y consistente
- 📋 Consultas complementarias para análisis adicional
- 📝 Explicación detallada de cada solución y enfoque
- 🏆 Implementación de transacciones para garantizar integridad
- 🔄 Estructura modular para fácil revisión

## 🛠️ Tecnologías utilizadas

- 💻 PostgreSQL 17
- 📊 SQL estándar (ANSI SQL)
- 🔄 Transacciones BEGIN/COMMIT
- 📝 Markdown para documentación
- 🌈 Funciones específicas de PostgreSQL (EXTRACT, STRING_AGG)
- 🎨 Estructuras condicionales CASE WHEN
- 🔍 Operadores de conjunto (UNION, UNION ALL)
- 📈 Cláusulas de agrupación y filtrado avanzadas

## ✨ Técnicas SQL Implementadas

- 🌊 Subconsultas en cláusulas WHERE y FROM
- 💫 Operadores de conjunto para combinar resultados
- 🔄 JOIN de múltiples tablas para análisis relacionales
- 👆 Agrupación y filtrado con GROUP BY y HAVING
- 🔍 Clasificación condicional con estructuras CASE
- 📊 Funciones de ventana para análisis avanzados
- 🌈 Formateo de resultados con ROUND y COALESCE
- 🔆 Manipulación de fechas con EXTRACT
- 👆 Subconsultas correlacionadas para análisis dependientes
- 💎 Common Table Expressions (CTE) para consultas complejas

## 🚀 Estructura del Proyecto

1. **Archivo SQL principal**: Contiene las soluciones para los 8 ejercicios:
```
solucion-reto-sql.sql
```

2. **Script de creación de entorno**: Genera todas las tablas y datos de prueba necesarios:
```
crear_tablas_datos_prueba.sql
```

3. **Documento de explicación**: Detalla el enfoque y justificación de cada solución:
```
explicacion-soluciones.md
```

## 💡 Instrucciones de uso

Para ejecutar y probar las soluciones:

1. **Primero**, ejecuta el script de creación de tablas para configurar el entorno:
```sql
\i crear_tablas_datos_prueba.sql
```

2. **Despues**, ejecuta las soluciones para probar los ejercicios con los datos generados:
```sql
\i solucion-reto-sql.sql
```

3. **Alternativamente**, puedes ejecutar cada ejercicio individualmente seleccionando la sección correspondiente.
```
Esta estructura muestra claramente el flujo de trabajo, explicando primero qué archivos componen el proyecto
y luego cómo utilizarlos en el orden correcto.
```


## 💡 Ejercicios Implementados

1. **Productos con Precio Superior al Promedio**
   - Uso de subconsultas para comparar con valores agregados.

2. **Eliminación de Duplicados con UNION**
   - Análisis de operadores de conjunto y su comportamiento.

3. **Conteo de Pedidos en 2024**
   - Filtrado temporal y agrupación con GROUP BY y HAVING.

4. **Clasificación de Clientes por Total de Pedidos**
   - Implementación de CASE WHEN para categorización.

5. **Total de Ventas por Categoría**
   - Relaciones entre tablas y agregación por categoría.

6. **Primera Venta en el Mes de Creación**
   - Manipulación de fechas y subconsultas correlacionadas.

7. **Combinación de Ventas de 2023 y 2024**
   - Uso de UNION ALL para combinar conjuntos de datos.

8. **Empleados en Múltiples Proyectos**
   - Análisis de relaciones uno-a-muchos con JOIN y GROUP BY.


## 🌐 Demo interactiva

Para probar las consultas SQL sin necesidad de configurar una base de datos local, he preparado un entorno en DB Fiddle:
[Reto SQL AlumniONE en DB Fiddle](https://www.db-fiddle.com/f/tN4Mi5UipRz4sqi2yceKUz/3)

### Cómo usar la demo:
1. El esquema y datos ya están cargados
2. Copia cualquiera de las consultas del archivo `solucion-reto-sql.sql`
3. Pégala en el panel "Query SQL" 
4. Haz clic en "Run" para ver los resultados

Nota: Esta demo es complementaria a los archivos completos disponibles en este repositorio.


## 📱 Evidencia de pruebas

### Ejercicio 1: Productos con Precio Superior al Promedio
![Ejercicio 1 - Prueba]![Prueba ejercicio 1](https://github.com/user-attachments/assets/8b7fa359-9eba-498b-bead-6ee59795d03b)

![Ejercicio 1 - Resultados]![Resultado ejercicio 1](https://github.com/user-attachments/assets/954375d6-3384-493a-ba62-c72cf8255907)


### Ejercicio 4: Clasificación de Clientes por Total de Pedidos
![Ejercicio 4 - Prueba]![Prueba ejercicio 4](https://github.com/user-attachments/assets/5a7f0006-e52c-4f72-b28f-06cba80adcd0)

![Ejercicio 4 - Resultados]![Resultado ejercicio 4](https://github.com/user-attachments/assets/5db4b5a5-ee8a-4e28-a7d6-9ff914eb3147)


### Ejercicio 7: Combinación de Ventas 2023-2024
![Ejercicio 7 - Consulta]![Consulta ejercicio 7](https://github.com/user-attachments/assets/b19d7fcd-4ee7-4bab-b3fa-cf6a6a3a9555)

![Ejercicio 7 - Resultados 2023]![Resultado consulta ejercicio 7 2023](https://github.com/user-attachments/assets/1938843e-ecd4-4455-afd5-5d66a43a610d)

![Ejercicio 7 - Resultados 2024]![Resulta consulta ejercicio 7 2024](https://github.com/user-attachments/assets/f22e1eb9-0012-4326-b803-cb33d5904bba)

![Ejercicio 7 - Análisis Comparativo]![Analisis adicional ejercicio 7](https://github.com/user-attachments/assets/ad39a940-cf45-4071-8faa-c725b649106f)

![Ejercicio 7 - Resultados Análisis Comparativo]![Resultado analisis adicional ejercicio  7](https://github.com/user-attachments/assets/a67b216a-f6f7-4b73-8c60-538a30595388)


## 📝 Descripción de la Prueba Técnica

Este reto simula una prueba técnica real de SQL, evaluando habilidades fundamentales para:
- Desarrollador de Bases de Datos / DBA Junior
- Analista de Datos Junior
- Desarrollador Backend con conocimientos en SQL
- Especialista en Business Intelligence (nivel inicial)

## 🗂️ Estructura de la Solución

```
reto-sql-alumnione/
│
├── solucion-reto-sql.sql           # Archivo principal con las 8 soluciones
├── crear_tablas_datos_prueba.sql   # Script para crear tablas y datos de prueba
├── explicacion-soluciones.md       # Documento con justificaciones detalladas
└── README.md                       # Documentación del proyecto         
```

## 📄 Criterios de Evaluación

- ✅ **Corrección y Funcionalidad**: Cada consulta cumple con lo solicitado y funciona correctamente
- ✅ **Claridad y Legibilidad**: Uso de comentarios y estructura clara en las consultas
- ✅ **Buenas Prácticas**: Eficiencia de las consultas y uso adecuado de funciones SQL

## 👩‍💻 Desarrollado por

Creado con 💜 por Elizabeth Diaz Familia
- 🐱 [GitHub](https://github.com/Lizzy0981)
- 💼 [LinkedIn](https://linkedin.com/in/eli-familia/)
- 🐦 [Twitter](https://twitter.com/Lizzyfamilia)
  
## 🙏 Agradecimientos

- 🎓 Oracle Next Education por la formación
- 🚀 Comité AlumniONE por el reto y la oportunidad de práctica
- 👨‍🏫 A la comunidad por el apoyo continuo
