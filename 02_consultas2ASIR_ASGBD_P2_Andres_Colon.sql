/* Batería de consultas de la práctica */

/* Consulta 1: nombre y precio de los artículos, ordenados por precio descendente */
SELECT nombre, precio
FROM articulos
ORDER BY precio DESC;

/* Consulta 2: nombres de fabricantes cuyo país es Estados Unidos */
SELECT nombre
FROM fabricantes
WHERE LOWER(pais) LIKE 'estados unidos';

/* Consulta 3: artículos con precio entre 100 y 300, ambos incluidos */
SELECT *
FROM articulos
WHERE precio BETWEEN 100 AND 300;

/* Consulta 4: precio medio de los artículos */
SELECT AVG(precio) AS precio_medio
FROM articulos;

/* Consulta 5: identificador de fabricante y número de artículos */
SELECT fabricante_id, COUNT(*) AS numero_articulos
FROM articulos
GROUP BY fabricante_id;

/* Consulta 6: técnicos que han realizado más de una reparación */
SELECT tecnico_id
FROM reparaciones
GROUP BY tecnico_id
HAVING COUNT(*) > 1;

/* Consulta 7: nombre y precio de artículos de fabricantes de Taiwán */
SELECT nombre, precio
FROM articulos
WHERE fabricante_id IN (
    SELECT id
    FROM fabricantes
    WHERE LOWER(pais) LIKE 'taiwán'
);

/* Consulta 8: descripción y coste de la reparación más cara */
SELECT descripcion_averia, coste_reparacion
FROM reparaciones
WHERE coste_reparacion = (
    SELECT MAX(coste_reparacion)
    FROM reparaciones
);

/* Consulta 9: nombre de los técnicos y salario con una subida del 10 % */
SELECT nombre, salario * 1.10 AS salario_con_subida
FROM tecnicos;

/* Consulta 10: nombres de técnicos que no han realizado reparaciones */
SELECT nombre
FROM tecnicos AS t
WHERE NOT EXISTS (
    SELECT 1
    FROM reparaciones AS r
    WHERE r.tecnico_id = t.id
);
