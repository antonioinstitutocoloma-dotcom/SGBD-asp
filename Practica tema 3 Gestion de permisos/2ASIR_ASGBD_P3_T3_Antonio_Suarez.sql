-- Nombre: Antonio
-- Apellidos: Suárez Pérez
-- Fecha: 5 de noviembre de 2026
-- 2 CICLO FORMATIVO GRADO SUPERIOR

-- Administración de Sistemas Informáticos y Redes - ASIR

-- Administración de Sistemas Gestores de Bases de Datos - ASGBD

-- Práctica tema 3: Gestión de permisos

/*
Base de datos: TIENDA DE INFÓRMATICA Y REPARACIONES
Contiene: 4 TABLAS

--------------------- CREACIÓN DE USUARIOS, VISTAS Y PERMISOS -----------------------------
*/

-- Tarea 1: Creación de usuarios y políticas de conexión y caducidad

/* 1. Creación de cuentas base: Crea un usuario llamado gestor_tienda que
únicamente pueda conectarse desde la máquina local con la contraseña segura
(explica qué requisitos estableces para que la contraseña sea segura). Crea un
segundo usuario llamado auditor_externo que pueda conectarse desde
cualquier dirección IP de la red. */

/* 2. Directiva de caducidad de credenciales: Configura el usuario auditor_externo
para que su contraseña caduque obligatoriamente cada 30 días, obligándole a 
reestablecerla pasado dicho plazo para evitar vulnerabilidades por credenciales
estáticas */

/* 3. Directiva de control de sesión: Establece una restricción técnica para que las
conexiones activas del usuario gestor_tienda no puedan superar 1 hora de
inactividad o tiempo de vida activo, forzando la reautenticación tras dicho periodo */





/* RESULTADO: */

/* Para que una contraseña sea realmente segura y proteja bien las cuentas,
lo ideal es seguir estos criterios:

Lo primero es que sea larga, teniendo al menos 12 caracteres. Además, 
debe ser una buena mezcla de letras mayúsculas y minúsculas, números
y algún símbolo especial (como una arroba, un asterisco o un signo de 
exclamación). Por último, es fundamental evitar datos personales 
o fáciles de adivinar, como fechas de cumpleaños, nombres de familiares
o el nombre de la propia empresa. */

CREATE USER 'gestor_tienda'@'localhost' IDENTIFIED BY 'gt#9547G3sT0R01.01';

CREATE USER 'auditor_externo'@'%' IDENTIFIED BY 'gt#6137AuD1t0R01.01';

ALTER USER 'auditor_externo'@'%' PASSWORD EXPIRE INTERVAL 30 DAY;

/* La Tarea 1, el punto 3; no pude aplicarle el límite de tiempo a un
solo usuario porque en PHPMyAdmin las opciones de inactividad son 
generales para todo el servidor y no permiten configurarse de forma 
individual. Al ejecutar el comando, este afecta por igual a todas las 
conexiones. */

SET GLOBAL wait_timeout = 3600; 





-- Tarea 2: Creación y asignación de roles

/* 1. Definición de rol operativo: Crea un rol denominado rol_consultor. */

/* 2. Concesión de privilegios al rol: Otorga al rol rol_consultor permisos de solo
lectura sobre toda la base de datos tienda_informatica. */

/* 3. Asignación y rol por defecto: Asigna el rol rol_consultor al usuario
auditor_externo y configúralo explícitamente como rol por defecto para su
sesión de trabajo */



/* RESULTADO: */

CREATE ROLE 'rol_consultor';
GRANT SELECT ON tienda_informatica.* TO 'rol_consultor';
GRANT 'rol_consultor' TO 'auditor_externo'@'%';
SET DEFAULT ROLE 'rol_consultor' FOR 'auditor_externo'@'%';




-- Tarea 3: Seguridad mediante Vistas y Privilegios Granulares

/* Para proteger la información interna y confidencial de la empresa, el usuario
gestor_tienda bajo ningún concepto debe tener acceso directo a la tabla completa de
técnicos. Se debe proceder de la siguiente manera: */

/* 1. Creación de la vista de enmascaramiento: Crea una vista llamada
v_tecnicos_activos que muestre únicamente el identificador, el nombre y la
especialidad de los técnicos, ocultando por completo la columna de salarios.
 */

/*  2. Privilegio granular: Concede al usuario gestor_tienda permisos exclusivos de
consulta sobre dicha vista v_tecnicos_activos. */

/* 3. Prueba de denegación: Comprueba y documenta qué ocurre si el usuario
gestor_tienda intenta consultar directamente la tabla base tecnicos.
*/



/* RESULTADO: */

CREATE VIEW v_tecnicos_activos AS
SELECT id, nombre, especialidad
FROM tecnicos;

