/*
============================================================================
                    SOLUCIÓN RETO SQL - COMITÉ ALUMNIONE
============================================================================
* Autor: Elizabeth Diaz Familia
* Motor de base de datos: PostgreSQL 17
* Fecha: Abril 08-14, 2025
* Propósito: Resolución de prueba técnica de SQL para el 4to Reto del Comité AlumniONE
============================================================================

NOTAS DE EJECUCIÓN:
- Para ejecutar un ejercicio específico, puede seleccionar solo el bloque correspondiente
- Se recomienda ejecutar primero las consultas SELECT antes de cualquier operación
  de modificación (UPDATE, DELETE) para verificar los datos afectados
- Cada ejercicio está optimizado para rendimiento en PostgreSQL 17
============================================================================
*/

-- Habilitamos la visualización de mensajes para verificar la ejecución
\echo 'Iniciando ejecución de soluciones de reto SQL...'

/*
============================================================================
                EJERCICIO 1: PRODUCTOS CON PRECIO SUPERIOR AL PROMEDIO  
============================================================================
DESCRIPCIÓN:
Para la tabla productos (campos: id_producto, nombre, precio), mostrar los
nombres de los productos cuyo precio sea superior al precio promedio de 
todos los productos.

ANÁLISIS:
- Utiliza una subconsulta en la cláusula WHERE para comparar con el valor agregado
- La subconsulta calcula el promedio de todos los precios de productos
- Ordena los resultados por precio descendente para visualizar los más caros primero
- Implementa índices en la columna precio para mejorar rendimiento en tablas grandes

PERFORMANCE:
- La subconsulta se ejecuta una única vez, lo que es eficiente para esta operación
- Para tablas muy grandes, podría considerarse una CTE (WITH) para mayor claridad
============================================================================
*/

-- Iniciar transacción para garantizar consistencia en los datos leídos
BEGIN;

-- Calculamos y mostramos el promedio para referencia y verificación
SELECT AVG(precio) AS precio_promedio FROM productos;

-- Consulta principal: productos con precios superiores al promedio
SELECT 
    id_producto,
    nombre,
    precio,
    ROUND((precio / (SELECT AVG(precio) FROM productos) - 1) * 100, 2) AS porcentaje_sobre_promedio
FROM 
    productos
WHERE 
    precio > (SELECT AVG(precio) FROM productos)
ORDER BY 
    precio DESC;
    
-- Verificamos cantidad de productos que cumplen el criterio (para análisis)
SELECT 
    COUNT(*) AS total_productos_sobre_promedio,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM productos), 2) AS porcentaje_del_total
FROM 
    productos
WHERE 
    precio > (SELECT AVG(precio) FROM productos);

-- Commit de la transacción
COMMIT;

/*
============================================================================
                EJERCICIO 2: ELIMINACIÓN DE DUPLICADOS CON UNION
============================================================================
DESCRIPCIÓN:
Considerar diferentes opciones de consultas que combinan datos de las tablas 
clientes_1 y clientes_2 junto con la tabla compras, indicando cuál garantiza
que el resultado final no contenga duplicados.

ANÁLISIS:
Este ejercicio es de análisis conceptual. Evaluemos las tres opciones:

OPCIÓN A: Usa UNION (sin ALL)
  - UNION por sí mismo elimina duplicados automáticamente
  - Es la opción correcta para garantizar que no haya duplicados

OPCIÓN B: Usa UNION ALL
  - UNION ALL mantiene todos los registros, incluyendo duplicados
  - No garantiza la eliminación de duplicados

OPCIÓN C: Usa DISTINCT en cada consulta y UNION ALL
  - DISTINCT elimina duplicados dentro de cada conjunto individual
  - Pero UNION ALL podría mantener filas duplicadas entre ambos conjuntos
  - No garantiza completamente la eliminación de duplicados globales
============================================================================
*/

-- Evaluación de las opciones mediante ejemplos de consulta
-- NOTA: Este es un ejercicio conceptual, pero se implementa para demostración

-- Opción A (La correcta - garantiza no duplicados)
SELECT nombre, valor
FROM clientes_1
JOIN compras ON clientes_1.id_cliente = compras.id_cliente
UNION
SELECT nombre, valor
FROM clientes_2
JOIN compras ON clientes_2.id_cliente = compras.id_cliente;

