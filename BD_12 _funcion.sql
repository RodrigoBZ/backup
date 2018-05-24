
--Funcion para insertar una extraccion 
CREATE OR REPLACE FUNCTION inserta_ext
(id_med1 INTEGER,
id_don1 INTEGER,
id_org1 INTEGER,
exito1 BOOLEAN,
detalle1 VARCHAR(500),
fecha1 DATE,
hora1 TIME
)
RETURNS BOOLEAN
AS
$$

DECLARE id_ext INTEGER;
DECLARE status BOOLEAN;

BEGIN
id_ext = CASE
		WHEN((SELECT MAX(id_extraccion)
			FROM extraer) IS NOT NULL)
		THEN(SELECT MAX(id_extraccion)
			FROM extraer)+1
		ELSE 1
	 END;

INSERT INTO extraer VALUES (id_med1, id_don1, id_org1, exito1, id_ext, detalle1, fecha1, hora1);
status = TRUE; 

RETURN status;
END
$$
LANGUAGE 'plpgsql';

--SELECT inserta_ext(2, 1, 1, TRUE, 'todo mal', '2001-09-18', '01:12:00');


--Funcion para verificar datos en la tabla extraccion 

CREATE OR REPLACE FUNCTION SP_insert_extraer
(id_med INTEGER, 
id_don INTEGER,
id_org INTEGER,
exito2 BOOLEAN,
detalle2 VARCHAR(500),
fecha2 DATE,
hora2 TIME)

RETURNS VARCHAR (50)
AS
$$

DECLARE id_extraccion_var INTEGER;
DECLARE status_insercion VARCHAR(50);

BEGIN

IF ((SELECT COUNT(*)
	FROM extraer
	WHERE id_organo = id_org
	AND id_donador = id_don) != 0)
THEN
   status_insercion = 'La insercion ya existe';
ELSE
	IF ((SELECT persona.id_persona
	    FROM persona NATURAL JOIN donador
	    WHERE donador.id_donador = id_don) = (SELECT persona.id_persona
						    FROM persona NATURAL JOIN medico
						    WHERE medico.id_medico = id_med))
	THEN
	  status_insercion = 'El medico y el donador son la misma persona';
	ELSE
	CASE
	   WHEN ((SELECT especializacion
 		  FROM medico
		  WHERE id_medico = id_med) = 'cardiologo'
		  AND (SELECT tipo
			FROM organo
			WHERE id_organo = id_org) = 'corazon')
	   THEN
		status_insercion = 'insecion valida';
		SELECT inserta_ext(id_med, id_don, id_org, exito2, detalle2, fecha2, hora2);
	   WHEN ((SELECT especializacion
	           FROM medico
	           WHERE id_medico = id_med) = 'nefrologo'
	           AND (SELECT tipo
			FROM organo
			WHERE id_organo = id_org) = 'rinon')
	    THEN
		 status_insercion = 'insercion valida';
		 SELECT inserta_ext(id_med, id_don, id_org, exito2, detalle2, fecha2, hora2);
	    WHEN ((SELECT especializacion
	           FROM medico
	           WHERE id_medico = id_med) = 'neumologo'
	           AND (SELECT tipo
			FROM organo
			WHERE id_organo = id_org) = 'pulmon')
	    THEN
		 status_insercion = 'insercion valida';
		 SELECT inserta_ext(id_med, id_don, id_org, exito2, detalle2, fecha2, hora2);
	    ELSE
	    status_insercion = 'Organo no compatible con especializacion';
	END CASE;
	END IF;
END IF;
RETURN status_insercion;

END;
$$
LANGUAGE 'plpgsql';

--Función que actualiza la fecha en la tabla trasplantes

CREATE OR REPLACE FUNCTION sp_actualizar_trasplantes(
fecha_trasp DATE, id INT)
RETURNS VARCHAR(50)
AS
$$
BEGIN
UPDATE trasplantar
SET fecha_trasplante = fecha_trasp
WHERE id_trasplante = id;
RETURN 'actualizacion_exitosa';
END;
$$ 
LANGUAGE 'plpgsql';

--SELECT sp_actualizar_trasplantes('2096-04-02', 2)

--Funcion que inserta una nueva persona y genera un id_persona en automatico.

CREATE OR REPLACE FUNCTION llenarpersona(
	nombre varchar(50),
	fecha_nacimiento date,
	tipo_sangre varchar(20),
	nacionalidad varchar(50),
	apellido varchar(50))

	RETURNS VARCHAR (100)
	AS
	$$

DECLARE id_persona INTEGER;
	
BEGIN

id_persona = CASE WHEN((SELECT MAX(persona.id_persona)
				FROM persona) IS NOT NULL)
			THEN(SELECT MAX(persona.id_persona)
				FROM persona)+1
			ELSE 1
END;
	
	INSERT INTO persona VALUES (id_persona,nombre,fecha_nacimiento,tipo_sangre,nacionalidad,apellido);

	RETURN 'Se inserto la persona';

END;
$$
LANGUAGE plpgsql;

--SELECT llenarpersona('Carlos','21/01/90','O+','mexicana','Violante')
