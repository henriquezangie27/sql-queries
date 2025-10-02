-- 📊 Ejemplos de Consultas SQL
-- Autor: Angie Henriquez
-- Descripción: Consultas para análisis de ventas y clientes
-- =======================================

-- 1. Seleccionar todos los clientes
SELECT customer_id, first_name, last_name, email
FROM customers;

-- 2. Ventas totales por producto
SELECT product_id, SUM(quantity * price) AS total_sales
FROM sales
GROUP BY product_id
ORDER BY total_sales DESC;

-- 3. Top 5 productos más vendidos
SELECT p.product_name, SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

-- 4. Promedio de ventas por mes
SELECT DATE_TRUNC('month', sale_date) AS month, 
       ROUND(AVG(quantity * price),2) AS avg_sales
FROM sales
GROUP BY month
ORDER BY month;

-- 5. Actualizar el correo electrónico de un cliente
UPDATE customers
SET email = 'nuevoemail@example.com'
WHERE customer_id = 101;

-- 6. Eliminar una venta específica
DELETE FROM sales
WHERE sale_id = 5001;

-- 7. Obtener nombre del cliente y productos comprados
SELECT c.first_name, c.last_name, p.product_name, s.quantity
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
ORDER BY c.last_name