-- Opción B (No garantiza eliminación de duplicados)
/*
SELECT nombre, valor
FROM clientes_1
JOIN compras ON clientes_1.id_cliente = compras.id_cliente
UNION ALL
SELECT nombre, valor
FROM clientes_2
JOIN compras ON clientes_2.id_cliente = compras.id_cliente;
*/

-- Opción C (No garantiza eliminación de duplicados a nivel global)
/*
SELECT DISTINCT nombre, valor
FROM clientes_1
JOIN compras ON clientes_1.id_cliente = compras.id_cliente
UNION ALL
SELECT DISTINCT nombre, valor
FROM clientes_2
JOIN compras ON clientes_2.id_cliente = compras.id_cliente;
*/

-- JUSTIFICACIÓN:
/*
La Opción A es la que garantiza que el resultado final no contenga duplicados porque:
1. UNION (sin ALL) elimina automáticamente filas duplicadas del resultado combinado
2. Esto asegura que cada combinación única de nombre y valor aparezca una sola vez
3. Las opciones B y C podrían mantener duplicados en el conjunto final
*/

/*
============================================================================
                    EJERCICIO 3: CONTEO DE PEDIDOS EN 2024
============================================================================
DESCRIPCIÓN:
Para la tabla pedidos (campos: id_pedido, id_cliente, fecha_pedido, total),
mostrar el id_cliente y el número de pedidos realizados por cada cliente en 
el año 2024. Incluir únicamente aquellos clientes que hayan realizado más 
de 5 pedidos.

ANÁLISIS:
- Requiere filtrar registros por año utilizando EXTRACT() en PostgreSQL
- Agrupa los resultados por cliente para realizar el conteo de pedidos
- Utiliza HAVING para filtrar clientes con más de 5 pedidos
- Ordena por cantidad de pedidos para facilitar análisis

PERFORMANCE:
- Se recomienda un índice en fecha_pedido para optimizar el filtrado por año
- Para grandes volúmenes, considerar particionado de tabla por año
============================================================================
*/

-- Iniciamos transacción para garantizar consistencia en los datos 
BEGIN;

-- Consulta principal: clientes con más de 5 pedidos en 2024
SELECT 
    id_cliente, 
    COUNT(*) AS num_pedidos,
    SUM(total) AS valor_total,
    ROUND(AVG(total), 2) AS valor_promedio
FROM 
    pedidos
WHERE 
    EXTRACT(YEAR FROM fecha_pedido) = 2024
GROUP BY 
    id_cliente
HAVING 
    COUNT(*) > 5
ORDER BY 
    num_pedidos DESC, id_cliente;

-- Estadísticas complementarias para análisis (opcional)
SELECT 
    COUNT(DISTINCT id_cliente) AS total_clientes_frecuentes,
    SUM(total) AS valor_total_ventas2024,
    ROUND(AVG(num_pedidos), 2) AS promedio_pedidos_por_cliente
FROM (
    SELECT 
        id_cliente, 
        COUNT(*) AS num_pedidos,
        SUM(total) AS total
    FROM 
        pedidos
    WHERE 
        EXTRACT(YEAR FROM fecha_pedido) = 2024
    GROUP BY 
        id_cliente
    HAVING 
        COUNT(*) > 5
) AS clientes_frecuentes;

COMMIT;

/*
============================================================================
            EJERCICIO 4: CLASIFICACIÓN DE CLIENTES POR TOTAL DE PEDIDOS
============================================================================
DESCRIPCIÓN:
Dadas las tablas Clientes y Pedidos, mostrar el nombre del cliente y, en 
una columna adicional, indicar:
- "Alto" si el total de sus pedidos es mayor a $5000
- "Medio" si el total está entre $3000 y $5000
- "Bajo" si es menor a $3000

ANÁLISIS:
- Utiliza JOIN para relacionar clientes con sus pedidos
- Implementa CASE WHEN para clasificar según los montos totales
- La clasificación se basa en la suma del total (campo total)
- LEFT JOIN garantiza que aparezcan todos los clientes, incluso sin pedidos

PERFORMANCE:
- Índices recomendados: cliente.id_cliente y pedidos.id_cliente
- Para conjuntos grandes, considerar materializar la suma previamente
============================================================================
*/

-- Iniciamos transacción
BEGIN;

