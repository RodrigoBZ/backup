SELECT *
FROM persona

-- Modificamos la columna para que acepte los valores encriptados
ALTER TABLE persona ALTER COLUMN nombre TYPE TEXT;
ALTER TABLE persona ALTER COLUMN apellido TYPE TEXT;
-- Actualizamos los valores de los registros existentes por su versión encriptada
UPDATE persona SET nombre = MD5(nombre);
UPDATE persona SET apellido = MD5(apellido);



Alter table persona add column fecha_registro timestamp;

UPDATE persona SET fecha_registro = CURRENT_DATE
