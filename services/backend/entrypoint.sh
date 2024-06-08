#!/bin/sh

echo "Script de inicio ejecutado"

echo "---------------"
echo "Esperando a PostgreSQL..."
echo ":D"
echo "---------------"

# Esperar a que PostgreSQL esté disponible
while ! nc -z db 5432; do
  echo "PostgreSQL no disponible, reintentando en 0.3 segundos..."
  sleep 0.3
done
echo "---------------"

echo "═══•◉•═════

▂▄▄▓▄▄▂

◢◤ █▀▀████▄▄▄▄◢◤

█▄ █ █▄ ███▀▀▀▀▀▀▀╬

◥█████◤

═╩══╩═

╬═╬

╬═╬

╬═╬ 

╬═╬ PostgreSQL iniciado

╬═╬ ●/

╬═╬/▌

╬═╬/ \ "

# Ejecutar el script Python
echo "---------------"
echo "Ejecutando main.py con los argumentos 'run -h 0.0.0.0'"
echo "---------------"
python main.py

# Mensaje final para indicar que el script ha terminado
echo "---------------"
echo "Script de inicio completado"
echo ":)"
echo "---------------"
echo " MAY THE FORCE BE WITH YOU"

#!/bin/bash
set -e

# Esperar a que PostgreSQL esté listo
until pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER; do
  >&2 echo "Postgres no está disponible - esperando"
  sleep 1
done

# Crear la base de datos y las tablas
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -f /db/create.sql

# Ejecutar el comando principal
exec "$@"