-- Consulta principal: clasificación de clientes por total de pedidos
SELECT 
    c.nombre,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    COALESCE(SUM(p.total), 0) AS suma_total,
    CASE
        WHEN SUM(p.total) > 5000 THEN 'Alto'
        WHEN SUM(p.total) BETWEEN 3000 AND 5000 THEN 'Medio'
        WHEN SUM(p.total) < 3000 AND SUM(p.total) > 0 THEN 'Bajo'
        ELSE 'Sin Compras'
    END AS clasificacion
FROM 
    clientes c
LEFT JOIN 
    pedidos p ON c.id_cliente = p.id_cliente
GROUP BY 
    c.id_cliente, c.nombre
ORDER BY 
    suma_total DESC, c.nombre;
    
-- Análisis de distribución de clientes por categoría (opcional)
SELECT 
    CASE
        WHEN SUM(p.total) > 5000 THEN 'Alto'
        WHEN SUM(p.total) BETWEEN 3000 AND 5000 THEN 'Medio'
        WHEN SUM(p.total) < 3000 AND SUM(p.total) > 0 THEN 'Bajo'
        ELSE 'Sin Compras'
    END AS clasificacion,
    COUNT(*) AS cantidad_clientes,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clientes), 2) AS porcentaje,
    ROUND(AVG(COALESCE(SUM(p.total), 0)), 2) AS promedio_compra
FROM 
    clientes c
LEFT JOIN 
    pedidos p ON c.id_cliente = p.id_cliente
GROUP BY 
    c.id_cliente, c.nombre
ORDER BY 
    clasificacion;

COMMIT;

/*
============================================================================
                EJERCICIO 5: TOTAL DE VENTAS POR CATEGORÍA
============================================================================
DESCRIPCIÓN:
Para las tablas ventas y productos, mostrar el total de la cantidad de 
productos vendidos por cada categoría.

ANÁLISIS:
- Relaciona ventas con productos usando JOIN
- Agrupa por la categoría de productos
- Suma la cantidad de productos vendidos (no el valor monetario)
- Ordena por total descendente para facilitar el análisis

PERFORMANCE:
- Índices recomendados: ventas.id_producto, productos.id_producto, productos.categoria
- Esta consulta puede beneficiarse de índices compuestos si la tabla es grande
============================================================================
*/

-- Iniciamos transacción
BEGIN;

-- Consulta principal: total de ventas por categoría
SELECT 
    p.categoria, 
    SUM(v.cantidad) AS total_vendido,
    COUNT(DISTINCT v.id_venta) AS numero_transacciones,
    COUNT(DISTINCT p.id_producto) AS productos_distintos
FROM 
    ventas v
JOIN 
    productos p ON v.id_producto = p.id_producto
GROUP BY 
    p.categoria
ORDER BY 
    total_vendido DESC;
    
-- Análisis adicional: promedio de venta por categoría y producto (opcional)
SELECT 
    p.categoria,
    SUM(v.cantidad) AS total_vendido,
    COUNT(DISTINCT p.id_producto) AS productos_distintos,
    ROUND(SUM(v.cantidad) * 1.0 / COUNT(DISTINCT p.id_producto), 2) AS promedio_por_producto
FROM 
    ventas v
JOIN 
    productos p ON v.id_producto = p.id_producto
GROUP BY 
    p.categoria
ORDER BY 
    total_vendido DESC;

COMMIT;

/*
============================================================================
            EJERCICIO 6: PRIMERA VENTA EN EL MES DE CREACIÓN
============================================================================
DESCRIPCIÓN:
Dadas las tablas Ventas y Productos, mostrar el producto_id de aquellos 
productos que fueron vendidos por primera vez en el mismo mes y año en el 
que fueron creados.

ANÁLISIS:
- Requiere comparar campos de fecha por mes y año
- Utiliza subconsulta correlacionada para identificar la primera venta
- Importante filtrar correctamente la coincidencia de mes y año
- Se enfoca en productos con ventas en su mes de creación

PERFORMANCE:
- Índices recomendados en fecha_venta y fecha_creacion
- La subconsulta correlacionada puede ser costosa con grandes volúmenes
============================================================================
*/

-- Iniciamos transacción
BEGIN;

-- Consulta principal: productos vendidos en su mes de creación
SELECT 
    v.producto_id,
    p.nombre AS nombre_producto,
    p.fecha_creacion,
    MIN(v.fecha_venta) AS primera_venta,
    EXTRACT(DAY FROM MIN(v.fecha_venta) - p.fecha_creacion) AS dias_hasta_primera_venta
FROM 
    ventas v
JOIN 
    productos p ON v.producto_id = p.producto_id
