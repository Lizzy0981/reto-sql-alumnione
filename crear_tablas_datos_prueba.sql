-- ============================================================================
-- SCRIPT DE CREACIÓN DE TABLAS Y DATOS DE PRUEBA PARA RETO SQL ALUMNIONE
-- ============================================================================
-- Autor: Elizabeth Diaz Familia
-- Motor de base de datos: PostgreSQL 17
-- Fecha: Abril 2025
-- ============================================================================

-- Eliminamos tablas si existen para evitar conflictos
DROP TABLE IF EXISTS proyectos CASCADE;
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS ventas_2024 CASCADE;
DROP TABLE IF EXISTS venta_2023 CASCADE;
DROP TABLE IF EXISTS ventas CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS compras CASCADE;
DROP TABLE IF EXISTS clientes_1 CASCADE;
DROP TABLE IF EXISTS clientes_2 CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- Configuración para evitar mensajes de aviso
SET client_min_messages TO warning;

-- ============================================================================
-- CREACIÓN DE TABLAS
-- ============================================================================

-- Tabla Productos
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Pedidos
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    fecha_pedido TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL
);

-- Tabla Ventas
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    producto_id INT REFERENCES productos(id_producto),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha_venta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Venta_2023
CREATE TABLE venta_2023 (
    venta_id SERIAL PRIMARY KEY,
    producto_id INT REFERENCES productos(id_producto),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    fecha_venta TIMESTAMP NOT NULL
);

-- Tabla Ventas_2024
CREATE TABLE ventas_2024 (
    venta_id SERIAL PRIMARY KEY,
    producto_id INT REFERENCES productos(id_producto),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    fecha_venta TIMESTAMP NOT NULL
);

-- Tabla Empleados
CREATE TABLE empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_contratacion DATE NOT NULL
);

