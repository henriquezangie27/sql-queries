--=======================================
-- 📊 Ejemplos de Consultas SQL
-- Autora: Angie Henriquez
-- Descripción: Consultas optimizadas para análisis de ventas y clientes
--=======================================

-- 1. Seleccionar información básica de los clientes
SELECT 
    id_cliente, 
    nombre, 
    apellido, 
    correo_electronico
FROM clientes;


-- 2. Ventas totales por producto (Ordenado de mayor a menor)
SELECT 
    id_producto,
    SUM(cantidad * precio) AS ventas_totales
FROM ventas
GROUP BY id_producto
ORDER BY ventas_totales DESC;


-- 3. Top 5 productos más vendidos (Incluye nombres de productos)
SELECT 
    p.nombre_producto,
    SUM(v.cantidad) AS cantidad_total
FROM ventas AS v
INNER JOIN productos AS p ON v.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY cantidad_total DESC
LIMIT 5;


-- 4. Promedio de ventas por mes
SELECT 
    DATE_TRUNC('month', fecha_venta) AS mes,
    ROUND(AVG(cantidad * precio), 2) AS promedio_ventas
FROM ventas
GROUP BY DATE_TRUNC('month', fecha_venta)
ORDER BY mes ASC;


-- 5. Actualizar el correo electrónico de un cliente específico
UPDATE clientes
SET correo_electronico = 'nuevoemail@example.com'
WHERE id_cliente = 101;


-- 6. Eliminar una venta específica por ID
DELETE FROM ventas
WHERE id_venta = 5001;


-- 7. Historial de compras: Clientes y productos adquiridos
SELECT 
    c.nombre,
    c.apellido,
    p.nombre_producto,
    v.cantidad
FROM ventas AS v
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p ON v.id_producto = p.id_producto
ORDER BY c.apellido ASC, c.nombre ASC;