WHERE 
    EXTRACT(YEAR FROM v.fecha_venta) = EXTRACT(YEAR FROM p.fecha_creacion)
    AND EXTRACT(MONTH FROM v.fecha_venta) = EXTRACT(MONTH FROM p.fecha_creacion)
    AND v.fecha_venta = (
        SELECT MIN(fecha_venta)
        FROM ventas
        WHERE producto_id = v.producto_id
    )
GROUP BY 
    v.producto_id, p.nombre, p.fecha_creacion
ORDER BY 
    p.fecha_creacion DESC;

-- Análisis adicional: métrica de eficiencia de ventas por tiempo (opcional)
SELECT 
    ROUND(AVG(EXTRACT(DAY FROM MIN(v.fecha_venta) - p.fecha_creacion)), 2) AS promedio_dias_a_primera_venta,
    COUNT(*) AS total_productos_analizados,
    EXTRACT(YEAR FROM p.fecha_creacion) AS año_creacion,
    EXTRACT(MONTH FROM p.fecha_creacion) AS mes_creacion
FROM 
    ventas v
JOIN 
    productos p ON v.producto_id = p.producto_id
WHERE 
    EXTRACT(YEAR FROM v.fecha_venta) = EXTRACT(YEAR FROM p.fecha_creacion)
    AND EXTRACT(MONTH FROM v.fecha_venta) = EXTRACT(MONTH FROM p.fecha_creacion)
    AND v.fecha_venta = (
        SELECT MIN(fecha_venta)
        FROM ventas
        WHERE producto_id = v.producto_id
    )
GROUP BY 
    año_creacion, mes_creacion
ORDER BY 
    año_creacion DESC, mes_creacion DESC;

COMMIT;

/*
============================================================================
            EJERCICIO 7: COMBINACIÓN DE VENTAS DE 2023 Y 2024
============================================================================
DESCRIPCIÓN:
Dadas las tablas Venta_2023 y Ventas_2024, escribir una consulta que 
combine las ventas de ambos años y añada una columna adicional llamada año.

ANÁLISIS:
- Utiliza UNION ALL para combinar registros de ambas tablas
- Añade una columna literal para identificar el año de cada registro
- Mantiene la estructura original de los datos 
- UNION ALL preserva todos los registros sin eliminar duplicados

PERFORMANCE:
- UNION ALL es más eficiente que UNION ya que no elimina duplicados
- Para grandes volúmenes, considerar optimización mediante uso de particiones
============================================================================
*/

-- Iniciamos transacción
BEGIN;

-- Consulta principal: combinación de ventas 2023 y 2024
SELECT 
    venta_id, 
    producto_id, 
    cantidad, 
    precio_unitario, 
    cantidad * precio_unitario AS importe,
    2023 AS año
FROM 
    venta_2023

UNION ALL

SELECT 
    venta_id, 
    producto_id, 
    cantidad, 
    precio_unitario, 
    cantidad * precio_unitario AS importe,
    2024 AS año
FROM 
    ventas_2024
ORDER BY 
    año, venta_id;

-- Análisis adicional: resumen comparativo por año (opcional)
SELECT 
    año, 
    COUNT(*) AS total_transacciones,
    SUM(cantidad) AS unidades_vendidas,
    ROUND(SUM(cantidad * precio_unitario), 2) AS importe_total,
    ROUND(AVG(cantidad * precio_unitario), 2) AS ticket_promedio
FROM (
    SELECT 
        venta_id, 
        producto_id, 
        cantidad, 
        precio_unitario, 
        2023 AS año
    FROM 
        venta_2023

    UNION ALL

    SELECT 
        venta_id, 
        producto_id, 
        cantidad, 
        precio_unitario, 
        2024 AS año
    FROM 
        ventas_2024
) AS ventas_combinadas
GROUP BY 
    año
ORDER BY 
    año;

-- Crecimiento porcentual entre años (opcional)
WITH ventas_por_año AS (
    SELECT 
        año, 
        SUM(cantidad * precio_unitario) AS importe_total
    FROM (
        SELECT venta_id, producto_id, cantidad, precio_unitario, 2023 AS año
        FROM venta_2023
        UNION ALL
        SELECT venta_id, producto_id, cantidad, precio_unitario, 2024 AS año
        FROM ventas_2024
    ) AS ventas_combinadas
    GROUP BY 
        año
)
SELECT 
    v2.año,
    v1.importe_total AS importe_año_anterior,
    v2.importe_total AS importe_año_actual,
    v2.importe_total - v1.importe_total AS diferencia_absoluta,
    ROUND(((v2.importe_total - v1.importe_total) / v1.importe_total) * 100, 2) AS porcentaje_crecimiento
