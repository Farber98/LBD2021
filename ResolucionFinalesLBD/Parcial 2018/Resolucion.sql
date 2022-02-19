-- Año: 2021 
-- Alumno: Farber, Juan.  
-- Nombre del Esquema: 41299818
-- Plataforma (SO + Versión): Ubuntu 20.04.2 LTS (Focal Fossa)
-- Motor y Versión: 8.0.23 for Linux on x86_64 (MySQL Community Server - GPL)
-- Default collation: utf8mb4_0900_ai_ci
-- Default characterset: utf8mb4

-- Creamos la DB.
DROP DATABASE IF EXISTS Parcial2018;
CREATE DATABASE Parcial2018;
USE Parcial2018;

-- 
-- TABLE: Personas 
--

CREATE TABLE Personas(
    dni          INT            NOT NULL,
    apellidos    VARCHAR(40)    NOT NULL,
    nombres      VARCHAR(40)    NOT NULL,
    PRIMARY KEY (dni)
)ENGINE=INNODB
;



-- 
-- TABLE: Alumnos 
--

CREATE TABLE Alumnos(
    dni    INT        NOT NULL,
    cx     CHAR(7)    NOT NULL,
    PRIMARY KEY (dni), 
    UNIQUE INDEX UI_cx(cx),
    INDEX Ref48(dni), 
    CONSTRAINT RefPersonas8 FOREIGN KEY (dni)
    REFERENCES Personas(dni)
)ENGINE=INNODB
;



-- 
-- TABLE: Trabajos 
--

CREATE TABLE Trabajos(
    idTrabajo            INT             NOT NULL,
    titulo               VARCHAR(100)    NOT NULL,
    duracion             INT             DEFAULT 6 NOT NULL,
    area                 VARCHAR(10)     NOT NULL
                         CHECK (area IN ('Hardware', 'Redes', 'Software')),
    fechaPresentacion    DATE            NOT NULL,
    fechaAprobacion      DATE            NOT NULL,
    fechaFinalizacion    DATE,
    PRIMARY KEY (idTrabajo), 
    UNIQUE INDEX UI_titulo(titulo)
)ENGINE=INNODB
;



-- 
-- TABLE: AlumnosEnTrabajos 
--

CREATE TABLE AlumnosEnTrabajos(
    idTrabajo    INT             NOT NULL,
    dni          INT             NOT NULL,
    desde        DATE            NOT NULL,
    hasta        DATE,
    razon        VARCHAR(100),
    PRIMARY KEY (idTrabajo, dni), 
    INDEX Ref12(idTrabajo),
    INDEX Ref76(dni), 
    CONSTRAINT RefTrabajos2 FOREIGN KEY (idTrabajo)
    REFERENCES Trabajos(idTrabajo),
    CONSTRAINT RefAlumnos6 FOREIGN KEY (dni)
    REFERENCES Alumnos(dni)
)ENGINE=INNODB
;



-- 
-- TABLE: Auditoria 
--

CREATE TABLE Auditoria(
    idAuditoria          INT             AUTO_INCREMENT,
    fechaAuditoria       DATETIME        NOT NULL,
    usuario              VARCHAR(45)     NOT NULL,
    ip                   VARCHAR(45)     NOT NULL,
    tipo                 CHAR(1)         NOT NULL
                         CHECK (tipo IN ('I', 'A', 'D', 'B')),
    idTrabajo            INT             NOT NULL,
    titulo               VARCHAR(100)    NOT NULL,
    duracion             INT             NOT NULL,
    area                 VARCHAR(10)     NOT NULL,
    fechaPresentacion    DATE            NOT NULL,
    fechaAprobacion      DATE            NOT NULL,
    fechaFinalizacion    DATE,
    PRIMARY KEY (idAuditoria)
)ENGINE=INNODB
;



-- 
-- TABLE: Cargos 
--

