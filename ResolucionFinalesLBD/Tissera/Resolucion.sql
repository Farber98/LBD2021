-- Año: 2021 
-- Alumno: Farber, Juan.  
-- Nombre del Esquema: 41299818
-- Plataforma (SO + Versión): Ubuntu 20.04.2 LTS (Focal Fossa)
-- Motor y Versión: 8.0.23 for Linux on x86_64 (MySQL Community Server - GPL)
-- Default collation: utf8mb4_0900_ai_ci
-- Default characterset: utf8mb4

-- Creamos la DB.
DROP DATABASE IF EXISTS Tissera;
CREATE DATABASE Tissera;
USE Tissera;

-- 
-- TABLE: Auditoria 
--

CREATE TABLE Auditoria(
    IDAuditoria      INT              AUTO_INCREMENT,
    Fecha            DATETIME         NOT NULL,
    Usuario          VARCHAR(45)      NOT NULL,
    IP               VARCHAR(45)      NOT NULL,
    Tipo             CHAR(35)         NOT NULL
                     CHECK (Tipo IN ('I')),
    IDReceta         INT              NOT NULL,
    Nombre           VARCHAR(35)      NOT NULL,
    Rendimiento      FLOAT      NOT NULL,
    Magnitud         INT              NOT NULL,
    Clase            INT              NOT NULL,
    Procedimiento    VARCHAR(1000)    NOT NULL,
    PRIMARY KEY (IDAuditoria)
)ENGINE=INNODB
;



-- 
-- TABLE: Clases 
--

CREATE TABLE Clases(
    IDClase    INT            NOT NULL,
    Nombre     VARCHAR(15)    NOT NULL,
    PRIMARY KEY (IDClase)
)ENGINE=INNODB
;



-- 
-- TABLE: Magnitudes 
--

CREATE TABLE Magnitudes(
    IDMagnitud    INT            NOT NULL,
    Nombre        VARCHAR(10)    NOT NULL,
    PRIMARY KEY (IDMagnitud)
)ENGINE=INNODB
;



-- 
-- TABLE: Ingrediente 
--

CREATE TABLE Ingrediente(
    IDIngrediente    INT            NOT NULL,
    Nombre           VARCHAR(35)    NOT NULL,
    Precio           FLOAT    NOT NULL
                     CHECK (Precio > 0),
    Magnitud         INT            NOT NULL,
    PRIMARY KEY (IDIngrediente), 
    UNIQUE INDEX UI_Nombre(Nombre),
    INDEX Ref33(Magnitud), 
    CONSTRAINT RefMagnitudes3 FOREIGN KEY (Magnitud)
    REFERENCES Magnitudes(IDMagnitud)
)ENGINE=INNODB
;



-- 
-- TABLE: Recetas 
--

CREATE TABLE Recetas(
    IDReceta         INT              NOT NULL,
    Nombre           VARCHAR(35)      NOT NULL,
    Rendimiento      FLOAT      NOT NULL
                     CHECK (Rendimiento > 0),
    Magnitud         INT              NOT NULL,
    Clase            INT              NOT NULL,
    Procedimiento    VARCHAR(1000)    NOT NULL,
    PRIMARY KEY (IDReceta), 
    UNIQUE INDEX UI_Nombre(Nombre), 
    CONSTRAINT RefClases1 FOREIGN KEY (Clase)
    REFERENCES Clases(IDClase),
    CONSTRAINT RefMagnitudes2 FOREIGN KEY (Magnitud)
    REFERENCES Magnitudes(IDMagnitud)
)ENGINE=INNODB
;



-- 
-- TABLE: Composicion 
--

CREATE TABLE Composicion(
    IDReceta         INT            NOT NULL,
    IDIngrediente    INT            NOT NULL,
    Medida           FLOAT    NOT NULL
                     CHECK (Medida > 0),
    PRIMARY KEY (IDReceta, IDIngrediente), 
    INDEX Ref44(IDIngrediente),
    INDEX Ref15(IDReceta), 
    CONSTRAINT RefIngrediente4 FOREIGN KEY (IDIngrediente)
    REFERENCES Ingrediente(IDIngrediente),
    CONSTRAINT RefRecetas5 FOREIGN KEY (IDReceta)
    REFERENCES Recetas(IDReceta)
)ENGINE=INNODB
;



-- 
-- TABLE: RecetaEnRecetas 
--

CREATE TABLE RecetaEnRecetas(
    IDReceta        INT            NOT NULL,
    IDComponente    INT            NOT NULL,
    Medida          FLOAT    NOT NULL
                    CHECK (Medida > 0),
    PRIMARY KEY (IDReceta, IDComponente), 
    INDEX Ref16(IDReceta),
    INDEX Ref17(IDComponente), 
    CONSTRAINT RefRecetas6 FOREIGN KEY (IDReceta)
    REFERENCES Recetas(IDReceta),
    CONSTRAINT RefRecetas7 FOREIGN KEY (IDComponente)
    REFERENCES Recetas(IDReceta)
)ENGINE=INNODB
;

-- Creamos Trigger para auditoria.
DROP TRIGGER IF EXISTS `Tissera`.`Recetas_AFTER_INSERT`;

