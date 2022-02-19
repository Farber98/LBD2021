-- Punto 1
DROP DATABASE IF EXISTS Choua41144069;
CREATE DATABASE Choua41144069;
USE Choua41144069;


DROP TABLE IF EXISTS Categorias
;
DROP TABLE IF EXISTS Composicion
;
DROP TABLE IF EXISTS MateriaPrima
;
DROP TABLE IF EXISTS Recetas
;
DROP TABLE IF EXISTS RecetasRecetas
;
DROP TABLE IF EXISTS Unidades
;


CREATE TABLE Categorias(
    Nombre    VARCHAR(15)    NOT NULL,
    PRIMARY KEY (Nombre)
)ENGINE=INNODB
;

CREATE TABLE Composicion(
    IDReceta          INT            NOT NULL,
    IDMateriaPrima    INT            NOT NULL,
    Cantidad          FLOAT(8, 0)    NOT NULL
                      CHECK (Cantidad > 0),
    PRIMARY KEY (IDReceta, IDMateriaPrima)
)ENGINE=INNODB
;


CREATE TABLE MateriaPrima(
    IDMateriaPrima    INT            NOT NULL,
    Nombre            VARCHAR(35)    NOT NULL,
    PrecioUnitario    FLOAT(8, 0)    NOT NULL
                      CHECK (PrecioUnitario >0 ),
    Unidad            VARCHAR(10)    NOT NULL,
    PRIMARY KEY (IDMateriaPrima)
)ENGINE=INNODB
;


CREATE TABLE Recetas(
    IDReceta         INT              NOT NULL,
    Rendimiento      FLOAT(8, 0)      NOT NULL
                     CHECK (Rendimiento > 0),
    Procedimiento    VARCHAR(1000)    NOT NULL,
    Nombre           VARCHAR(35)      NOT NULL,
    Unidad           VARCHAR(10)      NOT NULL,
    Categoria        VARCHAR(15)      NOT NULL,
    PRIMARY KEY (IDReceta)
)ENGINE=INNODB
;


CREATE TABLE RecetasRecetas(
    IDReceta        INT            NOT NULL,
    IDComponente    INT            NOT NULL,
    Cantidad        FLOAT(8, 0)    NOT NULL
                    CHECK (Cantidad > 0),
    PRIMARY KEY (IDReceta, IDComponente)
)ENGINE=INNODB
;


CREATE TABLE Unidades(
    Nombre    VARCHAR(10)    NOT NULL,
    PRIMARY KEY (Nombre)
)ENGINE=INNODB
;


CREATE INDEX Ref31 ON Composicion(IDMateriaPrima)
;

CREATE INDEX Ref12 ON Composicion(IDReceta)
;

CREATE UNIQUE INDEX UI_NombreMateriaPrima ON MateriaPrima(Nombre)
;


CREATE INDEX Ref56 ON MateriaPrima(Unidad)
;

CREATE UNIQUE INDEX UI_Nombre ON Recetas(Nombre)
;

CREATE INDEX Ref44 ON Recetas(Categoria)
;

CREATE INDEX Ref55 ON Recetas(Unidad)
;

CREATE INDEX Ref17 ON RecetasRecetas(IDReceta)
;

CREATE INDEX Ref18 ON RecetasRecetas(IDComponente)
;

ALTER TABLE Composicion ADD CONSTRAINT RefMateriaPrima1 
    FOREIGN KEY (IDMateriaPrima)
    REFERENCES MateriaPrima(IDMateriaPrima)
;

ALTER TABLE Composicion ADD CONSTRAINT RefRecetas2 
    FOREIGN KEY (IDReceta)
    REFERENCES Recetas(IDReceta)
;

ALTER TABLE MateriaPrima ADD CONSTRAINT RefUnidades6 
    FOREIGN KEY (Unidad)
    REFERENCES Unidades(Nombre)
;

ALTER TABLE Recetas ADD CONSTRAINT RefCategorias4 
    FOREIGN KEY (Categoria)
    REFERENCES Categorias(Nombre)
;