CREATE TABLE Cargos(
    idCargo    INT            NOT NULL,
    cargo      VARCHAR(20)    NOT NULL,
    PRIMARY KEY (idCargo), 
    UNIQUE INDEX UI_cargo(cargo)
)ENGINE=INNODB
;



-- 
-- TABLE: Profesores 
--

CREATE TABLE Profesores(
    dni        INT    NOT NULL,
    idCargo    INT    NOT NULL,
    PRIMARY KEY (dni), 
    INDEX Ref84(idCargo),
    INDEX Ref47(dni), 
    CONSTRAINT RefCargos4 FOREIGN KEY (idCargo)
    REFERENCES Cargos(idCargo),
    CONSTRAINT RefPersonas7 FOREIGN KEY (dni)
    REFERENCES Personas(dni)
)ENGINE=INNODB
;



-- 
-- TABLE: RolesEnTrabajos 
--

CREATE TABLE RolesEnTrabajos(
    idTrabajo    INT             NOT NULL,
    dni          INT             NOT NULL,
    rol          VARCHAR(7)      NOT NULL
                 CHECK (rol IN ('Tutor', 'Cotutor', 'Jurado')),
    desde        DATE            NOT NULL,
    hasta        DATE,
    razon        VARCHAR(100),
    PRIMARY KEY (idTrabajo, dni), 
    INDEX Ref11(idTrabajo),
    INDEX Ref65(dni), 
    CONSTRAINT RefTrabajos1 FOREIGN KEY (idTrabajo)
    REFERENCES Trabajos(idTrabajo),
    CONSTRAINT RefProfesores5 FOREIGN KEY (dni)
    REFERENCES Profesores(dni)
)ENGINE=INNODB
;

-- Inserciones
INSERT INTO Cargos VALUES(1, 'Titular');
INSERT INTO Cargos VALUES(2, 'Asociado');
INSERT INTO Cargos VALUES(3, 'Adjunto');
INSERT INTO Cargos VALUES(4, 'JTP');
INSERT INTO Cargos VALUES(5, 'ADG');

INSERT INTO Personas VALUES(1001, 'Mendiondo', 'Matías');
INSERT INTO Personas VALUES(1002, 'Odstrcil', 'Maximiliano');
INSERT INTO Personas VALUES(1003, 'Nieto', 'Luis');
INSERT INTO Personas VALUES(1004, 'Odstrcil', 'Gabriela');
INSERT INTO Personas VALUES(1005, 'Luccioni', 'Griselda');
INSERT INTO Personas VALUES(1006, 'Saade', 'Sergio');
INSERT INTO Personas VALUES(1007, 'Albaca', 'Carlos');
INSERT INTO Personas VALUES(1008, 'Nahas', 'Romina');
INSERT INTO Personas VALUES(1009, 'Cohen', 'Daniel');
INSERT INTO Personas VALUES(1010, 'Guzmán', 'Fernanda');
INSERT INTO Personas VALUES(1011, 'Sánchez', 'Mariana');
INSERT INTO Personas VALUES(1012, 'Juárez', 'Gustavo');
INSERT INTO Personas VALUES(1013, 'Menéndez', 'Franco');
INSERT INTO Personas VALUES(1014, 'Mitre', 'Marcelo');
INSERT INTO Personas VALUES(1015, 'Ferrao', 'Nilda');
INSERT INTO Personas VALUES(1016, 'Pérez', 'Jorge');
INSERT INTO Personas VALUES(1017, 'Volentini', 'Esteban');
INSERT INTO Personas VALUES(1018, 'Nader', 'Fernando');
INSERT INTO Personas VALUES(1019, 'Rossi', 'Guillermo');
INSERT INTO Personas VALUES(1020, 'Pacheco', 'Fabián');
INSERT INTO Personas VALUES(1021, 'Cardozo', 'Teresa');
INSERT INTO Personas VALUES(1, 'Ortíz', 'Juan Pablo');
INSERT INTO Personas VALUES(2, 'Ledesma', 'Facundo');
INSERT INTO Personas VALUES(3, 'Pary', 'Nélson Guillermo');
INSERT INTO Personas VALUES(4, 'Albarracín', 'María Carolina');
INSERT INTO Personas VALUES(5, 'Bono', 'Gustavo');
INSERT INTO Personas VALUES(6, 'Uezen', 'Héctor');
INSERT INTO Personas VALUES(7, 'Mariné', 'Juan Luis');
INSERT INTO Personas VALUES(8, 'Sfriso', 'Mauricio');
INSERT INTO Personas VALUES(30357705, 'Guanco', 'Juan Marcos');
INSERT INTO Personas VALUES(10, 'Gómez Salas', 'Pablo');
INSERT INTO Personas VALUES(11, 'Ferrari', 'Franco');
INSERT INTO Personas VALUES(12, 'Rodríguez', 'Jorge Luis');
INSERT INTO Personas VALUES(13, 'Córdoba', 'Facundo Sebastián');


