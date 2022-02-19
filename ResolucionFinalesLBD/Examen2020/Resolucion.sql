-- Año: 2021 
-- Alumno: Farber, Juan.  
-- Nombre del Esquema: 41299818
-- Plataforma (SO + Versión): Ubuntu 20.04.2 LTS (Focal Fossa)
-- Motor y Versión: 8.0.23 for Linux on x86_64 (MySQL Community Server - GPL)
-- Default collation: utf8mb4_0900_ai_ci
-- Default characterset: utf8mb4


-- Creamos la BD
DROP DATABASE IF EXISTS Examen2020;
CREATE DATABASE Examen2020;
USE Examen2020;

-- 
-- TABLE: Pintores 
--

CREATE TABLE Pintores(
    IDPintor        INT            NOT NULL,
    Apellidos       VARCHAR(30)    NOT NULL,
    Nombres         VARCHAR(30)    NOT NULL,
    Nacionalidad    VARCHAR(30)    NOT NULL,
    PRIMARY KEY (IDPintor), 
    INDEX IX_ApellidosNombres(Apellidos, Nombres)
)ENGINE=INNODB
;



-- 
-- TABLE: Metodos 
--

CREATE TABLE Metodos(
    IDMetodo    INT            NOT NULL,
    Metodo      VARCHAR(30)    NOT NULL,
    PRIMARY KEY (IDMetodo), 
    UNIQUE INDEX UI_Metodo(Metodo)
)ENGINE=INNODB
;



-- 
-- TABLE: Cuadros 
--

CREATE TABLE Cuadros(
    IDCuadro    INT               NOT NULL,
    IDPintor    INT               NOT NULL,
    IDMetodo    INT               NOT NULL,
    Titulo      VARCHAR(60)       NOT NULL,
    Fecha       DATE              NOT NULL,
    Precio      DECIMAL(12, 2)    NOT NULL
                CHECK (Precio > 0),
    PRIMARY KEY (IDCuadro, IDPintor), 
    UNIQUE INDEX UI_IDCuadro(IDCuadro),
    INDEX IX_Titulo(Titulo),
    INDEX IX_Fecha(Fecha),
    INDEX Ref45(IDPintor),
    INDEX Ref27(IDMetodo), 
    CONSTRAINT RefPintores5 FOREIGN KEY (IDPintor)
    REFERENCES Pintores(IDPintor),
    CONSTRAINT RefMetodos7 FOREIGN KEY (IDMetodo)
    REFERENCES Metodos(IDMetodo)
)ENGINE=INNODB
;



-- 
-- TABLE: Exhibiciones 
--

CREATE TABLE Exhibiciones(
    IDExhibicion    INT             NOT NULL,
    Titulo          VARCHAR(50)     NOT NULL,
    Descripcion     VARCHAR(200),
    Inauguracion    DATE            NOT NULL,
    Clausura        DATE,
    PRIMARY KEY (IDExhibicion), 
    INDEX IX_Titulo(Titulo),
    CONSTRAINT chk_1  CHECK (Inauguracion < Clausura),
    CONSTRAINT chk_2 CHECK (Clausura > Inauguracion)
)ENGINE=INNODB
;



-- 
-- TABLE: Certamenes 
--

CREATE TABLE Certamenes(
    IDCuadro        INT    NOT NULL,
    IDPintor        INT    NOT NULL,
    IDExhibicion    INT    NOT NULL,
    PRIMARY KEY (IDCuadro, IDPintor, IDExhibicion), 
    INDEX Ref31(IDCuadro, IDPintor),
    INDEX Ref42(IDPintor),
    INDEX Ref13(IDExhibicion), 
    CONSTRAINT RefCuadros1 FOREIGN KEY (IDCuadro, IDPintor)
    REFERENCES Cuadros(IDCuadro, IDPintor),
    CONSTRAINT RefPintores2 FOREIGN KEY (IDPintor)
    REFERENCES Pintores(IDPintor),
    CONSTRAINT RefExhibiciones3 FOREIGN KEY (IDExhibicion)
    REFERENCES Exhibiciones(IDExhibicion)
)ENGINE=INNODB
;



-- 
-- TABLE: Propuestas 
--

