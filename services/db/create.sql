-- Script base de datos
CREATE DATABASE app_dev;
\c app_dev;

CREATE TABLE Usuarios (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Tipo_acceso VARCHAR(50) NOT NULL,
    RUT VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Cursos (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Tipo VARCHAR(50),
    Calendario VARCHAR(255)
);

CREATE TABLE Alumnos (
    ID SERIAL PRIMARY KEY,
    User_ID INT REFERENCES Usuarios(ID),
    ID_Curso INT REFERENCES Cursos(ID)
);

CREATE TABLE Profesores (
    ID SERIAL PRIMARY KEY,
    User_ID INT REFERENCES Usuarios(ID),
    Perfil TEXT
);

CREATE TABLE Administradores (
    ID SERIAL PRIMARY KEY,
    User_ID INT REFERENCES Usuarios(ID)
);

CREATE TABLE Asignaturas (
    ID SERIAL PRIMARY KEY,
    ID_Curso INT REFERENCES Cursos(ID),
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Calendario VARCHAR(255)
);

CREATE TABLE Profesor_Asignatura (
    ID SERIAL PRIMARY KEY,
    ID_Asignatura INT REFERENCES Asignaturas(ID),
    ID_Profesor INT REFERENCES Profesores(ID)
);

CREATE TABLE Clases (
    ID SERIAL PRIMARY KEY,
    ID_Asignatura INT REFERENCES Asignaturas(ID),
    ID_Profesor INT REFERENCES Profesores(ID),
    Nombre_clase VARCHAR(100),
    Fecha DATE,
    Hora_inicio TIME,
    Hora_fin TIME,
    Ubicacion VARCHAR(255),
    Codigo_QR VARCHAR(255)
);

CREATE TABLE Asistencias (
    ID SERIAL PRIMARY KEY,
    ID_Clase INT REFERENCES Clases(ID),
    ID_Alumno INT REFERENCES Alumnos(ID),
    Fecha_asistencia DATE,
    Confirmado BOOLEAN,
    Correo VARCHAR(100)
);

CREATE TABLE Justificaciones (
    ID SERIAL PRIMARY KEY,
    ID_Asistencia INT REFERENCES Asistencias(ID),
    Razon TEXT,
    Certificado VARCHAR(255),
    Estado VARCHAR(50),
    Fecha_envio DATE,
    Fecha_revision DATE
);

CREATE TABLE Recordatorios (
    ID SERIAL PRIMARY KEY,
    ID_Clase INT REFERENCES Clases(ID),
    Tipo VARCHAR(50),
    Fecha_envio DATE,
    Mensaje TEXT,
    Presencial BOOLEAN,
    Online BOOLEAN
);

CREATE TABLE Preferencias_Alimentarias (
    ID SERIAL PRIMARY KEY,
    ID_Alumno INT REFERENCES Alumnos(ID),
    Celiaco BOOLEAN,
    Intolerante BOOLEAN,
    Otros TEXT
);

CREATE TABLE Encuestas (
    ID SERIAL PRIMARY KEY,
    ID_Curso INT REFERENCES Cursos(ID),
    ID_Alumno INT REFERENCES Alumnos(ID),
    Tipo VARCHAR(50),
    Fecha_realizacion DATE,
    Completado BOOLEAN
);

CREATE TABLE Dashboard (
    ID SERIAL PRIMARY KEY,
    ID_Alimento INT REFERENCES Preferencias_Alimentarias(ID),
    ID_Encuesta INT REFERENCES Encuestas(ID),
    ID_Admin INT REFERENCES Administradores(ID),
    Visualizacion TEXT,
    Filtro_fecha DATE,
    Filtro_curso INT
);
