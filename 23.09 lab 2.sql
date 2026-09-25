-- PREGUNTAS
-- ¿Cuál es la cantidad total que gastó cada cliente en el restaurante?
select customer_id, sum(price)
from sales
inner join menu
on sales.product_id = menu.product_id
group by customer_id;

-- ¿Cuántos días ha visitado cada cliente el restaurante?
SELECT
customer_id,
COUNT(DISTINCT order_date) AS dias_visitados
FROM sales
GROUP BY customer_id;

-- ¿Cuál fue el primer artículo del menú comprado por cada cliente?
SELECT s.customer_id, m.product_name
FROM sales s
INNER JOIN menu m
	ON s.product_id = m.product_id
WHERE (s.customer_id, s.order_date) IN (
	SELECT
	customer_id,
	MIN(order_date)
	FROM sales
	GROUP BY customer_id
);

-- ¿Cuál es el artículo más comprado en el menú y cuántas veces lo compraron todos los clientes?
SELECT m.product_name, COUNT(*) AS veces_comprado
FROM sales s
INNER JOIN menu m
ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY veces_comprado DESC
LIMIT 1;

-- ¿Qué artículo fue el más popular para cada cliente?
select customer_id, product_name, count(*) as total
from sales
inner join menu
on sales.product_id = menu.product_id
group by sales.customer_id, menu.product_name
order by sales.customer_id, total desc;

-- ¿Qué artículo compró primero el cliente después de convertirse en miembro?
SELECT s.customer_id, m.product_name, s.order_date
FROM sales s
JOIN members mem
ON s.customer_id = mem.customer_id
JOIN menu m
ON s.product_id = m.product_id
WHERE s.order_date >= mem.join_date
AND (s.customer_id, s.order_date) IN (
SELECT s.customer_id, MIN(s.order_date)
FROM sales s
JOIN members mem
ON s.customer_id = mem.customer_id
WHERE s.order_date >= mem.join_date
GROUP BY s.customer_id
);

-- ¿Qué artículo se compró justo antes de que el cliente se convirtiera en miembro?
SELECT
s.customer_id,
m.product_name,
s.order_date
FROM sales s
JOIN members mem
ON s.customer_id = mem.customer_id
JOIN menu m
ON s.product_id = m.product_id
WHERE s.order_date < mem.join_date
AND (s.customer_id, s.order_date) IN (
SELECT
s.customer_id,
MAX(s.order_date)
FROM sales s
JOIN members mem
ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id
);

-- ¿Cuál es el total de artículos y la cantidad gastada por cada miembro antes de convertirse en miembro?
SELECT s.customer_id,
COUNT(*) AS total_articulos,
SUM(m.price) AS total_gastado
FROM sales s
JOIN members mem
ON s.customer_id = mem.customer_id
JOIN menu m
ON s.product_id = m.product_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id;

-- Si cada $1 gastado equivale a 10 puntos y el sushi tiene un multiplicador de puntos 2x, ¿Cuántos puntos tendría cada cliente?
SELECT 
	s.customer_id,
	SUM(
		CASE
			WHEN m.product_name = 'sushi'
				THEN m.price * 20
			ELSE m.price * 10
		END
	) AS puntos
FROM sales s
JOIN menu m
	ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- En la primera semana después de que un cliente se une al programa (incluida la fecha de ingreso), gana el doble de puntos en todos los artículos, no solo en sushi. ¿Cuántos puntos tienen los clientes A y B a fines de enero?
SELECT s.customer_id,
SUM(
	CASE
		WHEN s.order_date BETWEEN mem.join_date
			AND DATE_ADD(mem.join_date, INTERVAL 6 DAY)
			THEN m.price * 20
		WHEN m.product_name = 'sushi'
			THEN m.price * 20
		ELSE m.price * 10
	END
	) AS puntos
FROM sales s
JOIN members mem
	ON s.customer_id = mem.customer_id
JOIN menu m
	ON s.product_id = m.product_id
WHERE s.order_date <= '2021-01-31'
GROUP BY s.customer_id;

-- Suposición: Solo los clientes que son miembros reciben puntos al comprar artículos, los puntos los reciben en las órdenes iguales o posteriores a la fecha en la que se convierten en miembros. Solo las órdenes de la primera semana en la que se convierten en miembros suman 20 puntos para todos los artículos.
SELECT s.customer_id,
	SUM(
		CASE
			WHEN s.order_date BETWEEN mem.join_date
				AND DATE_ADD(mem.join_date, INTERVAL 6 DAY)
				THEN m.price * 20
			ELSE 0
		END
	) AS total_puntos
FROM sales s
INNER JOIN members mem
	ON s.customer_id = mem.customer_id
INNER JOIN menu m
	ON s.product_id = m.product_id
WHERE s.order_date >= mem.join_date
GROUP BY s.customer_id;