CREATE TABLE Propuestas(
    IDPropuesta     CHAR(10)          NOT NULL,
    IDCuadro        INT               NOT NULL,
    IDPintor        INT               NOT NULL,
    IDExhibicion    INT               NOT NULL,
    Fecha           DATE,
    Importe         DECIMAL(12, 2)    NOT NULL
                    CHECK (Importe > 0),
    Persona         VARCHAR(100)      NOT NULL,
    Vendido         CHAR(1)           NOT NULL
                    CHECK (Vendido IN ('S', 'N')),
    PRIMARY KEY (IDPropuesta, IDCuadro, IDPintor, IDExhibicion), 
    UNIQUE INDEX UI_IDPropuesta(IDPropuesta),
    INDEX IX_Fecha(Fecha),
    INDEX IX_Persona(Persona),
    INDEX Ref64(IDCuadro, IDPintor, IDExhibicion), 
    CONSTRAINT RefCertamenes4 FOREIGN KEY (IDCuadro, IDPintor, IDExhibicion)
    REFERENCES Certamenes(IDCuadro, IDPintor, IDExhibicion)
)ENGINE=INNODB
;

-- Tabla para auditoria

-- 
-- TABLE: Auditoria 
--

CREATE TABLE Auditoria(
    IDAuditoria       INT               AUTO_INCREMENT,
    FechaAuditoria    DATETIME          NOT NULL,
    Usuario           VARCHAR(45)       NOT NULL,
    IP                VARCHAR(45)       NOT NULL,
    Tipo              CHAR(1)           NOT NULL
                      CHECK (Tipo IN ('I', 'A', 'D', 'B')),
    IDCuadro          INT               NOT NULL,
    IDPintor          INT               NOT NULL,
    IDMetodo          INT               NOT NULL,
    Titulo            VARCHAR(60)       NOT NULL,
    Fecha             DATE              NOT NULL,
    Precio            DECIMAL(12, 2)    NOT NULL,
    PRIMARY KEY (IDAuditoria)
);

-- Trigger para auditoria.
DROP TRIGGER IF EXISTS `Examen2020`.`Cuadros_AFTER_DELETE`;

DELIMITER $$
USE `Examen2020`$$
CREATE TRIGGER `Examen2020`.`Cuadros_AFTER_DELETE` AFTER DELETE ON `Cuadros` FOR EACH ROW
BEGIN
/* Trigger para auditar los borrados en la tabla Cuadros. */
	INSERT INTO Auditoria VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'B',OLD.IDCuadro, OLD.IDPintor, OLD.IDMetodo, OLD.Titulo, OLD.Fecha, OLD.Precio);
END$$
DELIMITER ;

-- Insercion de datos.
INSERT INTO Pintores VALUES(1,'Miró', 'Joan', 'Española');
INSERT INTO Pintores VALUES(2,'Dalí', 'Salvador', 'Española');
INSERT INTO Pintores VALUES(3,'Monet', 'Claude', 'Francesa');
INSERT INTO Pintores VALUES(4,'Escher', 'Maurits', 'Holandesa');
INSERT INTO Pintores VALUES(5,'Spilimbergo', 'Lino', 'Argentina');
INSERT INTO Pintores VALUES(6,'Quinquela Martin', 'Benito', 'Argentina');

INSERT INTO Metodos VALUES(1,'Impresionismo');
INSERT INTO Metodos VALUES(2,'Surrealismo');
INSERT INTO Metodos VALUES(3,'Naturalismo');
INSERT INTO Metodos VALUES(4,'Matemático');
INSERT INTO Metodos VALUES(5,'Realismo');

INSERT INTO Exhibiciones VALUES(1,'Los Surrealistas', 'Renombradas Cuadros de Pintores surrealistas','2009-11-01','2009-12-30');
INSERT INTO Exhibiciones VALUES(2,'Los Españoles', 'Cuadros de pintores españoles','2010-01-01','2010-03-30');
INSERT INTO Exhibiciones VALUES(3,'Los Argentinos', 'Renombradas Cuadros de Pintores argentinos','2010-04-01','2010-05-30');
INSERT INTO Exhibiciones VALUES(4,'Expo Universal', 'Las mejores Cuadros del mundo','2010-06-01','2010-10-30');

