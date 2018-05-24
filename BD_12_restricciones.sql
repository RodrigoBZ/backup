--INTEGRIDAD DE ENTIDAD
--Llaves Primarias
ALTER TABLE persona 
	ADD PRIMARY KEY (id_persona); 
ALTER TABLE donador 
	ADD PRIMARY KEY (id_donador);
ALTER TABLE receptor 
	ADD PRIMARY KEY (id_receptor);
ALTER TABLE medico 
	ADD PRIMARY KEY (id_medico);
ALTER TABLE extraer 
	ADD PRIMARY KEY (id_extraccion);
ALTER TABLE organo 
	ADD PRIMARY KEY (id_organo);
ALTER TABLE trasplantar 
	ADD PRIMARY KEY (id_trasplante); 
ALTER TABLE telefono_persona 
	ADD PRIMARY KEY (id_persona, numero_persona); 	
ALTER TABLE hospital 
	ADD PRIMARY KEY (id_hospital);
ALTER TABLE telefono_hospital
	ADD PRIMARY KEY (id_hospital, no_hospital); 

--INTEGRIDAD REFERENCIAL
	--Llaves Foraneas
ALTER TABLE donador 
	ADD CONSTRAINT id_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona);
ALTER TABLE receptor 
	ADD CONSTRAINT id_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona);
ALTER TABLE medico 
	ADD CONSTRAINT id_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona);
ALTER TABLE extraer 
	ADD CONSTRAINT id_medico FOREIGN KEY (id_medico) REFERENCES medico (id_medico);
ALTER TABLE extraer 
	ADD CONSTRAINT id_donador FOREIGN KEY (id_donador) REFERENCES donador (id_donador);
ALTER TABLE extraer 
	ADD CONSTRAINT id_organo FOREIGN KEY (id_organo) REFERENCES organo (id_organo);
ALTER TABLE trasplantar 
	ADD CONSTRAINT id_medico FOREIGN KEY (id_medico) REFERENCES medico (id_medico);
ALTER TABLE trasplantar 
	ADD CONSTRAINT id_receptor FOREIGN KEY (id_receptor) REFERENCES receptor (id_receptor);
ALTER TABLE trasplantar
	ADD CONSTRAINT id_extraccion FOREIGN KEY (id_extraccion) REFERENCES extraer (id_extraccion);
ALTER TABLE telefono_persona 
	ADD CONSTRAINT id_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona);
ALTER TABLE telefono_hospital
	ADD CONSTRAINT id_hospital FOREIGN KEY (id_hospital) REFERENCES hospital (id_hospital);
ALTER TABLE medico 
	ADD CONSTRAINT id_hospital FOREIGN KEY (id_hospital) REFERENCES hospital (id_hospital);

--INTEGRIDAD DE No Nulidad
ALTER TABLE persona 
	ALTER COLUMN id_persona SET NOT NULL; 
ALTER TABLE persona 
	ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE persona 
	ALTER COLUMN id_persona SET NOT NULL;
ALTER TABLE persona 
	ALTER COLUMN fecha_nacimiento SET NOT NULL;
ALTER TABLE persona 
	ALTER COLUMN apellido SET NOT NULL;
ALTER TABLE persona 
	ALTER COLUMN tipo_sangre SET NOT NULL;
ALTER TABLE donador 
	ALTER COLUMN id_donador SET NOT NULL;
ALTER TABLE receptor 
	ALTER COLUMN id_receptor SET NOT NULL;
ALTER TABLE receptor 
	ALTER COLUMN organo_solicitado SET NOT NULL;
ALTER TABLE medico 
	ALTER COLUMN id_medico SET NOT NULL;
ALTER TABLE medico 
	ALTER COLUMN especializacion SET NOT NULL;
ALTER TABLE extraer 
	ALTER COLUMN exito SET NOT NULL; 
ALTER TABLE extraer 
	ALTER COLUMN id_extraccion SET NOT NULL;
ALTER TABLE extraer 
	ALTER COLUMN detalle_extraccion SET NOT NULL;
ALTER TABLE organo 
	ALTER COLUMN tipo SET NOT NULL;
ALTER TABLE organo 
	ALTER COLUMN tiempo_isquemia SET NOT NULL;
ALTER TABLE trasplantar 
	ALTER COLUMN id_trasplante SET NOT NULL;
ALTER TABLE trasplantar 
	ALTER COLUMN fecha_solicitud SET NOT NULL;
ALTER TABLE trasplantar 
	ALTER COLUMN fecha_trasplante SET NOT NULL;
ALTER TABLE hospital 
	ALTER COLUMN direccion_hospital SET NOT NULL;
ALTER TABLE hospital 
	ALTER COLUMN nombre_hospital SET NOT NULL;
ALTER TABLE extraer 
	ALTER COLUMN fecha SET NOT NULL;
ALTER TABLE extraer 
	ALTER COLUMN hora SET NOT NULL;
ALTER TABLE hospital 
	ALTER COLUMN no_camas SET NOT NULL;
ALTER TABLE hospital 
	ALTER COLUMN no_quirofanos SET NOT NULL;
ALTER TABLE telefono_persona 
	ALTER COLUMN numero_persona SET NOT NULL;

--INTEGRIDAD DE DOMINIO
ALTER TABLE persona
	ADD CHECK (tipo_sangre IN ('A+','A-','B+','B-','AB+','AB-','O+','O-'));
ALTER TABLE receptor
	ADD CHECK (organo_solicitado IN ('rinon','corazon','pulmon'));
ALTER TABLE medico
	ADD CHECK (especializacion IN ('cardiologo','nefrologo','neumologo'));
ALTER TABLE organo 
	ADD CHECK (tipo IN ('rinon','corazon','pulmon'));
ALTER TABLE telefono_persona 
	ADD CONSTRAINT chk_numero_persona CHECK (numero_persona ~ '^[0-9]{7,10}$');
ALTER TABLE hospital 
	ADD CONSTRAINT chk_no_camas CHECK (no_camas>0);
ALTER TABLE hospital 
	ADD CONSTRAINT chk_no_quirofanos CHECK (no_quirofanos>0);
ALTER TABLE hospital 
	ADD CONSTRAINT chk_no_empleados CHECK (no_empleados>0);
ALTER TABLE hospital 
	ADD CHECK (tipo_hospital IN('publico','privado'));	
ALTER TABLE telefono_hospital 
	ADD CONSTRAINT chk_no_hospital CHECK (no_hospital ~ '^[0-9]{7,10}$');
ALTER TABLE trasplantar
	ADD CONSTRAINT chk_fechas CHECK (fecha_solicitud <= fecha_trasplante);