INSERT INTO Profesores VALUES(1001, 5);
INSERT INTO Profesores VALUES(1002, 2);
INSERT INTO Profesores VALUES(1003, 2);
INSERT INTO Profesores VALUES(1004, 4);
INSERT INTO Profesores VALUES(1005, 1);
INSERT INTO Profesores VALUES(1006, 1);
INSERT INTO Profesores VALUES(1007, 4);
INSERT INTO Profesores VALUES(1008, 3);
INSERT INTO Profesores VALUES(1009, 1);
INSERT INTO Profesores VALUES(1010, 3);
INSERT INTO Profesores VALUES(1011, 3);
INSERT INTO Profesores VALUES(1012, 2);
INSERT INTO Profesores VALUES(1013, 3);
INSERT INTO Profesores VALUES(1014, 3);
INSERT INTO Profesores VALUES(1015, 2);
INSERT INTO Profesores VALUES(1016, 2);
INSERT INTO Profesores VALUES(1017, 3);
INSERT INTO Profesores VALUES(1018, 3);
INSERT INTO Profesores VALUES(1019, 5);
INSERT INTO Profesores VALUES(1020, 5);
INSERT INTO Profesores VALUES(1021, 4);

INSERT INTO Alumnos VALUES(1, '1414641');
INSERT INTO Alumnos VALUES(2, '1412969');
INSERT INTO Alumnos VALUES(3, '1414822');
INSERT INTO Alumnos VALUES(4, '1408513');
INSERT INTO Alumnos VALUES(5, '1409492');
INSERT INTO Alumnos VALUES(6, '1417417');
INSERT INTO Alumnos VALUES(7, '1413513');
INSERT INTO Alumnos VALUES(8, '1416773');
INSERT INTO Alumnos VALUES(30357705, '0303890');
INSERT INTO Alumnos VALUES(10, '1411805');
INSERT INTO Alumnos VALUES(11, '1411300');
INSERT INTO Alumnos VALUES(12, '1415802');
INSERT INTO Alumnos VALUES(13, '1410486');