INSERT INTO Cuadros VALUES(1,1,2,'Carnaval del Arlequín','1925-01-01',34000000);
INSERT INTO Cuadros VALUES(2,1,2,'Retrato IV','1938-02-11',36000000);
INSERT INTO Cuadros VALUES(3,1,2,'Azul 3','1961-05-01',22000000);
INSERT INTO Cuadros VALUES(4,1,2,'Personaje delante del sol','1968-05-21',46000000);
INSERT INTO Cuadros VALUES(5,1,2,'Tapiz Tarragona','1970-12-15',41000000);
INSERT INTO Cuadros VALUES(6,2,2,'Figura Asomada a la Ventana','1925-10-04',66000000);
INSERT INTO Cuadros VALUES(7,2,2,'El enigma del deseo','1929-05-17',60000000);
INSERT INTO Cuadros VALUES(8,2,2,'El Hombre Invisible','1929-12-14',76000000);
INSERT INTO Cuadros VALUES(9,2,2,'La persistencia de la memoria','1931-06-27',99000000);
INSERT INTO Cuadros VALUES(10,2,2,'Cristo de San Juan de la Cruz','1951-02-06',97000000);
INSERT INTO Cuadros VALUES(11,3,1,'El Desayuno','1865-02-09',77000000);
INSERT INTO Cuadros VALUES(12,3,1,'Mujeres en el Jardín','1866-04-11',96000000);
INSERT INTO Cuadros VALUES(13,3,1,'Impresión, sol naciente','1873-06-01',99000000);
INSERT INTO Cuadros VALUES(14,3,1,'Puente sobre el Sena','1874-07-13',69000000);
INSERT INTO Cuadros VALUES(15,3,1,'Metamorfosis II','1940-02-22',11000000);
INSERT INTO Cuadros VALUES(16,4,4,'Casa de Escaleras','1951-09-01',12000000);
INSERT INTO Cuadros VALUES(17,4,4,'Día y Noche','1939-05-19',21000000);
INSERT INTO Cuadros VALUES(18,4,4,'Reptiles','1943-07-13',9000000);
INSERT INTO Cuadros VALUES(19,4,4,'Manos Dibujando','1948-10-08',30000000);
INSERT INTO Cuadros VALUES(20,4,4,'Cascada','1961-04-23',23000000);
INSERT INTO Cuadros VALUES(21,5,5,'Autorretrato','1917-01-14',1000000);
INSERT INTO Cuadros VALUES(22,5,5,'Canto a la luna','1923-05-11',2000000);
INSERT INTO Cuadros VALUES(23,5,5,'Desnudo de mujer','1926-07-02',3000000);
INSERT INTO Cuadros VALUES(24,5,5,'Acróbata','1927-11-13',1500000);
INSERT INTO Cuadros VALUES(25,5,5,'Paisaje de San Juan','1929-01-26',2500000);
INSERT INTO Cuadros VALUES(26,6,3,'Nocturno','1930-02-20',1300000);
INSERT INTO Cuadros VALUES(27,6,3,'Chimeneas','1930-11-02',3000000);
INSERT INTO Cuadros VALUES(28,6,3,'La Despedida','1936-07-11',5000000);
INSERT INTO Cuadros VALUES(29,6,3,'Desfile del circo','1936-09-15',7000000);
INSERT INTO Cuadros VALUES(30,6,3,'Música y Danza','1936-04-19',3500000);

