-- Script base de datos


-- Verificar si la base de datos existe
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'app_dev') THEN
        RAISE NOTICE 'La base de datos app_dev ya existe.';
    ELSE
        -- Crear la base de datos fuera del bloque de transacción
        EXECUTE 'CREATE DATABASE app_dev';
        RAISE NOTICE 'La base de datos app_dev ha sido creada exitosamente.';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al verificar/crear la base de datos. Código de error: %, Mensaje: %', SQLSTATE, SQLERRM;
END $$;



-- EXPLICACION
-- RAISE DEBUG PARA RASTREAR FLUJO DE EJECUCION, INICIO DE BLOQUE Y CREANDO BASE DE DATOS
-- PERFORM pg_sleep(1): Simula un retardo en la ejecución
-- RAISE INFO PARA MENSAJES INFORMATIVOS, LA BASE DE DATOS YA EXISTE O HA SIDO CREADA
-- RAISE EXCEPTION PARA INDICAR UN PROBLEMA, ERROR AL CREAR BASE DE DATOS  (mas completo que el RAISE ERROR)
--  