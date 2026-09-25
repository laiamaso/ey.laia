-- 1. Selecciona todos los clientes.
select * 
from clientes;

-- 2. Selecciona todos los empleados.
select *
from empleados;

-- 3. Selecciona todas las tiendas.
select *
from tiendas;

-- 4. Selecciona todas las prendas de ropa.
select tipo_prenda as Prendas
from prendas;

-- 5. Busca clientes cuyo nombre comience con la letra "L".
select *
from clientes
where nombre_cliente like "L%";

-- 6. Cuenta cuántos clientes hay en la base de datos.
select count(*) as nºclientes
from clientes;

-- 7. Selecciona las compras realizadas después del 1 de mayo de 2023.
select *
from compras
where fecha_compra >'2023-05-01';

-- 8. Actualiza el correo electrónico de un cliente específico.
UPDATE clientes
SET email_cliente = 'laura.nuevo@email.com'
WHERE id_cliente = 2;

-- 9. Elimina un cliente por su ID.
DELETE FROM Clientes
WHERE id_cliente = 3;

-- 10. Selecciona las prendas de color Negro.
select *
from prendas
where color = "Negro";

-- 11. Selecciona todas las tiendas que hay en Madrid.
select * 
from tiendas
where ciudad = "Madrid";

-- 12. Cuenta cuántas prendas tienen un precio mayor a 50.
select count(*) as nºprendas
from prendas
where precio >50;

-- 13. Selecciona los empleados que trabajan en la tienda con ID 1.
select nombre_empleado
from empleados
where id_empleado = 1;

-- 14. Busca clientes cuyo nombre contenga "Andrés".
select*
from clientes
where nombre_cliente ="Andrés";

-- 15. Selecciona las compras realizadas por el cliente con ID 2.
select *
from compras
where id_cliente = 2;

-- 16. Elimina todas las compras cuyo monto sea menor a 30.
select *
from compras
where monto_total < 30; 

-- 17. Selecciona las prendas cuyo precio esté entre 20 y 40.
SELECT *
FROM Prendas
WHERE precio BETWEEN 20 AND 40;

-- 18. Busca empleados cuyo nombre contenga la letra "a".
SELECT *
FROM Empleados
WHERE nombre_empleado LIKE '%a%';

-- 19. Selecciona las 5 prendas más caras.
SELECT *
FROM Prendas
ORDER BY precio DESC
LIMIT 5;

-- 20. Selecciona las compras de un cliente con un monto superior a 75.
SELECT *
FROM Compras
WHERE monto_total > 75;

-- 21. Selecciona las prendas de talla M.
SELECT *
FROM Prendas
WHERE talla = 'M';

-- 22. Actualiza la talla de una prenda específica por su ID.
UPDATE Prendas
SET talla = 'XL'
WHERE id_prenda = 1;

-- 23. Selecciona todos los empleados contratados después del 1 de enero de 2022.
SELECT *
FROM Empleados
WHERE fecha_contratacion > '2022-01-01';

-- 24. Busca tiendas en "Barcelona".
SELECT *
FROM Tiendas
WHERE ciudad = 'Barcelona';

-- 25. Elimina un empleado por su ID.
DELETE FROM Empleados
WHERE id_empleado = 3;

-- 26. Selecciona las compras que se realizaron antes del 1 de julio de 2023.
SELECT *
FROM Compras
WHERE fecha_compra < '2023-07-01';

-- 27. Busca prendas cuyo nombre termine en "eta".
SELECT *
FROM Prendas
WHERE tipo_prenda LIKE '%eta';

-- 28. Selecciona los clientes que no tengan un email registrado con "hotmail".
select *
FROM Clientes
WHERE email_cliente NOT LIKE '%hotmail%';

-- 29. Cuenta cuántas compras se realizaron en septiembre de 2023.
select count(*)
from compras
where fecha_compra BETWEEN '2023-09-01' AND '2023-09-30';

-- 30. Actualiza la dirección de una tienda por su ID.
UPDATE Tiendas
SET direccion = 'Nueva Dirección, 123'
WHERE id_tienda = 2;

-- 31. Selecciona las prendas que sean camisetas.
SELECT *
FROM Prendas
WHERE tipo_prenda = 'Camiseta';

-- 32. Elimina todas las prendas cuyo precio sea menor a 20.
DELETE FROM Prendas
WHERE precio < 20;

-- 33. Selecciona todas las tiendas y ordénalas por ciudad.
SELECT *
FROM Tiendas
ORDER BY ciudad;

-- 34. Selecciona los empleados que sean vendedores.
SELECT *
FROM Empleados
WHERE puesto = 'Vendedor';

-- 35. Cuenta cuántas prendas son de color blanco.
select count(*) as prendas_blancas
from prendas
where color = "blanco";

-- 36. Selecciona los clientes que tengan nombres de más de 10 caracteres.
select * 
from clientes
where char_length(nombre_cliente) >10;

-- 37. Busca compras cuyo monto total esté entre 50 y 100.
SELECT *
FROM Compras
WHERE monto_total BETWEEN 50 AND 100;

-- 38. Selecciona las 3 compras más recientes.
SELECT *
FROM Compras
ORDER BY fecha_compra DESC
LIMIT 3;

-- 39. Busca cursos cuyo nombre contenga la palabra "Digital".
select *
from cursos
where nombre_curso like "Digital";

-- 40. Agrupa las prendas por color y cuenta cuántas hay de cada color.
SELECT color, COUNT(*) AS cantidad
FROM Prendas
GROUP BY color;

-- 41. Añade dos tiendas más que existan en Madrid y no estén en la base de datos.
INSERT INTO Tiendas (nombre_tienda, direccion, ciudad, pais)
VALUES
('Zara Plaza Mayor', 'Plaza Mayor, 15', 'Madrid', 'España'),
('Zara Serrano', 'Calle Serrano, 45', 'Madrid', 'España');

-- 42. El cliente Miguel Torres se ha hecho trans y ha pedido que le cambien el nombre a Micaela. Actualiza también su e-mail.
UPDATE Clientes
SET nombre_cliente = 'Micaela Torres',
email_cliente = 'micaela.torres@email.com'
WHERE nombre_cliente = 'Miguel Torres';