INSERT INTO Certamenes VALUES(1,1,1);
INSERT INTO Certamenes VALUES(3,1,1);
INSERT INTO Certamenes VALUES(5,1,1);
INSERT INTO Certamenes VALUES(7,2,1);
INSERT INTO Certamenes VALUES(9,2,1);
INSERT INTO Certamenes VALUES(17,4,1);
INSERT INTO Certamenes VALUES(19,4,1);
INSERT INTO Certamenes VALUES(1,1,2);
INSERT INTO Certamenes VALUES(2,1,2);
INSERT INTO Certamenes VALUES(3,1,2);
INSERT INTO Certamenes VALUES(4,1,2);
INSERT INTO Certamenes VALUES(5,1,2);
INSERT INTO Certamenes VALUES(6,2,2);
INSERT INTO Certamenes VALUES(7,2,2);
INSERT INTO Certamenes VALUES(8,2,2);
INSERT INTO Certamenes VALUES(9,2,2);
INSERT INTO Certamenes VALUES(10,2,2);
INSERT INTO Certamenes VALUES(21,5,3);
INSERT INTO Certamenes VALUES(22,5,3);
INSERT INTO Certamenes VALUES(23,5,3);
INSERT INTO Certamenes VALUES(24,5,3);
INSERT INTO Certamenes VALUES(25,5,3);
INSERT INTO Certamenes VALUES(26,6,3);
INSERT INTO Certamenes VALUES(27,6,3);
INSERT INTO Certamenes VALUES(28,6,3);
INSERT INTO Certamenes VALUES(29,6,3);
INSERT INTO Certamenes VALUES(30,6,3);
INSERT INTO Certamenes VALUES(1,1,4);
INSERT INTO Certamenes VALUES(2,1,4);
INSERT INTO Certamenes VALUES(3,1,4);
INSERT INTO Certamenes VALUES(4,1,4);
INSERT INTO Certamenes VALUES(5,1,4);
INSERT INTO Certamenes VALUES(6,2,4);
INSERT INTO Certamenes VALUES(7,2,4);
INSERT INTO Certamenes VALUES(8,2,4);
INSERT INTO Certamenes VALUES(9,2,4);
INSERT INTO Certamenes VALUES(10,2,4);
INSERT INTO Certamenes VALUES(11,3,4);
INSERT INTO Certamenes VALUES(12,3,4);
INSERT INTO Certamenes VALUES(13,3,4);
INSERT INTO Certamenes VALUES(14,3,4);
INSERT INTO Certamenes VALUES(15,3,4);
INSERT INTO Certamenes VALUES(16,4,4);
INSERT INTO Certamenes VALUES(17,4,4);
INSERT INTO Certamenes VALUES(18,4,4);
INSERT INTO Certamenes VALUES(19,4,4);
INSERT INTO Certamenes VALUES(20,4,4);
INSERT INTO Certamenes VALUES(21,5,4);
INSERT INTO Certamenes VALUES(22,5,4);
INSERT INTO Certamenes VALUES(23,5,4);
INSERT INTO Certamenes VALUES(24,5,4);
INSERT INTO Certamenes VALUES(25,5,4);
INSERT INTO Certamenes VALUES(26,6,4);
INSERT INTO Certamenes VALUES(27,6,4);
INSERT INTO Certamenes VALUES(28,6,4);
INSERT INTO Certamenes VALUES(29,6,4);
INSERT INTO Certamenes VALUES(30,6,4);

