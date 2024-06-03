-- Script base de datos


-- Intentar crear la base de datos
DO $$
BEGIN
    RAISE DEBUG 'Inicio del bloque para creación de la base de datos';
    PERFORM pg_sleep(1); -- Pausa para simular la operación
    IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'app_dev') THEN
        RAISE INFO 'La base de datos app_dev ya existe.';
    ELSE
        RAISE DEBUG 'Creando la base de datos app_dev';
        PERFORM pg_sleep(1); -- Pausa para simular la operación
        CREATE DATABASE app_dev;
        RAISE INFO 'La base de datos app_dev ha sido creada exitosamente.';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE ERROR 'Error al crear la base de datos: %', SQLERRM;
END $$;


-- EXPLICACION
-- RAISE DEBUG PARA RASTREAR FLUJO DE EJECUCION, INICIO DE BLOQUE Y CREANDO BASE DE DATOS
-- PERFORM pg_sleep(1): Simula un retardo en la ejecución
-- RAISE INFO PARA MENSAJES INFORMATIVOS, LA BASE DE DATOS YA EXISTE O HA SIDO CREADA
-- RAISE ERROR PARA INDICAR UN PROBLEMA, ERROR AL CREAR BASE DE DATOS
--  