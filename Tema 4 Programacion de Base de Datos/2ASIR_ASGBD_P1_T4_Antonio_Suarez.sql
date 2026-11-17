-- Nombre: Antonio
-- Apellidos: Suárez Pérez
-- Fecha: 17 de noviembre de 2026
-- 2 CICLO FORMATIVO GRADO SUPERIOR

-- Administración de Sistemas Informáticos y Redes - ASIR

-- Administración de Sistemas Gestores de Bases de Datos - ASGBD

-- Tema 4: Programación de Base de Datos

------ Procedimientos almacenados ------
/* 
2.1. Creación
2.2. Invocación
2.3. Eliminación
2.4. Uso de variables
2.5. Parámetros 
*/


/*
Base de datos: videojuegos
Contiene: 6 TABLAS

--------------------- CREACIÓN DE TABLAS  -----------------------------
*/
/* CREATE TABLE genero (
    id_genero INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE juego (
    id_juego INT PRIMARY KEY,
    id_genero INT,
    nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);

CREATE TABLE desarrollador (
    id_desarrollador INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE desarrollador_juego (
    id INT PRIMARY KEY,
    id_juego INT,
    id_desarrollador INT,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego),
    FOREIGN KEY (id_desarrollador) REFERENCES desarrollador(id_desarrollador)
);

CREATE TABLE plataforma (
    id_plataforma INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE plataforma_juego (
    id INT PRIMARY KEY,
    id_juego INT,
    id_plataforma INT,
    año INT,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego),
    FOREIGN KEY (id_plataforma) REFERENCES plataforma(id_plataforma)
); */

--------------------- INSERT DE LAS TABLAS  -----------------------------

/*

-- Añadir datos a la tabla 'genero'

INSERT INTO `genero` VALUES (1,'Estrategia'),(2,'MOBA'),(3,'ARPG'),(4,'Mundo abierto');



INSERT INTO `juego` VALUES

(1,1, 'Hearthstone'),(2,1,'Clash Royale'),

(3,2, 'League of Legends'),(4,2,'Brawl Stars'),

(5,3, 'Elden Ring'),(6,3,'Sekiro: Shadows Die Twice'),

(7,4, 'Horizon Forbidden West'),(8,4,'The legend of Zelda: Breath of the wild');


-- Estructura de la tabla desarrollador


INSERT INTO `desarrollador` VALUES

(1,'Blizzard'),(2,'Supercell'),(3,'Riot Games'),(4,'FromSoftware'),(5, 'Guerrilla Games'), (6, 'Nintendo EPD'), (7, 'Monolith Soft');


-- Estructura de la tabla desarrollador_juego


INSERT INTO `desarrollador_juego` VALUES

(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 2), (5, 5, 4), (6, 6, 4), (7, 7, 5), (8, 8, 6);


-- Estructura de la tabla plataforma


INSERT INTO `plataforma` VALUES

(1, 'PC'), (2, 'PlayStation'), (3, 'Xbox'), (4, 'Mobile'), (5, 'Nintendo');



-- Estructura de la tabla plataforma_juego


INSERT INTO `plataforma_juego` VALUES

(1, 1, 1, 2014), (2, 1, 4, 2015), (3, 2, 4, 2016), (4, 3, 1, 2009),

(5, 4, 4, 2017), (6, 5, 3, 2022), (7, 5, 1, 2022), (8, 5, 2, 2022),

(9, 6, 3, 2019), (10, 6, 1, 2019), (11, 6, 2, 2019),

(12, 7, 2, 2022), (13, 8, 5, 2017); */


--------------------- EJERCICIOS DE PROCEDIMIENTOS  -----------------------------

/* Ejercicio 1. Crear un procedimiento que obtenga los videojuegos que pertenecen al género MOBA. */

/* Ejercicio 2. Crear un procedimiento que obtenga los videojuegos desarrollados por Supercell. */

/* Ejercicio 3. Crear un procedimiento que obtenga el nombre de los videojuegos y el género de los juegos
publicados en la plataforma ‘PlayStation’ */

/* Ejercicio 4. Crear un procedimiento que obtenga el número de videojuegos lanzados en el año 2022. */

/* Ejercicio 5. Crear un procedimiento que obtenga el porcentaje de videojuegos lanzados en 2022 llamando al
ejercicio 4 dentro del procedimiento y utilizando el resultado que devuelve para hacer el cálculo. (Damos por
hecho que cada juego solo se lanza una vez, independientemente de que se lance en tres plataformas
diferentes) */
