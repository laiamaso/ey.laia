-- LAB | Classic Models SQL
USE classicmodels;
SHOW TABLES;
-- EJERCICIOS
-- Ejercicio 1
-- Contactos de oficina: Tiene una tabla que contiene los códigos de oficina y sus números de teléfono asociados.

SELECT officecode, phone
FROM offices;

-- Detectives de correo electrónico: ¿Puede identificar a los empleados cuyas direcciones de correo electrónico terminan en “.es”?
select email
from employees
where email like "%.es";

-- Estado de confusión: descubra qué clientes carecen de información estatal en sus registros.
select customername, state
from customers
where state is null;

-- Grandes gastadores: busquemos pagos que superen los $20.000.
select customername, amount
from customers
inner join payments
on customers.customernumber = payments.customernumber
where amount >20000;

-- Grandes gastadores de 2005: Ahora, acote la lista aún más y busque los pagos mayores a $20,000 que se realizaron en el año 2005.
select customername, amount, paymentdate
from customers
inner join payments
on customers.customernumber = payments.customernumber
where amount >20000
and year(paymentdate) = 2005;

-- Detalles distintos: busque y muestre solo las filas únicas de la tabla “orderdetails” en función de la columna “productcode”.
select distinct productcode
from orderdetails;

-- Estadísticas globales de compradores: por último, cree una tabla que muestre el recuento de compras realizadas por país.
SELECT country, COUNT(orderNumber) AS total_compras
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
GROUP BY country;

-- Ejercicio 2
-- Descripción de línea de producto más larga: descubramos qué línea de producto tiene la descripción de texto más larga.
select productline, length(textdescription) as longitud
from productlines 
order by longitud desc
limit 1;

-- Recuento de clientes de oficina: ¿Puede determinar el número de clientes asociados a cada oficina?
SELECT o.officeCode,
o.city,
COUNT(c.customerNumber) AS total_clientes
FROM offices o
LEFT JOIN employees e
ON o.officeCode = e.officeCode
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.officeCode, o.city
ORDER BY total_clientes DESC;

-- Día de mayores ventas de automóviles: descubra qué día de la semana se registra el mayor número de ventas de automóviles.
SELECT DAYNAME(orderDate) AS dia_semana, COUNT(*) AS total_ventas
FROM orders
GROUP BY DAYNAME(orderDate)
ORDER BY total_ventas DESC
LIMIT 1;

-- Corrección de datos territoriales faltantes: Hay algunos valores faltantes (NA) en la variable " territory " de la tabla " offices ". Podemos usar una instrucción "case when" para corregir estos valores y establecerlos en " USA".
SELECT officeCode,
city,
country,
CASE
WHEN territory IS NULL OR territory = 'NA'
THEN 'USA'
ELSE territory
END AS territory_corregido
FROM offices;

-- Estadísticas de empleados de la familia Patterson: calcule el monto promedio del carrito y el total de artículos, año por mes, para las compras realizadas en los años 2004 y 2005 por clientes asistidos por empleados de la familia Patterson.
SELECT
YEAR(o.orderDate) AS año,
MONTH(o.orderDate) AS mes,
AVG(od.quantityOrdered * od.priceEach) AS monto_promedio,
SUM(od.quantityOrdered) AS total_articulos
FROM employees e
INNER JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
WHERE e.lastName = 'Patterson'
AND YEAR(o.orderDate) IN (2004, 2005)
GROUP BY YEAR(o.orderDate), MONTH(o.orderDate)
ORDER BY año, mes;

SELECT
	YEAR(compras.orderDate) AS año,
	MONTH(compras.orderDate) AS mes,
	ROUND(AVG(compras.importe_carrito), 2) AS importe_promedio_carrito,
	SUM(compras.total_articulos) AS total_articulos
FROM (
	SELECT o.orderNumber, o.orderDate, SUM(od.quantityOrdered * od.priceEach) AS importe_carrito, SUM(od.quantityOrdered) AS total_articulos
FROM orders o
	INNER JOIN orderdetails od
		ON o.orderNumber = od.orderNumber
	INNER JOIN customers c
		ON o.customerNumber = c.customerNumber
	INNER JOIN employees e
		ON c.salesRepEmployeeNumber = e.employeeNumber
	WHERE e.lastName = 'Patterson'
		AND YEAR(o.orderDate) IN (2004, 2005)
	GROUP BY o.orderNumber, o.orderDate
) AS compras
GROUP BY YEAR(compras.orderDate), MONTH(compras.orderDate)
ORDER BY año, mes;


SELECT officeCode, city, country, phone
FROM offices
WHERE officeCode IN (
	SELECT DISTINCT e.officeCode
	FROM employees e
	INNER JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	WHERE c.state IS NULL
);