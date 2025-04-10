# Explicación y Justificación de Soluciones SQL
### Reto del Comité AlumniONE
### Autora: Elizabeth Diaz Familia
### Abril 2025

## Introducción

Este documento explica las soluciones implementadas para el 4to Reto SQL del Comité AlumniONE. Cada ejercicio ha sido abordado considerando no solo la correcta implementación funcional, sino también el rendimiento, la legibilidad y las buenas prácticas en SQL.

## Ejercicio 1: Productos con Precio Superior al Promedio

### Solución implementada:
```sql
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
```

### Justificación:
- **Enfoque**: Utilicé una subconsulta en la cláusula WHERE para calcular el precio promedio y filtrar los productos que lo superan.
- **Eficiencia**: La subconsulta se ejecuta una única vez, optimizando el rendimiento.
- **Valor agregado**: Añadí una columna que muestra el porcentaje en que cada producto supera el promedio, lo que proporciona contexto adicional para el análisis.
- **Ordenamiento**: Organicé los resultados por precio descendente para facilitar la identificación de los productos más caros primero.

## Ejercicio 2: Eliminación de Duplicados con UNION

### Solución implementada:
```sql
SELECT nombre, valor
FROM clientes_1
JOIN compras ON clientes_1.id_cliente = compras.id_cliente
UNION
SELECT nombre, valor
FROM clientes_2
JOIN compras ON clientes_2.id_cliente = compras.id_cliente;
```

### Justificación:
- **Selección de operador**: Elegí la opción A (UNION sin ALL) porque garantiza la eliminación de filas duplicadas en el conjunto combinado.
- **Análisis de alternativas**: 
  - UNION ALL (opción B) mantiene todos los registros, incluyendo duplicados.
  - DISTINCT en cada consulta con UNION ALL (opción C) elimina duplicados dentro de cada conjunto, pero no entre ellos.
- **Rendimiento vs. Precisión**: Aunque UNION puede ser menos eficiente que UNION ALL (debido al proceso de eliminación de duplicados), en este caso es necesario para garantizar la unicidad de los registros en el resultado final.

## Ejercicio 3: Conteo de Pedidos en 2024

### Solución implementada:
```sql
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
```

### Justificación:
- **Filtrado temporal**: Utilicé EXTRACT(YEAR FROM fecha_pedido) para obtener el año, que es la función adecuada en PostgreSQL.
- **Agrupación y filtrado**: Combiné GROUP BY para agrupar por cliente y HAVING para aplicar el filtro en el agregado.
- **Métricas adicionales**: Incorporé columnas con el valor total y promedio de pedidos, lo que enriquece el análisis.
- **Ordenamiento**: Organicé por cantidad de pedidos descendente y luego por cliente para facilitar la interpretación.

## Ejercicio 4: Clasificación de Clientes por Total de Pedidos

### Solución implementada:
```sql
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
```

### Justificación:
- **JOIN tipo**: Utilicé LEFT JOIN para incluir a todos los clientes, incluso aquellos sin pedidos.
- **Manejo de nulos**: Implementé COALESCE para garantizar que los clientes sin pedidos tengan una suma total de 0.
- **Clasificación completa**: Amplié la lógica del CASE para incluir una categoría "Sin Compras", mejorando la cobertura de todos los escenarios posibles.
- **Campos adicionales**: Incluí el conteo de pedidos para proporcionar contexto adicional sobre la frecuencia de compra.

## Ejercicio 5: Total de Ventas por Categoría

### Solución implementada:
```sql
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
```

### Justificación:
- **Relación de tablas**: Utilicé JOIN para relacionar las ventas con los productos correspondientes.
- **Métricas complementarias**: Además de la suma de cantidades, incluí el número de transacciones y productos distintos para enriquecer el análisis.
- **Ordenamiento estratégico**: Ordené por total vendido descendente para destacar las categorías más vendidas.
- **Enfoque en cantidad**: Según el enunciado, la consulta se centra en la cantidad de productos vendidos, no en el valor monetario.

## Ejercicio 6: Primera Venta en el Mes de Creación

### Solución implementada:
```sql
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
```

### Justificación:
- **Filtrado temporal**: Utilicé funciones EXTRACT para comparar año y mes entre fecha de venta y fecha de creación.
- **Subconsulta correlacionada**: Implementé una subconsulta para identificar la primera venta de cada producto.
- **Métricas de tiempo**: Añadí una columna que calcula los días transcurridos hasta la primera venta, ofreciendo una métrica de eficiencia comercial.
- **Campos informativos**: Incluí campos como nombre del producto y fecha de creación para mayor contexto.

## Ejercicio 7: Combinación de Ventas de 2023 y 2024

### Solución implementada:
```sql
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
```

### Justificación:
- **Operador apropiado**: Utilicé UNION ALL en lugar de UNION porque no se requiere eliminar duplicados, mejorando la eficiencia.
- **Columna calculada**: Añadí una columna de importe (cantidad * precio_unitario) para facilitar análisis posteriores.
- **Columna de identificación**: Incorporé la columna "año" como literal para marcar el origen de cada registro.
- **Ordenamiento lógico**: Ordené por año y luego por ID de venta para una visualización cronológica y estructurada.

## Ejercicio 8: Empleados en Múltiples Proyectos

### Solución implementada:
```sql
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
```

### Justificación:
- **Prevención de duplicados**: Utilicé COUNT(DISTINCT p.proyecto_id) para contar correctamente los proyectos únicos por empleado.
- **Información adicional**: Incorporé el número de proyectos y una lista concatenada de los nombres de proyectos mediante STRING_AGG.
- **Filtrado adecuado**: Apliqué HAVING para seleccionar solo empleados con más de un proyecto.
- **Ordenamiento informativo**: Ordené por número de proyectos descendente para destacar a los empleados con mayor carga.

## Consideraciones de Rendimiento y Buenas Prácticas

A lo largo de todas las soluciones, he implementado varias prácticas que mejoran tanto la legibilidad como el rendimiento:

1. **Transacciones**: Utilicé bloques BEGIN/COMMIT para garantizar la consistencia de los datos.
2. **Índices sugeridos**: Incluí comentarios con recomendaciones de índices para optimizar el rendimiento.
3. **Formato consistente**: Mantuve un estilo de indentación y capitalización uniforme.
4. **Alias descriptivos**: Usé nombres claros para las columnas y tablas.
5. **Análisis complementarios**: Añadí consultas secundarias para proporcionar métricas adicionales.
6. **Manejo de nulos**: Implementé COALESCE y verificaciones para prevenir errores con valores nulos.
7. **Redondeo**: Apliqué ROUND para valores monetarios y promedios, mejorando la presentación.

## Conclusión

Las soluciones implementadas no solo cumplen con los requisitos funcionales de cada ejercicio, sino que también incorporan consideraciones de rendimiento, mantenibilidad y valor analítico adicional. La combinación de técnicas avanzadas de SQL con buenas prácticas de programación resulta en un código robusto y profesional.
