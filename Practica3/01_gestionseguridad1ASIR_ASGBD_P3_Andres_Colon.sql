/*Gestion de seguridad con usuarios y roles*/

/*Tarea 1*/
/*Creacion de usuarios*/

CREATE USER 'gestor_tienda'@localhost' 'IDENTIFIED BY 'Gestor2026*'; /*La contraseña es temporal y solo para una sesion primaria rapida, aun asi cumple con 1 mayuscula, 1 numero y un caracter, teniendo minimo 8 caracteres en total*/
CREATE USER 'auditor_externo'@'%' IDENTIFIED BY 'Auditor2026¿'; /*La contraseña es temporal y solo para una sesion primaria rapida, aun asi cumple con 1 mayuscula, 1 numero y un caracter, teniendo minimo 8 caracteres en total*/

/*configuraciones posteriores de usuarios*/

ALTER USER 'auditor_externo'@'%' PASSWORD EXPIRE INTERVAL 30 DAYS;

/*Limitar sessiones a una hora*/

SET GLOBAL wait_timeout = 3600 TO 'gestor_tienda'@'localhost';
SET GLOBAL interactive_timeout = 3600;

/*Tarea 2*/
/*Creacion de rol*/

CREATE ROL 'rol_consultor';

/*Darle permisos al rol*/

GRANT SELECT ON practica2.* TO 'rol_consultor' ;

/*Asignar rol al usuario de forma por defecto*/

GRANT 'rol_consultor' TO 'auditor_externo'@'%';
SET DEFAULT ROLE 'rol_consultor' FOR 'auditor_externo'@'%';
