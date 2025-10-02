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