INSERT INTO Trabajos VALUES(1, 'Sistema de Gestión de Presupuestación de Obras de Construcción', 6, 'Software', '2018-05-04', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(2, 'Implementación de políticas de tráfico para enrutamiento con BGP', 6, 'Redes', '2018-05-04', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(3, 'Sistema de Gestión y Seguimiento de Trabajos de Graduación de Ingeniería en Computación', 9, 'Software', '2015-12-15', '2015-12-15', NULL);
INSERT INTO Trabajos VALUES(4, 'Sistema de gestión y página web para una escuela de cocina', 6, 'Software', '2017-04-03', '2017-04-03', NULL);
INSERT INTO Trabajos VALUES(5, 'Módulo de interfaz de usuario de sistema SCADA', 6, 'Software', '2018-05-09', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(6, 'Realización de filtros digitales empleando operador delta', 5, 'Software', '2014-04-16', '2014-05-13', NULL);
INSERT INTO Trabajos VALUES(7, 'Sistema de seguimiento de egresados', 6, 'Software', '2018-03-01', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(8, 'Sistema gestor para farmacia de Centro Asistencia Primaria de Salud (CAPS)', 6, 'Software', '2017-11-29', '2017-11-29', NULL);

INSERT INTO RolesEnTrabajos VALUES(1, 1001, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1002, 'Cotutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1003, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1004, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1005, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1018, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1006, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1007, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1008, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1012, 'Tutor', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1013, 'Cotutor', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1003, 'Jurado', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1009, 'Jurado', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1006, 'Jurado', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1007, 'Tutor', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1003, 'Jurado', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1010, 'Jurado', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1011, 'Jurado', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1019, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1002, 'Cotutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1003, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1012, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1014, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1020, 'Tutor', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1015, 'Jurado', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1016, 'Jurado', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1017, 'Jurado', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1003, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1009, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1010, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1011, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1010, 'Tutor', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1021, 'Cotutor', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1003, 'Jurado', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1004, 'Jurado', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1011, 'Jurado', '2017-11-29', NULL, NULL);

INSERT INTO AlumnosEnTrabajos VALUES(1, 1, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(1, 2, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(2, 3, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(3, 4, '2015-12-15', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(4, 5, '2017-04-03', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(4, 6, '2017-04-03', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(5, 7, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(5, 8, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(6, 30357705, '2014-05-13', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(7, 10, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(7, 11, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(8, 12, '2017-11-29', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(6, 13, '2017-11-29', NULL, NULL);


-- SP NuevoTrabajo
USE `Parcial2018`;
DROP procedure IF EXISTS `NuevoTrabajo`;

DELIMITER $$
USE `Parcial2018`$$
CREATE PROCEDURE `NuevoTrabajo`(pIDTrabajo INTEGER, pTitulo VARCHAR(100),
								pDuracion INTEGER, pArea VARCHAR(10),
                                pFechaPresentacion DATE,
                                pFechaAprobacion DATE,
                                pFechaFinalizacion DATE,
                                OUT pMensaje VARCHAR(255))
SALIR: BEGIN
/*
	Permite insertar un nuevo trabajo. Controla que los parametros sean ingresados.
    Controla que la fecha de aprobacion sea mayor o igual a la fecha de presentacion.
    Controla que la fecha de aprobacion sea mayor o igual a la de presentacion.
    Controla que el ID no este en uso.
    Controla que el area corresponda.
    Controla que el titulo sea unico.
    Controla que la duracion sea mayor a 0.
	Devuelve Mensaje de exito + ID o el mensaje de error en pMensaje.  
*/

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
        SELECT "Ha ocurrido un error. Contactese con el administrador." INTO pMensaje;
        ROLLBACK;
	END;
	
	 -- Controlo pIDTrabajo
    IF pIDTrabajo IS NULL OR pIDTrabajo = 0 THEN
		SELECT 'El ID del trabajo es invalido.' INTO pMensaje;
        LEAVE SALIR;
    END IF;

	-- Controlo pTitulo
    IF pTitulo IS NULL OR pTitulo = '' THEN
		SELECT 'El titulo es invalido.' INTO pMensaje;
        LEAVE SALIR;
    END IF;

	-- Controlo pDuracion
     IF pDuracion IS NULL OR pDuracion <= 0 THEN
		SELECT 'La duracion es invalida.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pArea
    IF pArea IS NULL OR pArea = '' THEN
		SELECT 'El area es invalida.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pFechaPresentacion
    IF pFechaPresentacion IS NULL THEN
		SELECT 'La fecha de presentacion es invalida.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pFechaAprobacion
		IF pFechaAprobacion IS NULL THEN
		SELECT 'La fecha de aprobacion es invalida.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
	-- Controla pIDTrabajo no este repetido
    IF EXISTS(SELECT idTrabajo FROM Trabajos WHERE (idTrabajo = pIDTrabajo))
		THEN SELECT 'El ID esta en uso por otro trabajo.' INTO pMensaje;
        LEAVE SALIR;
	END IF;

	-- Controlo titulo unico
    IF EXISTS(SELECT titulo FROM Trabajos WHERE (titulo = pTitulo))
		THEN SELECT 'El titulo esta en uso por otro trabajo.' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlo areas correspondientes
    IF pArea != 'Hardware' AND pArea != 'Redes' AND pArea != 'Software' THEN
		SELECT 'El area no corresponde con Software, Hardware o Redes.' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controla que la fecha de aprobacion sea mayor o igual a la de presentacion.
	IF pFechaAprobacion < pFechaPresentacion THEN
		SELECT 'La aprobacion no puede ser antes de la presentacion' INTO pMensaje;
        LEAVE SALIR;
	END IF;

	-- Controla que la fecha de finalizacion sea mayor o igual a la fecha de Aprobacion.
	IF pFechaFinalizacion < pFechaAprobacion THEN
		SELECT 'La finalizacion no puede ser antes de la aprobacion' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
START TRANSACTION;
	INSERT INTO Trabajos VALUES(pIDTrabajo, pTitulo, pDuracion, pArea, pFechaPresentacion, pFechaAprobacion, pFechaFinalizacion);
	SELECT CONCAT('Se inserto con exito el trabajo de ID: ', pIDTrabajo) INTO pMensaje;
COMMIT;
    
END$$

DELIMITER ;
;

-- Probamos SP.
SET @pMensaje = '';

CALL NuevoTrabajo(NULL, NULL, NULL, NULL, NULL, NULL, NULL, @pMensaje); -- ID es invalido
SELECT @pMensaje;
CALL NuevoTrabajo(1, NULL, NULL, NULL, NULL, NULL, NULL, @pMensaje); -- El titulo es invalido
SELECT @pMensaje;
CALL NuevoTrabajo(1, 'Sistema de seguimiento de egresados', NULL, NULL, NULL, NULL, NULL, @pMensaje); -- La duracion es invalida
SELECT @pMensaje;
CALL NuevoTrabajo(1, 'Sistema de seguimiento de egresados', 5, NULL, NULL, NULL, NULL, @pMensaje); -- El area es invalida
SELECT @pMensaje;
CALL NuevoTrabajo(1, 'Sistema de seguimiento de egresados', 5, 'mat', NULL, NULL, NULL, @pMensaje); -- La fecha de presentacion es invalida.
SELECT @pMensaje;
CALL NuevoTrabajo(1, 'Sistema de seguimiento de egresados', 5, 'mat', '2000-10-10', NULL, NULL, @pMensaje); -- La fecha de presentacion es invalida.
SELECT @pMensaje;
CALL NuevoTrabajo(1, 'Sistema de seguimiento de egresados', 5, 'mat', '2000-10-10', '2010-10-10', NULL, @pMensaje); -- ID en uso por otro trabajo.
SELECT @pMensaje;
CALL NuevoTrabajo(9, 'Probando', 5, 'Redes', '2000-10-10', '1998-10-10', '1997-10-10', @pMensaje); -- Aprobacion no puede ser antes de la presentacion.
SELECT @pMensaje;
CALL NuevoTrabajo(9, 'Probando', 5, 'Redes', '1996-10-10', '1998-10-10', '1997-10-10', @pMensaje); -- Finalizacion no puede ser antes de la Aprobacion.
SELECT @pMensaje;
CALL NuevoTrabajo(9, 'Probando', 5, 'Redes', '1996-10-10', '1998-10-10', '1999-10-10', @pMensaje); -- Finalizacion no puede ser antes de la Aprobacion.
SELECT @pMensaje;

-- Creamos Trigger
DROP TRIGGER IF EXISTS `Parcial2018`.`Trabajos_AFTER_INSERT`;

DELIMITER $$
USE `Parcial2018`$$
CREATE DEFINER=`juan`@`localhost` TRIGGER `Trabajos_AFTER_INSERT` AFTER INSERT ON `Trabajos` FOR EACH ROW BEGIN
	IF(NEW.duracion > 12 OR NEW.duracion < 3) THEN
		INSERT INTO Auditoria VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
		'I',NEW.idTrabajo, NEW.titulo, NEW.duracion, NEW.area, NEW.fechaPresentacion, NEW.fechaAprobacion, NEW.fechaFinalizacion);
    END IF; 
END$$
DELIMITER ;

-- Insertamos para probar auditoria
CALL NuevoTrabajo(10, 'Probando menos', 2, 'Redes', '1996-10-10', '1998-10-10', '2000-10-10', @pMensaje); -- Aprobacion no puede ser antes de la presentacion.
SELECT @pMensaje;
CALL NuevoTrabajo(11, 'Probando mas', 14, 'Redes', '1996-10-10', '1998-10-10', '2000-10-10', @pMensaje); -- Finalizacion no puede ser antes de la Aprobacion.
SELECT @pMensaje;

-- Chequeamos auditoria
SELECT * FROM Auditoria;

-- SP Detalles Roles
USE `Parcial2018`;
DROP procedure IF EXISTS `DetallesRoles`;

DELIMITER $$
USE `Parcial2018`$$
CREATE PROCEDURE `DetallesRoles`(pFechaInicio DATE, pFechaFin DATE, OUT pMensaje VARCHAR(255))
SALIR:BEGIN
/*
	Reciba un rango de años y que muestre:
	Año, DNI, Apellidos, Nombres, Tutor, Cotutor y Jurado, donde Tutor, Cotutor y Jurado muestran
	la cantidad de trabajos en los que un profesor participó en un trabajo con ese rol entre el rango
	de fechas especificado. El listado se mostrará ordenado por año, apellidos, nombres y DNI (se
	pueden emplear vistas u otras estructuras para lograr la funcionalidad solicitada. Para obtener
	el año de una fecha se puede emplear la función YEAR().
*/

	DECLARE pAux DATE;

	IF pFechaInicio IS NULL THEN
		SELECT 'Debe especificarse inicio del rango.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
	IF pFechaFin IS NULL THEN
		SELECT 'Debe especificarse finalizacion del rango.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
	
    -- Ordenamos las fechas cruzadas.
    IF pFechaInicio > pFechaFin THEN
		SET pAux = pFechaInicio;
        SET pFechaInicio = pFechaFin;
        SET pFechaFin = pAux;
	END IF;

DROP TEMPORARY TABLE IF EXISTS tmp;
CREATE TEMPORARY TABLE tmp AS 
SELECT 		YEAR(ret.desde) AS Año, pro.dni, per.apellidos, per.nombres, ret.rol
FROM		RolesEnTrabajos ret
INNER JOIN	Trabajos tra ON ret.idTrabajo = tra.idTrabajo
INNER JOIN	Profesores pro ON ret.dni = pro.dni
INNER JOIN 	Personas per ON pro.dni = per.dni
WHERE		YEAR(ret.desde) BETWEEN YEAR(pFechaInicio) AND YEAR(pFechaFin)
ORDER BY 	YEAR(ret.desde), per.apellidos, per.nombres, pro.dni, ret.rol;

SELECT Año,dni, apellidos, nombres,
		SUM(IF( rol = 'Tutor',1,0)) AS Tutor, SUM(IF( rol = 'Cotutor',1,0)) AS Cotutor, SUM(IF( rol = 'Jurado',1,0)) AS Jurado
FROM tmp
GROUP BY Año,dni, apellidos, nombres
ORDER BY Año, apellidos, nombres, dni;
DROP TEMPORARY TABLE IF EXISTS tmp;
END$$

DELIMITER ;
;

-- Probamos SP.
CALL DetallesRoles(null,null,@pMensaje); -- Debe especificarse inicio del rango.
SELECT @pMensaje;
CALL DetallesRoles('2012-05-05',null,@pMensaje); -- Debe especificarse finalizacion del rango.
SELECT @pMensaje;
CALL DetallesRoles('2013-09-09','2015-05-05',@pMensaje);  -- Muestra informacion.