ALTER TABLE Recetas ADD CONSTRAINT RefUnidades5 
    FOREIGN KEY (Unidad)
    REFERENCES Unidades(Nombre)
;

ALTER TABLE RecetasRecetas ADD CONSTRAINT RefRecetas7 
    FOREIGN KEY (IDReceta)
    REFERENCES Recetas(IDReceta)
;

ALTER TABLE RecetasRecetas ADD CONSTRAINT RefRecetas8 
    FOREIGN KEY (IDComponente)
    REFERENCES Recetas(IDReceta)
;

-- Carga de datos
INSERT INTO `Categorias` (`Nombre`) VALUES ('Tartas');
INSERT INTO `Categorias` (`Nombre`) VALUES ('Cremas Frías');
INSERT INTO `Categorias` (`Nombre`) VALUES ('Masas bases');
INSERT INTO `Categorias` (`Nombre`) VALUES ('Postres');
INSERT INTO `Categorias` (`Nombre`) VALUES ('Coberturas');
INSERT INTO `Categorias` (`Nombre`) VALUES ('Rellenos');
INSERT INTO `Categorias` (`Nombre`) VALUES ('Decoraciones');

INSERT INTO `Unidades` (`Nombre`) VALUES ('g');
INSERT INTO `Unidades` (`Nombre`) VALUES ('cc');
INSERT INTO `Unidades` (`Nombre`) VALUES ('u');
INSERT INTO `Unidades` (`Nombre`) VALUES ('porciones');

INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (1, 'Manteca', 5.06, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (2, 'Azúcar', 4.0065, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (3, 'Huevos', 13.34, 'u');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (4, 'Leche', 11.0, 'cc');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (5, 'Chocolate para taza', 10.1, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (6, 'Harina', 10.0055, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (7, 'Polvo para hornear', 20.06, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (8, 'Bicarbonato de sodio', 10.06, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (9, 'Coñac', 82.0, 'cc');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (10, 'Escencia de vainilla', 15.0, 'cc');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (11, 'Yemas', 28.0, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (12, 'Almidón de maíz', 15.0, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (13, 'Jugo de limón', 10.04, 'cc');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (14, 'Claras', 28.0, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (15, 'Chocolate cobertura', 125, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (16, 'Nueces', 10.2, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (17, 'Dulce de leche', 18, 'g');
INSERT INTO `MateriaPrima` (`IDMateriaPrima`, `Nombre`, `PrecioUnitario`, `Unidad`) VALUES (18, 'Agua', 10.5, 'cc');

INSERT INTO `Recetas` (`IDReceta`, `Rendimiento`, `Procedimiento`, `Nombre`, `Unidad`, `Categoria`) VALUES(1, 500.0, 'Batir ...', 'Merengue', 'g', 'Coberturas');
INSERT INTO `Recetas` (`IDReceta`, `Rendimiento`, `Procedimiento`, `Nombre`, `Unidad`, `Categoria`) VALUES(2, 10.0, 'Mezclar ...', 'Masa frola', 'porciones', 'Masas bases');
INSERT INTO `Recetas` (`IDReceta`, `Rendimiento`, `Procedimiento`, `Nombre`, `Unidad`, `Categoria`) VALUES(3, 3.0, 'Armar ...', 'Lemon Pie', 'porciones', 'Tartas');
INSERT INTO `Recetas` (`IDReceta`, `Rendimiento`, `Procedimiento`, `Nombre`, `Unidad`, `Categoria`) VALUES(4, 6.0, 'Mezclar ...', 'Bizcochuelo', 'porciones', 'Masas bases');

INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('4', '3', 2);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('4', '2', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('4', '6', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('4', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('1', '2', 340);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('1', '14', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('2', '1', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('2', '2', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('2', '11', 80);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('2', '6', 300);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('2', '7', 5);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('2', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('3', '11', 80);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('3', '2', 100);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('3', '12', 40);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('3', '14', 200);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('3', '13', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('3', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDMateriaPrima`, `Cantidad`) VALUES ('4', '14', 250);

INSERT INTO `RecetasRecetas` (`IDReceta`, `IDComponente`, `Cantidad`) VALUES ('3', '1', '650');
INSERT INTO `RecetasRecetas` (`IDReceta`, `IDComponente`, `Cantidad`) VALUES ('3', '2', '10');
INSERT INTO `RecetasRecetas` (`IDReceta`, `IDComponente`, `Cantidad`) VALUES ('3', '3', '12');
INSERT INTO `RecetasRecetas` (`IDReceta`, `IDComponente`, `Cantidad`) VALUES ('4', '3', '6');
INSERT INTO `RecetasRecetas` (`IDReceta`, `IDComponente`, `Cantidad`) VALUES ('4', '1', '750');


-- Punto 5
DROP TABLE IF EXISTS aud_MateriaPrima;

CREATE TABLE aud_MateriaPrima(
    IDAudMateriaPrima INT			 AUTO_INCREMENT,
    IDMateriaPrima    INT            NOT NULL,
    Nombre            VARCHAR(35)    NOT NULL,
    PrecioUnitario    FLOAT(8, 0)    NOT NULL,
    Unidad            VARCHAR(10)    NOT NULL,
    Tipo			  CHAR(1)		 NOT NULL,
    Usuario			  VARCHAR(45)	 NOT NULL,
    Maquina			  VARCHAR(45)	 NOT NULL,
    Fecha		      DATETIME		 NOT NULL,
    PRIMARY KEY (IDAudMateriaPrima)
)ENGINE=INNODB
;

DROP TRIGGER IF EXISTS AuditarMateriaPrima;
DELIMITER $$
CREATE TRIGGER AuditarMateriaPrima
    /*
        Trigger que se ejecuta al momento de eliminar una MateriaPrima.
        Almacena toda la informacion de la materia prima antes de ser borrada.
        Ademas alamcenad la Operacion (B: Borrado en este caso), Usuario que ejecuto la accion, Maquina desde donde se ejecuto y la Fecha y Hora.
    */
    BEFORE DELETE 
    ON MateriaPrima FOR EACH ROW
    BEGIN
    INSERT INTO aud_MateriaPrima 
    SELECT 
        0,
        OLD.IDMateriaPrima,
        OLD.Nombre,
        OLD.PrecioUnitario,
        OLD.Unidad,
        'B',
        SUBSTRING_INDEX(USER(), '@', 1),
        SUBSTRING_INDEX(USER(), '@', -1),
        NOW();   
    END $$
DELIMITER ;

-- Punto 2
DROP PROCEDURE IF EXISTS BorrarMateriaPrima;
DELIMITER $$
CREATE PROCEDURE BorrarMateriaPrima(pIDMateriaPrima INT, OUT pMensaje VARCHAR(255))
SALIR:BEGIN
    /*
        Punto 2. Procedimiento que permite borrar una materia prima.
        Controla que no este utilizada por una recete para poder eliminarla.
        En caso de exito devuelve el Id de la materia prima borrada. 
        En caso de error devuelve una signal con el mensaje de error correspondiente.
    */
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT "Ha ocurrido un error. Intentelo mas tarde nuevamente." INTO pMensaje;
        ROLLBACK;
	END;

    IF pIDMateriaPrima IS NULL THEN
        SELECT "La materia prima ingresada es invalida" INTO pMensaje;
        LEAVE SALIR;
    END IF;

    IF NOT EXISTS(SELECT IDMateriaPrima FROM MateriaPrima WHERE IDMateriaPrima = pIDMateriaPrima) 
    THEN
        SELECT "La materia prima que desea eliminar no existe" INTO pMensaje;
        LEAVE SALIR;
    END IF;

    IF EXISTS(SELECT IDReceta FROM Composicion WHERE IDMateriaPrima = pIDMateriaPrima) THEN
        SELECT "La materia prima no puede ser eliminada, porque esta utilizada en una receta." INTO pMensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        DELETE
        FROM MateriaPrima
        WHERE IDMateriaPrima = pIDMateriaPrima;

        SELECT CONCAT('Se ha borrado con exito la materia prima con ID: ', pIDMateriaPrima) INTO pMensaje;
    COMMIT;
END $$
DELIMITER ;

SET @pMensaje = '';
CALL Choua41144069.BorrarMateriaPrima(18, @pMensaje);
SELECT @pMensaje;
-- Verifico que este en auditoria
SELECT * FROM aud_MateriaPrima;

CALL Choua41144069.BorrarMateriaPrima(NULL, @pMensaje);
-- Espero mensaje de MateriaPrima invalida
SELECT @pMensaje;

CALL Choua41144069.BorrarMateriaPrima(0, @pMensaje);
-- Espero mensaje que no existe materia prima
SELECT @pMensaje;

CALL Choua41144069.BorrarMateriaPrima(14, @pMensaje);
-- Espero mensaje que no puede ser borrada porque esta utilziada en una receta
SELECT @pMensaje;


-- Punto 3
DROP PROCEDURE IF EXISTS VerReceta;
DELIMITER $$
CREATE PROCEDURE VerReceta(pIDReceta INT)
SALIR:BEGIN
    /*
        Procedimiento que permite obtener todos los datos de una receta a partir del ID de la misma.
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_Composicion;
    DROP TEMPORARY TABLE IF EXISTS tmp_RecetasRecetas;

    CREATE TEMPORARY TABLE tmp_Composicion
    SELECT r.IDReceta IDReceta, mp.Nombre Nombre, c.Cantidad Cantidad
    FROM Recetas r
    INNER JOIN Composicion c ON c.IDReceta = r.IDReceta
    INNER JOIN MateriaPrima mp ON mp.IDMateriaPrima = c.IDMateriaPrima
    WHERE r.IDReceta = pIDReceta;

    CREATE TEMPORARY TABLE tmp_RecetasRecetas
    SELECT r.IDReceta IDReceta, rrr.Nombre Nombre, rr.Cantidad Cantidad
    FROM Recetas r
    INNER JOIN RecetasRecetas rr ON rr.IDReceta = r.IDReceta
    INNER JOIN Recetas rrr ON rr.IDComponente = rrr.IDReceta
    WHERE r.IDReceta = pIDReceta;

    SELECT 
        r.Nombre Nombre,
        r.Rendimiento Rendimiento,
        u.Nombre Unidad,
        c.Nombre Categoria,
        CASE
            WHEN tmprr.IDReceta IS NOT NULL THEN tmprr.Nombre
            WHEN tmpc.IDReceta  IS NOT NULL THEN tmpc.Nombre
        END Composicion,
        CASE
            WHEN tmprr.IDReceta IS NOT NULL THEN tmprr.Cantidad
            WHEN tmpc.IDReceta  IS NOT NULL THEN tmpc.Cantidad
        END Cantidad
    FROM Recetas r
    INNER JOIN Categorias c ON c.Nombre = r.Categoria
    INNER JOIN Unidades u ON u.Nombre = r.Unidad
    LEFT JOIN tmp_RecetasRecetas tmprr ON tmprr.IDReceta = r.IDReceta
    LEFT JOIN tmp_Composicion tmpc ON tmpc.IDReceta = r.IDReceta
    WHERE r.IDReceta = pIDReceta
    GROUP BY Nombre, Rendimiento, Unidad, Categoria, Composicion, Cantidad;

    DROP TEMPORARY TABLE IF EXISTS tmp_Composicion;
    DROP TEMPORARY TABLE IF EXISTS tmp_RecetasRecetas;

END $$
DELIMITER ;

CALL Choua41144069.VerReceta(1);
CALL Choua41144069.VerReceta(2);
CALL Choua41144069.VerReceta(3);
CALL Choua41144069.VerReceta(4);
CALL Choua41144069.VerReceta(5);

-- Punto 4

DROP VIEW IF EXISTS RankingMateriasPrimas;

CREATE VIEW RankingMateriasPrimas AS
SELECT mp.Nombre, SUM(c.Cantidad) Cantidad
FROM MateriaPrima mp
INNER JOIN Composicion c ON c.IDMateriaPrima = mp.IDMateriaPrima
GROUP BY mp.Nombre
ORDER BY SUM(c.Cantidad) DESC;

SELECT * FROM RankingMateriasPrimas;