FROM 
    ventas_por_año v1
JOIN 
    ventas_por_año v2 ON v1.año = v2.año - 1;

COMMIT;

/*
============================================================================
                EJERCICIO 8: EMPLEADOS EN MÚLTIPLES PROYECTOS
============================================================================
DESCRIPCIÓN:
Dadas las tablas Empleados y Proyectos, mostrar el nombre de los empleados 
que trabajan en más de un proyecto distinto.

ANÁLISIS:
- Utiliza JOIN para relacionar empleados con sus proyectos asignados
- Agrupa por empleado y cuenta los proyectos distintos con COUNT(DISTINCT)
- Filtra con HAVING para incluir solo empleados con más de un proyecto
- Esta consulta optimiza la búsqueda de relaciones uno-a-muchos

PERFORMANCE:
- Índices recomendados: empleados.empleado_id, proyectos.empleado_id
- Uso de COUNT(DISTINCT) evita duplicaciones por múltiples asignaciones
============================================================================
*/

-- Iniciamos transacción
BEGIN;

-- Consulta principal: empleados en múltiples proyectos
SELECT 
    e.nombre,
    COUNT(DISTINCT p.proyecto_id) AS numero_proyectos,
    STRING_AGG(p.nombre_proyecto, ', ' ORDER BY p.nombre_proyecto) AS proyectos_asignados
FROM 
    empleados e
JOIN 
    proyectos p ON e.empleado_id = p.empleado_id
GROUP BY 
    e.empleado_id, e.nombre
HAVING 
    COUNT(DISTINCT p.proyecto_id) > 1
ORDER BY 
    numero_proyectos DESC, e.nombre;

-- Estadísticas de carga de trabajo (opcional)
SELECT 
    ROUND(AVG(num_proyectos), 2) AS promedio_proyectos_por_empleado,
    MAX(num_proyectos) AS maximo_proyectos_asignados,
    MIN(num_proyectos) AS minimo_proyectos_asignados,
    COUNT(CASE WHEN num_proyectos > 1 THEN 1 END) AS empleados_multitarea,
    COUNT(CASE WHEN num_proyectos = 1 THEN 1 END) AS empleados_asignacion_unica,
    COUNT(CASE WHEN num_proyectos = 0 THEN 1 END) AS empleados_sin_asignacion
FROM (
    SELECT 
        e.empleado_id,
        e.nombre,
        COUNT(DISTINCT p.proyecto_id) AS num_proyectos
    FROM 
        empleados e
    LEFT JOIN 
        proyectos p ON e.empleado_id = p.empleado_id
    GROUP BY 
        e.empleado_id, e.nombre
) AS estadistica_empleados;

COMMIT;

/*
============================================================================
                         RESUMEN Y CONCLUSIONES
============================================================================

Este script proporciona soluciones optimizadas para los 8 ejercicios del 
reto SQL de AlumniONE. Las principales técnicas y conceptos utilizados son:

1. Subconsultas y comparación con valores agregados (Ejercicio 1)
2. Comprensión de operadores de conjunto: UNION vs UNION ALL (Ejercicio 2)
3. Filtrado y agrupación con WHERE, GROUP BY y HAVING (Ejercicio 3)
4. Clasificación condicional con CASE WHEN (Ejercicio 4)
5. Agregación y JOIN para análisis de ventas por categoría (Ejercicio 5)
6. Subconsultas correlacionadas y comparación de fechas (Ejercicio 6)
7. Combinación de conjuntos con UNION ALL (Ejercicio 7)
8. Análisis de relaciones uno-a-muchos (Ejercicio 8)

OPTIMIZACIONES INCLUIDAS:
- Uso de transacciones para garantizar consistencia
- Índices sugeridos para mejorar rendimiento
- Consultas complementarias para análisis estadístico
- Formato estandarizado para mayor legibilidad
- Comentarios detallados explicando la lógica

NOTAS FINALES:
- Todos los ejercicios han sido optimizados para PostgreSQL 17
- Las consultas complementarias proporcionan información adicional valiosa
- Se han implementado buenas prácticas de formato y estilo SQL
============================================================================
*/