DELIMITER $$
USE `Tissera`$$
CREATE TRIGGER `Recetas_AFTER_INSERT` AFTER INSERT ON `Recetas` FOR EACH ROW BEGIN
	INSERT INTO Auditoria VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'I',NEW.IDReceta,NEW.Nombre, NEW.Rendimiento, NEW.Magnitud, NEW.Clase, NEW.Procedimiento);
END$$
DELIMITER ;



-- Inserciones
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (1, 'Tartas');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (2, 'Cremas Frías');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (3, 'Masas bases');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (4, 'Postres');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (5, 'Coberturas');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (6, 'Rellenos');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (7,'Decoraciones');

INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (1, 'g');
INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (2, 'cc');
INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (3, 'u');
INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (4, 'porciones');

INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (1, 'Manteca', 5.06, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (2, 'Azúcar', 4.0065, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (3, 'Huevos', 13.34, 3);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (4, 'Leche', 11.0, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (5, 'Chocolate para taza', 10.1, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (6, 'Harina', 10.0055, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (7, 'Polvo para hornear', 20.06, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (8, 'Bicarbonato de sodio', 10.06, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (9, 'Coñac', 82.0, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (10, 'Escencia de vainilla', 15.0, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (11, 'Yemas', 28.0, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (12, 'Almidón de maíz', 15.0, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (13, 'Jugo de limón', 10.04, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (14, 'Claras', 28.0, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (15, 'Chocolate cobertura', 125, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (16, 'Nueces', 10.2, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (17, 'Dulce de leche', 18, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (18, 'Agua', 10.5, 2);

INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(1, 'Merengue', 500.0, 1, 5, 'Batir ...');
INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(2, 'Masa frola', 10.0, 4, 3, 'Mezclar ...');
INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(3, 'Lemon Pie', 3.0, 4, 1, 'Armar ...');
INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(4, 'Bizcochuelo', 6.0, 4, 3, 'Mezclar ...');

INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '3', 2);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '2', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '6', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('1', '2', 340);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('1', '14', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '1', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '2', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '11', 80);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '6', 300);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '7', 5);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '11', 80);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '2', 100);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '12', 40);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '14', 200);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '13', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '14', 250);

INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('3', '1', '650');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('3', '2', '10');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('3', '3', '12');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('4', '3', '6');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('4', '1', '750');

-- Procedimiento almacenado NuevaReceta
USE `Tissera`;
DROP procedure IF EXISTS `NuevaReceta`;

DELIMITER $$
USE `Tissera`$$
CREATE PROCEDURE `NuevaReceta`(pIDReceta INTEGER, pNombre VARCHAR(35), pRendimiento FLOAT, 
								pMagnitud INTEGER, pClase INTEGER, pProcedimiento VARCHAR(1000), OUT pMensaje VARCHAR(255))
SALIR: BEGIN
/*
	Permite insertar una receta. Controla que los parametros sean ingresados.
    Controla que el ID y el nombre no esten en uso.
    Controla que el rendimiento sea mayor a 0.
    Controla que la clase y la magnitud elegidas existan.
	Devuelve Mensaje de exito + ID o el mensaje de error en pMensaje. 
*/

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
        SELECT "Ha ocurrido un error. Contactese con el administrador." INTO pMensaje;
        ROLLBACK;
	END;

	 -- Controlo pIDReceta
    IF pIDReceta IS NULL OR pIDReceta = 0 THEN
		SELECT 'El ID de la receta es obligatorio.' INTO pMensaje;
        LEAVE SALIR;
    END IF;

	-- Controlo pNombre
    IF pNombre IS NULL OR pNombre = '' THEN
		SELECT 'El nombre de la receta es obligatorio.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pRendimiento
    IF pRendimiento IS NULL OR pRendimiento = 0 THEN
		SELECT 'El rendimiento de la receta es obligatorio.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pMagnitud
    IF pMagnitud IS NULL OR pMagnitud = 0 THEN
		SELECT 'La magnitud de la receta es obligatoria.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pClase
    IF pClase IS NULL OR pClase = 0 THEN
		SELECT 'La clase de la receta es obligatoria.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo pProcedimiento
    IF pProcedimiento IS NULL OR pProcedimiento = '' THEN
		SELECT 'El procedimiento de la receta es obligatorio.' INTO pMensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo que el pIDReceta no este en uso
    IF EXISTS(SELECT IDReceta FROM Recetas WHERE (IDReceta = pIDReceta))
		THEN SELECT 'El ID esta en uso por otra receta.' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlo que el Nombre no este en uso
	IF EXISTS(SELECT Nombre FROM Recetas WHERE (Nombre = pNombre))
		THEN SELECT 'El nombre esta en uso por otra receta.' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlo que el rendimiento sea mayor a 0
	IF pRendimiento <= 0
		THEN SELECT 'El rendimiento debe ser mayor a cero.' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlo que la magnitud elegida exista
    IF NOT EXISTS(SELECT IDMagnitud FROM Magnitudes  WHERE (IDMagnitud = pMagnitud))
		THEN SELECT 'La magnitud elegida no existe.' INTO pMensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlo que que la clase elegida exista
    IF NOT EXISTS(SELECT IDClase FROM Clases WHERE (IDClase = pClase))
		THEN SELECT 'La clase elegida no existe.' INTO pMensaje;
        LEAVE SALIR;
	END IF;

START TRANSACTION;
    -- Inserto
    INSERT INTO Recetas VALUES(pIDReceta, pNombre, pRendimiento, pMagnitud, pClase, pProcedimiento);
	SELECT CONCAT('Se inserto con exito la receta de ID: ', pIDReceta) INTO pMensaje;
COMMIT;
END$$

DELIMITER ;
;

-- Controlo procedimiento almacenado NuevaReceta

SET @pMensaje = '';

CALL NuevaReceta(NULL, NULL, NULL, NULL, NULL, NULL, @pMensaje); -- IDReceta obligatorio.
SELECT @pMensaje;

CALL NuevaReceta(1, NULL, NULL, NULL, NULL, NULL, @pMensaje); -- Nombre obligatorio.
SELECT @pMensaje;

CALL NuevaReceta(1, 'Merengue', NULL, NULL, NULL, NULL, @pMensaje); -- Rendimiento obligatorio   
SELECT @pMensaje;

CALL NuevaReceta(1, 'Merengue', 1, NULL, NULL, NULL, @pMensaje); -- Rendimiento obligatorio   
SELECT @pMensaje;

CALL NuevaReceta(1, 'Merengue', 1, 5, NULL, NULL, @pMensaje); -- Clase obligatoria.
SELECT @pMensaje;

CALL NuevaReceta(1, 'Merengue', 1, 5, 8, NULL, @pMensaje); -- Procedimiento obligatorio.
SELECT @pMensaje;

CALL NuevaReceta(1, 'Merengue', 1, 5, 8, 'Ir al super', @pMensaje); -- ID en uso por otra receta.
SELECT @pMensaje;

CALL NuevaReceta(5, 'Merengue', 1, 5, 8, 'Ir al super', @pMensaje); -- Nombre en uso por otra receta.
SELECT @pMensaje;

CALL NuevaReceta(5, 'Guisito', 1, 5, 8, 'Ir al super', @pMensaje); -- Magnitud elegida no existe.
SELECT @pMensaje;

CALL NuevaReceta(5, 'Guisito', 1, 4, 8, 'Ir al super', @pMensaje); -- Clase elegida no existe.
SELECT @pMensaje;

CALL NuevaReceta(5, 'Guisito', 1, 4, 7, 'Ir al super', @pMensaje); -- Exito + ID.
SELECT @pMensaje;

-- Reviso insercion en auditoria
SELECT * FROM Auditoria; -- 5 Guisito 1 4 7 'Ir al super'

-- Vista RankingIngredientes
DROP VIEW IF EXISTS RankingIngredientes;
CREATE VIEW RankingIngredientes AS
SELECT ROW_NUMBER() OVER (ORDER BY SUM(com.Medida) ASC) AS Ranking, 
ing.Nombre AS Ingrediente, SUM(com.Medida) AS Medida, mag.Nombre AS Magnitud, rec.Nombre AS Receta
FROM Ingrediente ing INNER JOIN Composicion com ON ing.IDIngrediente = com.IDIngrediente
INNER JOIN Recetas rec ON com.IDReceta = rec.IDReceta
INNER JOIN Magnitudes mag ON ing.Magnitud = mag.IDMagnitud
GROUP BY ing.IDIngrediente, ing.Nombre, rec.IDReceta, rec.Nombre
ORDER BY Medida ASC;

-- Reviso vista RankingIngredientes
SELECT * FROM RankingIngredientes;

-- Vista VerRecetas

DROP VIEW IF EXISTS VerRecetas;
CREATE VIEW VerRecetas AS
SELECT rec1.Nombre AS Receta, rec1.Rendimiento, cla.Nombre AS Clase, 
ing.Nombre AS Ingrediente, com.Medida, mag.Nombre AS Magnitud, rec1.Procedimiento
FROM Recetas rec1
INNER JOIN Clases cla ON rec1.Clase = cla.IDClase
INNER JOIN Composicion com ON rec1.IDReceta = com.IDReceta
INNER JOIN Ingrediente ing ON com.IDIngrediente = ing.IDIngrediente 
INNER JOIN Magnitudes mag ON ing.Magnitud = mag.IDMagnitud

UNION

SELECT rec1.Nombre AS Receta, rec1.Rendimiento, cla.Nombre AS Clase, 
rec2.Nombre AS Ingrediente, rer.Medida, mag.Nombre AS Magnitud, rec1.Procedimiento
FROM Recetas rec1
INNER JOIN Clases cla ON rec1.Clase = cla.IDClase
INNER JOIN Magnitudes mag ON rec1.Magnitud = mag.IDMagnitud
INNER JOIN RecetaEnRecetas rer ON rec1.IDReceta = rer.IDReceta
INNER JOIN Recetas rec2 ON rec2.IDReceta = rer.IDComponente
ORDER BY Receta, Ingrediente, Medida;

SELECT * FROM VerRecetas;