GRANT SELECT ON tienda_informatica.v_tecnicos_activos TO 'gestor_tienda'@'localhost';


/* Esta prueba sirve para comprobar que las medidas de seguridad cumplen 
su objetivo.

Como al usuario gestor_tienda no se le dio permiso para entrar a la 
tabla, si intenta consultarla directamente con el comando 
SELECT * FROM tecnicos;, el sistema no permite ejecutarlo y
le devuelve un error de permisos.

Esto demuestra que la seguridad funciona; los salarios de los 
trabajadores quedan totalmente protegidos e invisibles para quienes
no tienen autorización para verlos. */

SELECT * FROM tecnicos;







-- Tarea 4: Consistencia y control con WITH CHECK OPTION

/* 1. Vista con restricción de dominio: Crea una vista llamada
v_articulos_gama_baja basada en la tabla articulos que filtre aquellos
productos cuyo precio sea inferior o igual a 50.00 euros (precio <= 50.00),
incorporando obligatoriamente la cláusula WITH CHECK OPTION. */

/* 2. Demostración técnica: Razona y demuestra técnicamente qué sucede si el
administrador o un usuario con permisos intenta realizar una inserción de un artículo
con un precio de 75.00 euros a través de dicha vista.
 */




/* RESULTADO: */

CREATE VIEW v_articulos_gama_baja AS
SELECT id, nombre, precio, fabricante_id
FROM articulos
WHERE precio <= 50.00
WITH CHECK OPTION;


/* Si intentamos añadir un producto que cuesta más de 50 € 
(por ejemplo, un teclado de 75 €) usando esta vista, el 
sistema bloqueará la ejecución al instante y mostrará un 
mensaje de error.

Gracias al parámetro de seguridad que pusimos (WITH CHECK OPTION), 
el sistema obliga a que cualquier producto nuevo cumpla estrictamente
la condición de costar 50 € o menos. Si este parámetro no estuviera, 
el artículo prohibido se colaría en la base de datos. */


INSERT INTO v_articulos_gama_baja (nombre, precio, fabricante_id) 
VALUES ('Teclado Mecánico Premium', 75.00, 4);






-- Tarea 5: Auditoría, Resolución de Incidencias y Reflexión Crítica (Apartado de
-- Análisis y Razonamiento)

/* 1. Auditoría de privilegios efectivos: Imagina que el auditor externo reporta que no
puede ver los cambios recientes en la base de datos. Escribe la sentencia SQL que
utilizarías para comprobar los privilegios exactos y los roles activos que tiene
asignados en este momento el usuario auditor_externo desde el servidor */

/* 2. Reflexión sobre el Principio de Mínimo Privilegio: Explica razonadamente por qué
en un entorno de producción nunca se debe otorgar el permiso ALL PRIVILEGES
a los usuarios finales de una aplicación web o de gestión, y qué relación directa
guarda esta mala práctica con las inyecciones SQL o brechas de seguridad. */

/* 3. Análisis de comportamiento del CHECK OPTION: Si un analista junior elimina la
cláusula WITH CHECK OPTION en la v_articulos_gama_baja pensando
que "mejora el rendimiento de las consultas", ¿qué brecha lógica o inconsistencia de
datos podría introducir en la tabla base articulos al insertar registros mediante la
vista? Justifica tu respuesta. */




/* RESULTADO: */

SHOW GRANTS FOR 'auditor_externo'@'%' USING 'rol_consultor';

SELECT * FROM mysql.default_roles WHERE USER = 'auditor_externo';


-- Tarea 5, el punto 2.

/* Dar permisos totales (ALL PRIVILEGES) a un usuario es muy peligroso.

Si la aplicación sufre un ataque (como una inyección SQL): 
si está conectada con un usuario que tiene poderes de administrador, 
el atacante podrá robar datos, borrar tablas enteras o destrozar 
el sistema.

Por eso existe el Principio de Mínimo Privilegio: consiste en darle 
a cada usuario únicamente los permisos estrictamente 
necesarios para trabajar (por ejemplo, solo leer o escribir en una 
tabla concreta). De este modo, si ocurre un fallo o un ataque, el 
daño se limita al mínimo posible. */



-- Tarea 5, el punto 3.

/* Si se quita esa regla de seguridad (WITH CHECK OPTION) 
pensando que la base de datos irá más rápido, eso es
un grave error de control.

Al eliminarla, cualquier usuario podría colar productos caros 
(por ejemplo, de 500 €) a través de una vista que está diseñada 
exclusivamente para artículos económicos.

Aunque el producto se guardaría en la tabla principal, desapareceria 
de esta vista, arruinando los informes del sistema, falseando las
búsquedas que se realizan en la pantalla y descontrolando el registro 
de los productos. */