INSERT INTO Propuestas VALUES(1,1,1,1,'2009-12-01',34000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(2,1,1,1,'2009-12-02',35000000,'bgates','N');
INSERT INTO Propuestas VALUES(3,1,1,1,'2009-12-04',35500000,'rdeniro','S');
INSERT INTO Propuestas VALUES(4,7,2,1,'2009-12-01',60000000,'kcostner','N');
INSERT INTO Propuestas VALUES(5,7,2,1,'2009-12-06',65000000,'mjordan','S');
INSERT INTO Propuestas VALUES(6,7,2,1,'2009-12-02',63000000,'bgates','N');
INSERT INTO Propuestas VALUES(7,9,2,1,'2009-12-05',99000000,'bgates','N');
INSERT INTO Propuestas VALUES(8,17,4,1,'2009-12-19',21000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(9,19,4,1,'2009-12-20',30000000,'bgates','N');
INSERT INTO Propuestas VALUES(10,2,1,2,'2010-01-05',36000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(11,2,1,2,'2010-01-07',38000000,'bgates','N');
INSERT INTO Propuestas VALUES(12,2,1,2,'2010-02-17',40000000,'kcostner','S');
INSERT INTO Propuestas VALUES(13,3,1,2,'2010-01-17',23000000,'mjordan','N');
INSERT INTO Propuestas VALUES(14,3,1,2,'2010-02-03',24000000,'bgates','N');
INSERT INTO Propuestas VALUES(15,4,1,2,'2010-01-03',47000000,'bgates','N');
INSERT INTO Propuestas VALUES(16,8,2,2,'2010-01-05',76000000,'bgates','N');
INSERT INTO Propuestas VALUES(17,8,2,2,'2010-01-15',78000000,'bgates','N');
INSERT INTO Propuestas VALUES(18,8,2,2,'2010-01-23',83000000,'bgates','N');
INSERT INTO Propuestas VALUES(19,8,2,2,'2010-02-05',90000000,'modstrcil','S');
INSERT INTO Propuestas VALUES(20,9,2,2,'2010-02-15',99000000,'bgates','N');
INSERT INTO Propuestas VALUES(21,10,2,2,'2010-03-15',97000000,'rdeniro','N');
INSERT INTO Propuestas VALUES(22,21,5,3,'2010-01-15',1000000,'rdeniro','N');
INSERT INTO Propuestas VALUES(23,21,5,3,'2010-02-01',1200000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(24,22,5,3,'2010-02-01',2000000,'bgates','N');
INSERT INTO Propuestas VALUES(25,22,5,3,'2010-03-11',2100000,'bgates','N');
INSERT INTO Propuestas VALUES(26,23,5,3,'2010-02-21',3000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(27,30,6,3,'2010-03-11',3600000,'mjordan','N');
INSERT INTO Propuestas VALUES(28,30,6,3,'2010-03-13',3700000,'bgates','N');
INSERT INTO Propuestas VALUES(29,10,2,4,'2010-01-13',97000000,'bgates','N');
INSERT INTO Propuestas VALUES(30,10,2,4,'2010-01-22',99000000,'modstrcil','N');
INSERT INTO Propuestas VALUES(31,13,3,4,'2010-01-17',99000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(32,13,3,4,'2010-01-17',91000000,'bgates','N');
INSERT INTO Propuestas VALUES(33,16,4,4,'2010-01-02',12000000,'bgates','N');
INSERT INTO Propuestas VALUES(34,16,4,4,'2010-01-03',12500000,'lgozalez','N');
INSERT INTO Propuestas VALUES(35,16,4,4,'2010-01-04',15000000,'mjordan','N');
INSERT INTO Propuestas VALUES(36,16,4,4,'2010-01-14',17000000,'rdeniro','N');
INSERT INTO Propuestas VALUES(37,30,6,4,'2010-01-04',3500000,'rdeniro','N');
INSERT INTO Propuestas VALUES(38,30,6,4,'2010-01-04',3600000,'modstrcil','N');
INSERT INTO Propuestas VALUES(39,30,6,4,'2010-01-11',3800000,'bgates','N');
INSERT INTO Propuestas VALUES(40,30,6,4,'2010-01-24',4200000,'mjordan','N');
INSERT INTO Propuestas VALUES(41,30,6,4,'2010-02-09',5000000,'lgonzalez','S');

-- SP para BorrarCuadro
USE `Examen2020`;
DROP procedure IF EXISTS `BorrarCuadro`;

DELIMITER $$
USE `Examen2020`$$
CREATE PROCEDURE `BorrarCuadro`(pIDCuadro INTEGER, OUT pMensaje VARCHAR(255))
SALIR:BEGIN
 /* 
    Permite borrar un Cuadro, dado su ID. Controla parametros de entrada. 
    Controla que exista el cuadro a borrar. 
	Controla que no este presentado en algun certamen.
    Devuelve exito + ID o el mensaje de error en Mensaje. 
*/

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
        SELECT "Ha ocurrido un error. Contactese con el administrador." INTO pMensaje;
        ROLLBACK;
	END;
    
	-- Controlo pIDCuadro
	IF pIDCuadro IS NULL OR pIDCuadro = 0 THEN
		SELECT 'El ID del cuadro es obligatorio.' INTO pMensaje;
        LEAVE SALIR;
    END IF;

	-- Controlo que exista el cuadro
    IF NOT EXISTS(SELECT IDCuadro FROM Cuadros WHERE IDCuadro = pIDCuadro) THEN 
		SELECT 'El cuadro que quiere borrar no existe.' INTO pMensaje;
        LEAVE SALIR; 
	END IF;
    
    -- Controlo que no este presentado en algun certamen
    IF EXISTS(SELECT IDCuadro FROM Certamenes WHERE IDCuadro = pIDCuadro) THEN 
		SELECT 'El cuadro que quiere borrar esta asociado a un certamen.' INTO pMensaje;
        LEAVE SALIR; 
	END IF;
    
    -- Borrado
START TRANSACTION;
    DELETE FROM Cuadros WHERE IDCuadro = pIDCuadro;
    SELECT CONCAT('Se borro con exito el cuadro de ID: ',pIDCuadro) INTO pMensaje;
COMMIT;
END$$

DELIMITER ;
;

-- Insertamos un cuadro nuevo para poder hacer el borrado correctamente.
INSERT INTO Cuadros VALUES(31,6,3,'El borrador','2021-06-22',123.45);

-- Probamos SP BorrarCuadro
SET @pMensaje = '';

CALL BorrarCuadro(NULL, @pMensaje); -- El ID del cuadro es obligatorio.
SELECT @pMensaje;
CALL BorrarCuadro(99, @pMensaje); -- El cuadro que quiere borrar no existe.
SELECT @pMensaje;
CALL BorrarCuadro(1, @pMensaje); -- El cuadro que quiere borrar esta asociado a un certamen.
SELECT @pMensaje;
CALL BorrarCuadro(31, @pMensaje); -- Se borro con exito el cuadro de ID 31.
SELECT @pMensaje;

-- Probamos Auditoria
SELECT * FROM Auditoria;

-- Creamos vista VentaCuadros
DROP VIEW IF EXISTS VentasCuadros;
CREATE VIEW VentasCuadros AS 
SELECT 		cua.IDCuadro, cua.Titulo AS Cuadro, met.Metodo, pin.IDPintor, 
			CONCAT(pin.Apellidos, ', ', pin.Nombres) AS Pintor, exh.IDExhibicion,
			exh.Titulo AS Exhibicion, pro.Fecha, pro.Persona, pro.Importe
FROM		Propuestas pro 
INNER JOIN 	Certamenes cer 
ON 			pro.IDCuadro = cer.IDCuadro AND pro.IDPintor = cer.IDPintor AND pro.IDExhibicion = cer.IDExhibicion
INNER JOIN	Exhibiciones exh
ON			cer.IDExhibicion = exh.IDExhibicion
INNER JOIN 	Pintores pin 
ON 			cer.IDPintor = pin.IDPintor
INNER JOIN 	Cuadros cua 
ON 			cer.IDCuadro = cua.IDCuadro AND cer.IDPintor = cua.IDPintor
INNER JOIN 	Metodos met 
ON 			cua.IDMetodo = met.IDMetodo
WHERE 		pro.Vendido = 'S'
ORDER BY	pro.Importe DESC;

-- Probamos vista VentaCuadros
SELECT * FROM VentaCuadros;

-- SP EstadoCuadros
USE `Examen2020`;
DROP procedure IF EXISTS `EstadoCuadros`;

DELIMITER $$
USE `Examen2020`$$
CREATE PROCEDURE `EstadoCuadros`(pIDPintor INTEGER, OUT pMensaje VARCHAR(255))
SALIR:BEGIN
	/*
		dado un pintor, muestre todos sus cuadros junto con su precio, la mejor propuesta recibida, si
		fue vendido o no y la ganancia (diferencia entre el importe que se pagó por el cuadro
		y el precio del mismo). Se deberán mostrar todos los cuadros, incluso aquellos que
		no tienen propuestas (la mejor propuesta será 0). El formato deberá ser: IDCuadro,
		Título, Precio, Mejor propuesta, Fue vendido [S|N], Ganancia. 
    */
	
    -- Controlo pIDPintor
	IF pIDPintor IS NULL OR pIDPintor = 0 THEN
		SELECT 'El ID del pintor es obligatorio.' INTO pMensaje;
        LEAVE SALIR;
    END IF;

	-- Controlo que exista el pintor
    IF NOT EXISTS(SELECT IDPintor FROM Pintores WHERE IDPintor = pIDPintor) THEN 
		SELECT 'El pintor que quiere buscar no existe.' INTO pMensaje;
        LEAVE SALIR; 
	END IF;

SELECT 		cua.IDCuadro, cua.Titulo AS Cuadro, cua.Precio, MAX(IFNULL(pro.Importe,0)) AS Propuesta, 
			MAX(IFNULL(pro.Vendido,'N')) AS Vendido, MAX(IFNULL(Importe - Precio,0)) AS Ganancia
FROM		Cuadros cua 
LEFT JOIN	Pintores pin
ON 			cua.IDPintor = pin.IDPintor
INNER JOIN 	Certamenes cer
ON			cua.IDCuadro = cer.IDCuadro AND cua.IDPintor = cer.IDPintor
LEFT JOIN 	Propuestas pro 
ON			cer.IDCuadro = pro.IDCuadro AND cer.IDPintor = pro.IDPintor AND cer.IDExhibicion = pro.IDExhibicion
WHERE		pin.IDPintor = pIDPintor
GROUP BY 	cua.IDCuadro, cua.Titulo, cua.Precio
ORDER BY 	cua.Titulo, Propuesta, Ganancia;

END$$

DELIMITER ;
;

-- Probamos SP EstadoCuadros
SET @pMensaje = '';

CALL EstadoCuadros(NULL, @pMensaje); -- ID del pintor obligatorio.
SELECT @pMensaje;
CALL EstadoCuadros(99, @pMensaje); -- El pintor no existe.
SELECT @pMensaje;
CALL EstadoCuadros(4, @pMensaje); -- Muestra informacion.
