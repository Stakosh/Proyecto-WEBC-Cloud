-- Script base de datos
CREATE DATABASE app_dev;
\c app_dev;

CREATE TABLE CursoCarrera (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Director VARCHAR(255),
    Tipo VARCHAR(50)
);

CREATE TABLE Asignaturas (
    ID INT PRIMARY KEY,
    ID_Curso INT,
    Nombre VARCHAR(255),
    Descripcion TEXT,
    FOREIGN KEY (ID_Curso) REFERENCES CursoCarrera(ID)
);

CREATE TABLE Usuarios (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Correo VARCHAR(255),
    Contrasena VARCHAR(255),
    Acceso ENUM('alumno', 'profesor', 'admin'),
    RUT VARCHAR(20)
);

CREATE TABLE PreferAlimentarias (
    ID_Alumno INT,
    Celiaco BOOLEAN,
    Intolerante BOOLEAN,
    Otros TEXT,
    PRIMARY KEY (ID_Alumno),
    FOREIGN KEY (ID_Alumno) REFERENCES Usuarios(ID)
);

CREATE TABLE Encuestas (
    ID INT PRIMARY KEY,
    ID_Curso INT,
    ID_Alumno INT,
    Tipo VARCHAR(50),
    Fecha_Realizacion DATE,
    Completado BOOLEAN,
    FOREIGN KEY (ID_Curso) REFERENCES CursoCarrera(ID),
    FOREIGN KEY (ID_Alumno) REFERENCES Usuarios(ID)
);

CREATE TABLE Preguntas (
    ID INT PRIMARY KEY,
    ID_Encuesta INT,
    Pregunta TEXT,
    FOREIGN KEY (ID_Encuesta) REFERENCES Encuestas(ID)
);

CREATE TABLE Profesores (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Correo VARCHAR(255),
    RUT VARCHAR(20)
);

CREATE TABLE ProfesorAsignatura (
    ID INT PRIMARY KEY,
    ID_Asignatura INT,
    ID_Profesor INT,
    FOREIGN KEY (ID_Asignatura) REFERENCES Asignaturas(ID),
    FOREIGN KEY (ID_Profesor) REFERENCES Profesores(ID)
);

CREATE TABLE Clases (
    ID INT PRIMARY KEY,
    ID_Asignatura INT,
    ID_Profesor INT,
    Nombre_Clase VARCHAR(255),
    Fecha DATE,
    Hora_Inicio TIME,
    Hora_Fin TIME,
    Ubicacion VARCHAR(255),
    Codigo_QR VARCHAR(255),
    FOREIGN KEY (ID_Asignatura) REFERENCES Asignaturas(ID),
    FOREIGN KEY (ID_Profesor) REFERENCES Profesores(ID)
);

CREATE TABLE Asistencias (
    ID INT PRIMARY KEY,
    ID_Clase INT,
    ID_Alumno INT,
    Fecha_Asistencia DATE,
    Confirmado BOOLEAN,
    Correo VARCHAR(255),
    FOREIGN KEY (ID_Clase) REFERENCES Clases(ID),
    FOREIGN KEY (ID_Alumno) REFERENCES Usuarios(ID)
);

CREATE TABLE Recordatorios (
    ID INT PRIMARY KEY,
    ID_Clase INT,
    Tipo VARCHAR(50),
    Fecha_Envio DATE,
    Mensaje TEXT,
    Presencial BOOLEAN,
    Online BOOLEAN,
    FOREIGN KEY (ID_Clase) REFERENCES Clases(ID)
);

CREATE TABLE Justificaciones (
    ID INT PRIMARY KEY,
    ID_Alumno INT,
    Certificado TEXT,
    Estado ENUM('aprobada', 'rechazada', 'pendiente'),
    Fecha_Envio DATE,
    Fecha_Revision DATE,
    FOREIGN KEY (ID_Alumno) REFERENCES Usuarios(ID)
);