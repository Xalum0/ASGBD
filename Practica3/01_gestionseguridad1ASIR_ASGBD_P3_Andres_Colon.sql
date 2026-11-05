/*Gestion de seguridad con usuarios y roles*/

/*Tarea 1*/
/*Creacion de usuarios*/

CREATE USER 'gestor_tienda'@'localhost' IDENTIFIED BY 'Gestor2026*'; /*La contraseña es temporal y solo para una sesion primaria rapida, aun asi cumple con 1 mayuscula, 1 numero y un caracter, teniendo minimo 8 caracteres en total*/
CREATE USER 'auditor_externo'@'%' IDENTIFIED BY 'Auditor2026¿'; /*La contraseña es temporal y solo para una sesion primaria rapida, aun asi cumple con 1 mayuscula, 1 numero y un caracter, teniendo minimo 8 caracteres en total*/

/*configuraciones posteriores de usuarios*/

ALTER USER 'auditor_externo'@'%' PASSWORD EXPIRE INTERVAL 30 DAYS;

/*Limitar sessiones a una hora*/

SET GLOBAL wait_timeout = 3600;
SET GLOBAL interactive_timeout = 3600;

/*Tarea 2*/
/*Creacion de rol*/

CREATE ROLE 'rol_consultor';

/*Darle permisos al rol*/

GRANT SELECT ON tienda_informatica.* TO 'rol_consultor' ;

/*Asignar rol al usuario de forma por defecto*/

GRANT 'rol_consultor' TO 'auditor_externo'@'%';

/*Tarea 3*/
/*Crear vista*/
CREATE VIEW v_tecnicos_activos AS
SELECT id, nombre, especialidad
FROM tecnicos;

/*dar acceso a gestor*/

GRANT SELECT ON tienda_informatica.v_tecnicos_activos TO 'gestor_tienda'@'localhost';

/*prueba de error*/

/*
al ejecutar un select a tecnicos dice lo siguiente:
select * from tienda_informatica.tecnicos;
SQL Error [1142] [42000]: SELECT command denied to user 'gestor_tienda'@'localhost' for table `tienda_informatica`.`tecnicos`

osea se, no tiene permisos

en cambio si se hace a la vista hace:
select * from tienda_informatica.v_tecnicos_activos;
*/