-- Tabla Proyectos
CREATE TABLE proyectos (
    proyecto_id SERIAL PRIMARY KEY,
    empleado_id INT REFERENCES empleados(empleado_id),
    nombre_proyecto VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Tablas para el ejercicio de UNION
CREATE TABLE clientes_1 (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE clientes_2 (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE compras (
    id_compra SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

-- ============================================================================
-- DATOS DE PRUEBA: PRODUCTOS
-- ============================================================================
INSERT INTO productos (nombre, precio, categoria, fecha_creacion) VALUES
('Smartphone XYZ', 699.99, 'Electrónica', '2023-06-15 10:30:00'),
('Laptop Pro', 1299.99, 'Electrónica', '2023-06-15 09:45:00'),
('Auriculares Bluetooth', 89.99, 'Electrónica', '2023-07-20 14:15:00'),
('Smartwatch Fit', 199.99, 'Electrónica', '2023-08-05 11:20:00'),
('Tablet Ultra', 499.99, 'Electrónica', '2023-09-10 15:30:00'),
('Camiseta Casual', 29.99, 'Ropa', '2023-05-12 08:45:00'),
('Pantalón Jeans', 49.99, 'Ropa', '2023-05-18 13:10:00'),
('Zapatillas Running', 79.99, 'Calzado', '2023-06-25 09:30:00'),
('Zapatillas Casual', 69.99, 'Calzado', '2023-07-15 10:45:00'),
('Bolso Elegante', 59.99, 'Accesorios', '2023-08-20 14:20:00'),
('Gafas de Sol', 39.99, 'Accesorios', '2023-09-05 16:15:00'),
('Reloj Analógico', 129.99, 'Accesorios', '2023-10-10 11:50:00'),
('Libro Bestseller', 19.99, 'Libros', '2023-05-05 09:15:00'),
('Comic Edición Especial', 24.99, 'Libros', '2023-06-10 10:30:00'),
('Juego de Mesa', 34.99, 'Juegos', '2023-07-12 15:45:00'),
('Consola de Videojuegos', 399.99, 'Electrónica', '2023-08-18 13:20:00'),
('Televisor 4K', 899.99, 'Electrónica', '2023-09-22 14:10:00'),
('Altavoz Inalámbrico', 149.99, 'Electrónica', '2023-10-15 12:30:00'),
('Cámara Digital', 549.99, 'Electrónica', '2023-11-05 10:15:00'),
('Teclado Mecánico', 89.99, 'Informática', '2023-12-10 09:45:00'),
('Ratón Ergonómico', 49.99, 'Informática', '2023-12-15 11:30:00'),
('Monitor Curvo', 349.99, 'Informática', '2024-01-05 14:20:00'),
('Impresora Multifunción', 199.99, 'Informática', '2024-01-20 15:10:00'),
('Disco Duro Externo', 119.99, 'Informática', '2024-02-15 10:30:00'),
('Mochila Portátil', 59.99, 'Accesorios', '2024-02-28 13:45:00'),
('Maleta de Viaje', 129.99, 'Viaje', '2024-03-10 09:20:00'),
('Kit de Cocina', 89.99, 'Hogar', '2024-03-20 11:15:00'),
('Set de Sartenes', 79.99, 'Hogar', '2024-03-25 15:30:00'),
('Cafetera Automática', 159.99, 'Hogar', '2024-03-30 10:45:00'),
('Batidora Eléctrica', 69.99, 'Hogar', '2024-04-05 14:20:00');

-- ============================================================================
-- DATOS DE PRUEBA: CLIENTES
-- ============================================================================
INSERT INTO clientes (nombre, email, fecha_registro) VALUES
('Ana García', 'ana.garcia@example.com', '2023-03-10 09:15:00'),
('Carlos Rodríguez', 'carlos.rodriguez@example.com', '2023-03-15 14:30:00'),
('Laura Fernández', 'laura.fernandez@example.com', '2023-04-05 11:45:00'),
('Miguel López', 'miguel.lopez@example.com', '2023-04-12 16:20:00'),
('Sofía Martínez', 'sofia.martinez@example.com', '2023-05-02 10:10:00'),
('Javier Sánchez', 'javier.sanchez@example.com', '2023-05-18 13:25:00'),
('Elena Díaz', 'elena.diaz@example.com', '2023-06-03 15:40:00'),
('David Pérez', 'david.perez@example.com', '2023-06-20 12:05:00'),
('Carmen Ruiz', 'carmen.ruiz@example.com', '2023-07-05 09:50:00'),
('Antonio Jiménez', 'antonio.jimenez@example.com', '2023-07-15 14:15:00'),
('Isabel Moreno', 'isabel.moreno@example.com', '2023-08-01 11:30:00'),
('Pablo Álvarez', 'pablo.alvarez@example.com', '2023-08-22 16:45:00'),
('María Gutiérrez', 'maria.gutierrez@example.com', '2023-09-10 10:20:00'),
('Roberto Muñoz', 'roberto.munoz@example.com', '2023-09-25 13:35:00'),
('Lucía Romero', 'lucia.romero@example.com', '2023-10-08 15:50:00'),
('Alejandro Torres', 'alejandro.torres@example.com', '2023-10-20 12:15:00'),
('Silvia Ortiz', 'silvia.ortiz@example.com', '2023-11-05 09:40:00'),
('Daniel Ramos', 'daniel.ramos@example.com', '2023-11-18 14:55:00'),
('Raquel Castro', 'raquel.castro@example.com', '2023-12-03 11:10:00'),
('Francisco Vargas', 'francisco.vargas@example.com', '2023-12-15 16:25:00');

-- ============================================================================
-- DATOS DE PRUEBA: PEDIDOS
-- ============================================================================
-- Pedidos para 2024 (con diferentes cantidades por cliente)
INSERT INTO pedidos (id_cliente, fecha_pedido, total) VALUES
-- Cliente 1 (Ana García) - 8 pedidos
(1, '2024-01-05 10:25:00', 699.99),
(1, '2024-01-15 14:40:00', 119.98),
(1, '2024-01-30 11:15:00', 199.99),
(1, '2024-02-10 15:30:00', 89.99),
(1, '2024-02-25 13:20:00', 149.99),
(1, '2024-03-05 09:45:00', 79.99),
(1, '2024-03-15 16:10:00', 59.99),
(1, '2024-03-30 12:05:00', 39.99),

-- Cliente 2 (Carlos Rodríguez) - 6 pedidos
(2, '2024-01-08 11:30:00', 1299.99),
(2, '2024-01-25 15:45:00', 199.99),
(2, '2024-02-12 13:15:00', 149.99),
(2, '2024-02-28 09:40:00', 89.99),
(2, '2024-03-12 14:20:00', 79.99),
(2, '2024-03-28 10:35:00', 59.99),

-- Cliente 3 (Laura Fernández) - 7 pedidos
(3, '2024-01-10 13:50:00', 499.99),
(3, '2024-01-20 09:15:00', 149.99),
(3, '2024-02-05 14:30:00', 129.99),
(3, '2024-02-20 11:45:00', 89.99),
(3, '2024-03-01 16:10:00', 69.99),
(3, '2024-03-18 12:25:00', 49.99),
(3, '2024-04-02 15:40:00', 29.99),

-- Cliente 4 (Miguel López) - 4 pedidos
(4, '2024-01-12 15:20:00', 899.99),
(4, '2024-02-15 12:35:00', 199.99),
(4, '2024-03-10 09:50:00', 129.99),
(4, '2024-03-25 14:15:00', 89.99),

-- Cliente 5 (Sofía Martínez) - 6 pedidos
(5, '2024-01-05 09:30:00', 399.99),
(5, '2024-01-18 14:45:00', 149.99),
(5, '2024-02-03 11:00:00', 89.99),
(5, '2024-02-22 16:15:00', 69.99),
(5, '2024-03-08 12:30:00', 49.99),
(5, '2024-03-22 15:45:00', 34.99),

-- Otros clientes con menos pedidos
(6, '2024-01-07 10:10:00', 549.99),
(6, '2024-02-10 15:25:00', 199.99),
(7, '2024-01-22 13:40:00', 349.99),
(7, '2024-02-18 09:55:00', 129.99),
(8, '2024-01-14 15:05:00', 499.99),
(8, '2024-03-05 11:20:00', 89.99),
(9, '2024-02-01 16:35:00', 399.99),
(9, '2024-03-20 12:50:00', 79.99),
(10, '2024-01-28 14:00:00', 299.99),
(11, '2024-02-07 10:15:00', 249.99),
(12, '2024-03-15 15:30:00', 199.99),
(13, '2024-01-17 11:45:00', 179.99),
(14, '2024-02-14 16:00:00', 159.99),
(15, '2024-03-12 12:15:00', 139.99);

-- Pedidos para 2023 (para comparativa)
INSERT INTO pedidos (id_cliente, fecha_pedido, total) VALUES
(1, '2023-06-10 13:20:00', 599.99),
(1, '2023-08-15 09:35:00', 149.99),
(1, '2023-10-20 14:50:00', 129.99),
(2, '2023-05-25 11:05:00', 1099.99),
(2, '2023-07-30 16:20:00', 179.99),
(2, '2023-09-05 12:35:00', 99.99),
(3, '2023-06-20 15:45:00', 299.99),
(3, '2023-08-25 11:00:00', 119.99),
(3, '2023-10-30 16:15:00', 79.99),
(4, '2023-07-05 12:30:00', 799.99),
(4, '2023-09-10 15:45:00', 169.99),
(5, '2023-06-15 09:50:00', 349.99),
(5, '2023-08-20 14:05:00', 129.99),
(6, '2023-07-25 10:20:00', 449.99),
(7, '2023-09-30 15:35:00', 249.99),
(8, '2023-06-05 11:50:00', 399.99),
(9, '2023-08-10 16:05:00', 299.99),
(10, '2023-10-15 12:20:00', 199.99);

-- ============================================================================
-- DATOS DE PRUEBA: VENTAS
-- ============================================================================
-- Ventas para varios productos en diferentes fechas
INSERT INTO ventas (producto_id, cantidad, fecha_venta) VALUES
-- Ventas para productos recién creados (mismo mes)
(1, 2, '2023-06-15 14:30:00'), -- Smartphone XYZ (mismo día)
(2, 1, '2023-06-16 10:15:00'), -- Laptop Pro (día siguiente)
(3, 3, '2023-07-20 16:45:00'), -- Auriculares Bluetooth (mismo día)
(4, 2, '2023-08-06 12:30:00'), -- Smartwatch Fit (día siguiente)
(5, 1, '2023-09-10 17:20:00'), -- Tablet Ultra (mismo día)

-- Más ventas para otros productos
(6, 5, '2023-05-14 09:45:00'),
(7, 3, '2023-05-20 15:10:00'),
(8, 2, '2023-06-27 11:25:00'),
(9, 4, '2023-07-18 13:40:00'),
(10, 2, '2023-08-22 16:15:00'),
(11, 6, '2023-09-08 10:30:00'),
(12, 1, '2023-10-12 14:45:00'),
(13, 7, '2023-05-07 12:00:00'),
(14, 3, '2023-06-12 16:15:00'),
(15, 2, '2023-07-15 11:30:00'),
(16, 1, '2023-08-20 15:45:00'),
(17, 2, '2023-09-25 13:00:00'),
(18, 3, '2023-10-18 17:15:00'),
(19, 1, '2023-11-08 12:30:00'),
(20, 4, '2023-12-12 16:45:00'),

-- Ventas en 2024
(21, 2, '2024-01-05 14:00:00'),
(22, 1, '2024-01-22 10:15:00'),
(23, 3, '2024-02-18 15:30:00'),
(24, 2, '2024-02-25 11:45:00'),
(25, 4, '2024-03-12 16:00:00'),
(26, 1, '2024-03-20 12:15:00'),
(27, 2, '2024-03-28 17:30:00'),
(28, 3, '2024-04-05 13:45:00'),
(29, 1, '2024-04-10 18:00:00'),
(30, 2, '2024-04-15 14:15:00');

-- ============================================================================
-- DATOS DE PRUEBA: VENTAS 2023
-- ============================================================================
INSERT INTO venta_2023 (producto_id, cantidad, precio_unitario, fecha_venta) VALUES
(1, 5, 699.99, '2023-03-15 10:30:00'),
(2, 2, 1299.99, '2023-03-20 14:45:00'),
(3, 8, 89.99, '2023-04-05 11:15:00'),
(4, 3, 199.99, '2023-04-18 15:30:00'),
(5, 1, 499.99, '2023-05-02 12:00:00'),
(6, 10, 29.99, '2023-05-15 09:45:00'),
(7, 6, 49.99, '2023-06-01 13:30:00'),
(8, 4, 79.99, '2023-06-12 16:15:00'),
(9, 7, 69.99, '2023-07-05 10:45:00'),
(10, 3, 59.99, '2023-07-20 14:30:00'),
(11, 5, 39.99, '2023-08-03 11:15:00'),
(12, 2, 129.99, '2023-08-18 15:45:00'),
(13, 15, 19.99, '2023-09-01 12:30:00'),
(14, 8, 24.99, '2023-09-15 16:00:00'),
(15, 6, 34.99, '2023-10-01 10:15:00'),
(16, 2, 399.99, '2023-10-15 14:45:00'),
(17, 1, 899.99, '2023-11-01 11:30:00'),
(18, 4, 149.99, '2023-11-18 15:15:00'),
(19, 2, 549.99, '2023-12-03 12:00:00'),
(20, 5, 89.99, '2023-12-18 09:45:00');

-- ============================================================================
-- DATOS DE PRUEBA: VENTAS 2024
-- ============================================================================
INSERT INTO ventas_2024 (producto_id, cantidad, precio_unitario, fecha_venta) VALUES
(1, 7, 699.99, '2024-01-05 11:15:00'),
(2, 3, 1299.99, '2024-01-20 15:30:00'),
(3, 12, 89.99, '2024-02-05 12:00:00'),
(4, 5, 199.99, '2024-02-20 09:45:00'),
(5, 2, 499.99, '2024-03-05 13:30:00'),
(6, 15, 29.99, '2024-03-20 16:15:00'),
(7, 9, 49.99, '2024-01-10 10:45:00'),
(8, 6, 79.99, '2024-01-25 14:30:00'),
(9, 10, 69.99, '2024-02-10 11:15:00'),
(10, 4, 59.99, '2024-02-25 15:45:00'),
(11, 7, 39.99, '2024-03-10 12:30:00'),
(12, 3, 129.99, '2024-03-25 16:00:00'),
(13, 20, 19.99, '2024-01-15 10:15:00'),
(14, 12, 24.99, '2024-01-30 14:45:00'),
(15, 8, 34.99, '2024-02-15 11:30:00'),
(16, 3, 399.99, '2024-02-28 15:15:00'),
(17, 2, 899.99, '2024-03-15 12:00:00'),
(18, 6, 149.99, '2024-03-30 09:45:00'),
(19, 3, 549.99, '2024-01-08 13:30:00'),
(20, 7, 89.99, '2024-01-22 16:15:00'),
(21, 4, 49.99, '2024-02-08 10:45:00'),
(22, 2, 349.99, '2024-02-22 14:30:00'),
(23, 5, 199.99, '2024-03-08 11:15:00'),
(24, 3, 119.99, '2024-03-22 15:45:00'),
(25, 6, 59.99, '2024-04-05 12:30:00'),
(26, 2, 129.99, '2024-04-10 16:00:00');

-- ============================================================================
-- DATOS DE PRUEBA: EMPLEADOS Y PROYECTOS
-- ============================================================================
-- Empleados
INSERT INTO empleados (nombre, email, fecha_contratacion) VALUES
('Juan Pérez', 'juan.perez@empresa.com', '2023-01-15'),
('María Gómez', 'maria.gomez@empresa.com', '2023-01-15'),
('Roberto Fernández', 'roberto.fernandez@empresa.com', '2023-02-01'),
('Ana Martínez', 'ana.martinez@empresa.com', '2023-02-15'),
('Carlos López', 'carlos.lopez@empresa.com', '2023-03-01'),
('Laura Sánchez', 'laura.sanchez@empresa.com', '2023-03-15'),
('Miguel Rodríguez', 'miguel.rodriguez@empresa.com', '2023-04-01'),
('Sofía Díaz', 'sofia.diaz@empresa.com', '2023-04-15'),
('Javier Ruiz', 'javier.ruiz@empresa.com', '2023-05-01'),
('Elena Castro', 'elena.castro@empresa.com', '2023-05-15');

-- Proyectos (algunos empleados en múltiples proyectos)
INSERT INTO proyectos (empleado_id, nombre_proyecto, fecha_inicio, fecha_fin) VALUES
(1, 'Proyecto A', '2023-02-01', '2023-06-30'),
(1, 'Proyecto B', '2023-07-01', '2023-12-31'),
(1, 'Proyecto E', '2024-01-01', NULL),
(2, 'Proyecto A', '2023-02-01', '2023-06-30'),
(2, 'Proyecto C', '2023-07-01', '2023-12-31'),
(3, 'Proyecto B', '2023-03-01', '2023-08-31'),
(3, 'Proyecto D', '2023-09-01', '2024-02-29'),
(4, 'Proyecto C', '2023-03-15', '2023-09-15'),
(5, 'Proyecto D', '2023-04-01', '2023-10-31'),
(5, 'Proyecto E', '2023-11-01', NULL),
(6, 'Proyecto A', '2023-04-15', '2023-10-15'),
(7, 'Proyecto B', '2023-05-01', '2023-11-30'),
(7, 'Proyecto C', '2023-12-01', NULL),
(8, 'Proyecto D', '2023-05-15', '2023-11-30'),
(9, 'Proyecto E', '2023-06-01', NULL);
-- Empleado 10 no tiene proyectos asignados

-- ============================================================================
-- DATOS DE PRUEBA: CLIENTES Y COMPRAS PARA EJERCICIO UNION
-- ============================================================================
-- Clientes tabla 1
INSERT INTO clientes_1 (nombre) VALUES
('Ana García'),
('Carlos Rodríguez'),
('Laura Fernández'),
('Miguel López'),
('Sofía Martínez');

-- Clientes tabla 2
INSERT INTO clientes_2 (nombre) VALUES
('Ana García'), -- Duplicado intencional
('Javier Sánchez'),
('Elena Díaz'),
('David Pérez'),
('Sofía Martínez'); -- Duplicado intencional

-- Compras
INSERT INTO compras (id_cliente, valor) VALUES
(1, 150.00),
(1, 200.00),
(2, 300.00),
(3, 120.00),
(4, 250.00),
(5, 180.00),
(6, 220.00),
(7, 190.00),
(8, 280.00),
(9, 210.00);

-- ============================================================================
-- DATOS DE PRUEBA: CATEGORÍAS DUPLICADAS PARA EJERCICIO 2
-- ============================================================================
CREATE TABLE categories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- Insertar categorías incluyendo duplicados para el ejercicio 2
INSERT INTO categories (CategoryName) VALUES
('Electrónica'),
('Electrónica'), -- Duplicado intencional
('Ropa'),
('Calzado'),
('Accesorios'),
('Libros'),
('Libros'), -- Duplicado intencional
('Hogar'),
('Juegos'),
('Informática'),
('Viaje'),
('Deporte'),
('Deporte'); -- Duplicado intencional

-- ============================================================================
-- CONFIRMACIÓN FINAL
-- ============================================================================
SELECT 'Todas las tablas y datos de prueba creados con éxito.' AS mensaje;

-- Mostrar contadores de datos insertados
SELECT 'productos' AS tabla, COUNT(*) AS registros FROM productos UNION ALL
SELECT 'clientes', COUNT(*) FROM clientes UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos UNION ALL
SELECT 'ventas', COUNT(*) FROM ventas UNION ALL
SELECT 'venta_2023', COUNT(*) FROM venta_2023 UNION ALL
SELECT 'ventas_2024', COUNT(*) FROM ventas_2024 UNION ALL
SELECT 'empleados', COUNT(*) FROM empleados UNION ALL
SELECT 'proyectos', COUNT(*) FROM proyectos UNION ALL
SELECT 'categories', COUNT(*) FROM categories;
