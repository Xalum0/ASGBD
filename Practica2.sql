/*Andrés Colón Troya*/

USE PRACTICA2;

/*Apartado2*/

/*Ej01*/
SELECT nombre
FROM articulos
WHERE precio IN (
    SELECT MAX(precio) 
    FROM articulos 
    GROUP BY fabricante_id);

/*Ej02*/
SELECT nombre
FROM fabricantes
WHERE id in (
    SELECT fabricante_id 
    FROM articulos 
    WHERE precio > ( 
        SELECT AVG(precio) 
        FROM articulos));
          
/*Ej03*/
SELECT descripcion_averia, coste_reparacion
FROM reparaciones
WHERE id in (
    SELECT id 
    FROM reparaciones 
    WHERE coste_reparacion > ( 
        SELECT AVG(coste_reparacion) 
        FROM reparaciones) 
        GROUP BY tecnico_id);   

/*Ej04*/
SELECT id, especialidad
FROM tecnicos
WHERE (salario*2) < (
    SELECT SUM(coste_reparacion) as suma_rep 
    FROM reparaciones)
AND id IN (
    SELECT tecnico_id 
    FROM reparaciones 
    GROUP BY tecnico_id);

/*Ej05*/
SELECT nombre
FROM fabricantes
WHERE id IN (
    SELECT fabricante_id 
    FROM articulos 
    GROUP BY fabricante_id
    HAVING COUNT(fabricante_id) = (
        SELECT COUNT(fabricante_id) as conteo 
        FROM articulos  
        GROUP BY fabricante_id 
        HAVING MAX(conteo) = conteo));

/*Ej06*/
SELECT nombre
FROM tecnicos
WHERE id IN (
    SELECT tecnico_id  
    FROM reparaciones)
AND id NOT IN (
    SELECT tecnico_id 
    FROM reparaciones 
    WHERE coste_reparacion > 100);

/*Ej07*/
INSERT INTO tecnicos (id, nombre, especialidad, salario)
VALUES
(5, 'Andres Colon', 'Portátiles', 2100.00);

SELECT nombre, salario
from tecnicos as a
WHERE salario < (
    SELECT AVG(t.salario)
    FROM tecnicos AS b
    WHERE b.especialidad = a.especialidad);

/*Ej08*/
SELECT nombre
FROM fabricantes
WHERE pais IN (
    SELECT a.pais
    FROM fabricantes AS a
    WHERE a.id IN (
        SELECT fabricante_id
        FROM articulos
        WHERE precio = (
            SELECT MAX(precio) 
            FROM articulos)));

/*Ej09*/
SELECT nombre, precio
FROM articulos
WHERE precio = (
    SELECT MIN(a.precio)
    FROM articulos AS a
    WHERE a.fabricante_id IN (
        SELECT id
        FROM fabricantes
        WHERE pais = 'Estados Unidos'));

/*Ej10*/
SELECT tecnico_id
FROM reparaciones
GROUP BY tecnico_id
HAVING SUM(coste_reparacion) >= ALL (
    SELECT SUM(coste_reparacion)
    FROM reparaciones
    GROUP BY tecnico_id);

/*Apartado1*/

/*Ej01*/
SELECT a.nombre as articulo, f.nombre as fabricante
FROM articulos AS a
INNER JOIN fabricantes AS f 
ON a.fabricante_id = f.id
WHERE a.precio > 100;

/*Ej02*/
SELECT f.nombre as fabricante, a.nombre as articulo
FROM fabricantes AS f
LEFT JOIN articulos AS a 
ON a.fabricante_id = f.id;

/*Ej03*/
SELECT f.nombre as fabricante, AVG(a.precio) as media_precio
FROM fabricantes AS f
INNER JOIN articulos AS a 
ON a.fabricante_id = f.id
GROUP BY f.id, f.nombre
HAVING AVG(a.precio) > 150;

/*Ej04*/
SELECT r.descripcion_averia, r.coste_reparacion, t.nombre as tecnico
FROM reparaciones AS r
INNER JOIN tecnicos AS t 
ON r.tecnico_id = t.id
ORDER BY r.coste_reparacion DESC;

/*Ej05*/
SELECT t.nombre
FROM tecnicos AS t
LEFT JOIN reparaciones AS r 
ON r.tecnico_id = t.id
WHERE r.id IS NULL;

/*Ej06*/
SELECT t.nombre, SUM(r.coste_reparacion) as total_recaudado
FROM tecnicos AS t
INNER JOIN reparaciones AS r 
ON r.tecnico_id = t.id
GROUP BY t.id, t.nombre
HAVING SUM(r.coste_reparacion) > 100;

/*Ej07*/
SELECT a.nombre as articulo, f.nombre as fabricante
FROM articulos AS a
INNER JOIN fabricantes AS f 
ON a.fabricante_id = f.id
WHERE f.pais IN ('Estados Unidos', 'Taiwán');

/*Ej08*/
SELECT t.nombre, COUNT(r.id) as num_reparaciones
FROM tecnicos AS t
LEFT JOIN reparaciones AS r 
ON r.tecnico_id = t.id
GROUP BY t.id, t.nombre;

/*Ej09*/
SELECT f.nombre as fabricante, COUNT(a.id) as num_articulos
FROM fabricantes AS f
INNER JOIN articulos AS a
ON a.fabricante_id = f.id
GROUP BY f.id, f.nombre
HAVING COUNT(a.id) >= 2;

/*Ej10*/
SELECT t.nombre, t.especialidad, r.descripcion_averia
FROM tecnicos AS t
INNER JOIN reparaciones AS r 
ON r.tecnico_id = t.id
WHERE r.coste_reparacion = (
    SELECT MAX(r2.coste_reparacion)
    FROM reparaciones AS r2
    WHERE r2.tecnico_id = t.id);
