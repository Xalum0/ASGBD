/*Andrés Colón Troya*/

USE PRACTICA2;

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
INSERT INTO tecnicos (id, nombre, especialidad, salario) VALUES
	(5, 'Andres Colon', 'Portátiles', 2100.00);
    
SELECT nombre
from tecnicos
GROUP BY especialidad
HAVING salario > (
    SELECT AVG(salario) 
    FROM tecnicos 
    GROUP BY especialidad);