--Script de creacion de la base de datos y sus tablas



CREATE DATABASE base_trasplantes;


CREATE TABLE persona(
	id_persona  INTEGER,
	nombre VARCHAR(50),
	apellido VARCHAR(50),
	fecha_nacimiento DATE,
	tipo_sangre VARCHAR(10),
	nacionalidad VARCHAR(50));

CREATE TABLE donador(
	id_donador INTEGER,
	id_persona INTEGER);

CREATE TABLE receptor(
	id_receptor INTEGER,
	id_persona INTEGER,
	organo_solicitado VARCHAR(20));

CREATE TABLE medico(
	id_medico INTEGER,
	id_persona INTEGER,
	id_hospital INTEGER,
	especializacion VARCHAR(20));

CREATE TABLE extraer (
	id_medico INTEGER,
	id_donador INTEGER,
	id_organo INTEGER,
	exito BOOLEAN,
	id_extraccion INTEGER,
	detalle_extraccion VARCHAR(500),
	fecha DATE,
	hora TIME);

CREATE TABLE organo(	
	id_organo INTEGER,
	tipo VARCHAR(25),
	tiempo_isquemia TIME);

CREATE TABLE trasplantar(
	id_trasplante INTEGER,
	id_medico INTEGER,
	id_receptor INTEGER,
	id_extraccion INTEGER,
	exito BOOLEAN,
	detalle_trasplante VARCHAR(500),
	fecha_solicitud DATE,
	fecha_trasplante DATE);
	
CREATE TABLE telefono_persona(
	id_persona INTEGER,
	numero_persona VARCHAR(50));

CREATE TABLE hospital(
	id_hospital INTEGER,
	nombre_hospital VARCHAR(50),
	no_camas INTEGER,
	no_quirofanos INTEGER,
	no_empleados INTEGER,
	direccion_hospital VARCHAR(100),
	tipo_hospital VARCHAR (50));

CREATE TABLE telefono_hospital(
	id_hospital INTEGER,
	no_hospital VARCHAR(75));
