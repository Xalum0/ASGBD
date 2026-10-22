/*
    Creación de la base de datos, tablas e inserción de los datos
    de la tienda de informática y reparaciones.
*/

CREATE DATABASE PRACTICA2;
USE PRACTICA2;

/* Tabla de fabricantes */
CREATE TABLE fabricantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) UNIQUE,
    pais VARCHAR(40)
);

/* Tabla de artículos */
CREATE TABLE articulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40),
    precio DECIMAL(12, 2),
    fabricante_id INT,
    FOREIGN KEY (fabricante_id) REFERENCES fabricantes(id)
);

/* Tabla de técnicos */
CREATE TABLE tecnicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40),
    especialidad VARCHAR(40),
    salario DECIMAL(12, 2)
);

/* Tabla de reparaciones */
CREATE TABLE reparaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_averia VARCHAR(300),
    coste_reparacion DECIMAL(12, 2),
    tecnico_id INT,
    FOREIGN KEY (tecnico_id) REFERENCES tecnicos(id)
);

/* Datos iniciales de fabricantes */
INSERT INTO fabricantes (id, nombre, pais) VALUES
    (1, 'Kingston', 'Estados Unidos'),
    (2, 'Asus', 'Taiwán'),
    (3, 'Samsung', 'Corea del Sur'),
    (4, 'Logitech', 'Suiza'),
    (5, 'Intel', 'Estados Unidos');

/* Datos iniciales de artículos */
INSERT INTO articulos (id, nombre, precio, fabricante_id) VALUES
    (1, 'Memoria RAM 16GB DDR4', 45.50, 1),
    (2, 'SSD NVMe 1TB', 79.99, 1),
    (3, 'Placa Base ROG Strix', 185.00, 2),
    (4, 'Monitor 27" IPS 144Hz', 249.00, 2),
    (5, 'Monitor 32" Curved', 320.00, 3),
    (6, 'Ratón Óptico Inalámbrico', 29.99, 4),
    (7, 'Teclado Mecánico RGB', 89.90, 4),
    (8, 'Procesador Core i7', 310.00, 5);

/* Datos iniciales de técnicos */
INSERT INTO tecnicos (id, nombre, especialidad, salario) VALUES
    (1, 'Carlos Pérez', 'Hardware', 1800.00),
    (2, 'Ana Gómez', 'Redes y Servidores', 2100.00),
    (3, 'Luis Martínez', 'Portátiles', 1650.00),
    (4, 'Marta Ruiz', 'Movilidad y Tablets', 1750.00);

/* Datos iniciales de reparaciones */
INSERT INTO reparaciones (id, descripcion_averia, coste_reparacion, tecnico_id) VALUES
    (1, 'Sustitución de pantalla rota', 120.50, 3),
    (2, 'Cambio de fuente de alimentación', 65.00, 1),
    (3, 'Recuperación de datos en disco dañado', 150.00, 2),
    (4, 'Limpieza interna y cambio de pasta térmica', 45.00, 1),
    (5, 'Sustitución de conector de carga', 50.00, 3),
    (6, 'Ampliación de RAM y formateo', 80.00, 4);
