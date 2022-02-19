DROP DATABASE IF EXISTS Parcial2015;
CREATE DATABASE Parcial2015;
USE Parcial2015;

-- BD
--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      jf
-- Project :      Model2.DM1
-- Author :       jf
--
-- Date Created : Wednesday, June 23, 2021 22:48:49
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Edificios 
--

CREATE TABLE Edificios(
    IdEdificio    INT            NOT NULL,
    Nombre        VARCHAR(20)    NOT NULL,
    Domicilio     VARCHAR(50)    NOT NULL,
    Superficie    INT            NOT NULL,
    PRIMARY KEY (IdEdificio)
)ENGINE=INNODB
;



-- 
-- TABLE: Propietarios 
--

CREATE TABLE Propietarios(
    IdPropietario    INT            NOT NULL,
    Apellidos        VARCHAR(30)    NOT NULL,
    Nombres          VARCHAR(20)    NOT NULL,
    Domicilio        VARCHAR(50)    NOT NULL,
    Telefono         VARCHAR(15),
    Correo           VARCHAR(50),
    PRIMARY KEY (IdPropietario)
)ENGINE=INNODB
;



-- 
-- TABLE: Unidades 
--

CREATE TABLE Unidades(
    IdEdificio       INT            NOT NULL,
    Piso             CHAR(2)        NOT NULL,
    Numero           CHAR(2)        NOT NULL,
    Tipo             VARCHAR(15)    NOT NULL,
    Superficie       INT            NOT NULL,
    IdPropietario    INT            NOT NULL,
    PRIMARY KEY (IdEdificio, Piso, Numero), 
    INDEX Ref65(IdPropietario),
    INDEX Ref36(IdEdificio), 
    CONSTRAINT RefPropietarios5 FOREIGN KEY (IdPropietario)
    REFERENCES Propietarios(IdPropietario),
    CONSTRAINT RefEdificios6 FOREIGN KEY (IdEdificio)
    REFERENCES Edificios(IdEdificio)
)ENGINE=INNODB
;



-- 
-- TABLE: Expensas 
--

CREATE TABLE Expensas(
    IdEdificio     INT               NOT NULL,
    Piso           CHAR(2)           NOT NULL,
    Numero         CHAR(2)           NOT NULL,
    Periodo        DATE              NOT NULL,
    Importe        DECIMAL(10, 2)    NOT NULL,
    Vencimiento    DATE              NOT NULL,
    PRIMARY KEY (IdEdificio, Piso, Numero, Periodo), 
    INDEX Ref47(Piso, Numero, IdEdificio), 
    CONSTRAINT RefUnidades7 FOREIGN KEY (IdEdificio, Piso, Numero)
    REFERENCES Unidades(IdEdificio, Piso, Numero)
)ENGINE=INNODB
;



-- 
-- TABLE: Rubros 
--

CREATE TABLE Rubros(
    IdRubro    INT            NOT NULL,
    Nombre     VARCHAR(20)    NOT NULL,
    PRIMARY KEY (IdRubro)
)ENGINE=INNODB
;



-- 
-- TABLE: Gastos 
--

CREATE TABLE Gastos(
    IdGasto       INT               NOT NULL,
    Fecha         DATE              NOT NULL,
    Importe       DECIMAL(10, 2)    NOT NULL,
    IdEdificio    INT               NOT NULL,
    IdRubro       INT               NOT NULL,
    PRIMARY KEY (IdGasto), 
    INDEX Ref33(IdEdificio),
    INDEX Ref14(IdRubro), 
    CONSTRAINT RefEdificios3 FOREIGN KEY (IdEdificio)
    REFERENCES Edificios(IdEdificio),
    CONSTRAINT RefRubros4 FOREIGN KEY (IdRubro)
    REFERENCES Rubros(IdRubro)
)ENGINE=INNODB
;



-- Inserciones 

INSERT INTO Rubros VALUES (1, 'Varios');
INSERT INTO Rubros VALUES (2, 'Electricidad');
INSERT INTO Rubros VALUES (3, 'Mantenimiento');
INSERT INTO Rubros VALUES (4, 'Sueldo portero');
INSERT INTO Rubros VALUES (5, 'Limpieza');
INSERT INTO Rubros VALUES (6, 'Otros');

INSERT INTO Propietarios VALUES (1, 'Flores', 'David', 'San Juan 932', '4200555', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (3, 'Gonzalez', 'Martin', '25 de Mayo 49', '000-000000000  ', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (6, 'Gomez', 'Gabriel', 'Gral. Paz 1456', '000-000000000', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (7, 'Perez', 'Horacio A.', 'Mitre 340', '000-000000000', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (8, 'Hamster', 'Marcelo', 'S/N', '000-000000000', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (9, 'Serra', 'Nicolas', 'Moreno 910', '000-000000000', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (10, 'Pichot', 'Agustin', '54 y 20', '000-000000000', 'sinemail@sinemail.com');
INSERT INTO Propietarios VALUES (11, 'Hernandez', 'Juani', 'bulk insert 345', '000-000000000', 'sinemail@sinemail.com');

INSERT INTO Edificios VALUES (1, 'Torre Muñecas', 'Muñecas 765', 850);
INSERT INTO Edificios VALUES (2, 'Edificio2', 'San Martin 2453', 1);
INSERT INTO Edificios VALUES (3, 'Edificio 3', 'Aconquija 234', 923);
INSERT INTO Edificios VALUES (4, 'Edificio 4', 'Larrea 879', 760);
INSERT INTO Edificios VALUES (5, 'Edificio 5', 'Magallanes 987', 785);
INSERT INTO Edificios VALUES (6, 'edificio20', 'domicilio 1', 120);

INSERT INTO Gastos VALUES (1, '2009-08-12 00:00:00.000', 17.5, 1, 1);
INSERT INTO Gastos VALUES (2, '2009-08-13 00:00:00.000', 53.5, 1, 3);
INSERT INTO Gastos VALUES (3, '2009-07-11 00:00:00.000', 1200, 1, 4);
INSERT INTO Gastos VALUES (4, '2009-08-11 00:00:00.000', 43, 1, 2);
INSERT INTO Gastos VALUES (5, '2009-07-05 00:00:00.000', 65.25, 1, 1);
INSERT INTO Gastos VALUES (6, '2009-07-28 00:00:00.000', 31.75, 1, 3);
INSERT INTO Gastos VALUES (7, '2009-07-17 00:00:00.000', 1150, 2, 4);
INSERT INTO Gastos VALUES (8, '2009-07-05 00:00:00.000', 54, 2, 1);
INSERT INTO Gastos VALUES (9, '2009-07-08 00:00:00.000', 129.5, 2, 3);
INSERT INTO Gastos VALUES (12292, '2009-08-13 00:00:00.000', 34.5, 2, 1);
INSERT INTO Gastos VALUES (12293, '2009-08-14 00:00:00.000', 70.5, 2, 3);
INSERT INTO Gastos VALUES (12294, '2009-07-12 00:00:00.000', 1217, 2, 4);
INSERT INTO Gastos VALUES (12295, '2009-08-12 00:00:00.000', 60, 2, 2);
INSERT INTO Gastos VALUES (12296, '2009-07-06 00:00:00.000', 82.25, 2, 1);
INSERT INTO Gastos VALUES (12297, '2009-07-29 00:00:00.000', 48.75, 2, 3);
INSERT INTO Gastos VALUES (12298, '2009-08-13 00:00:00.000', 34.5, 2, 1);
INSERT INTO Gastos VALUES (12299, '2009-08-14 00:00:00.000', 70.5, 2, 3);
INSERT INTO Gastos VALUES (12300, '2009-07-12 00:00:00.000', 1217, 2, 4);
INSERT INTO Gastos VALUES (12301, '2009-08-12 00:00:00.000', 60, 2, 2);
INSERT INTO Gastos VALUES (12302, '2009-07-06 00:00:00.000', 82.25, 2, 1);
INSERT INTO Gastos VALUES (12303, '2009-07-29 00:00:00.000', 48.75, 2, 3);
INSERT INTO Gastos VALUES (12304, '2009-07-18 00:00:00.000', 1167, 3, 4);
INSERT INTO Gastos VALUES (12305, '2009-07-06 00:00:00.000', 71, 3, 1);
INSERT INTO Gastos VALUES (12306, '2009-07-09 00:00:00.000', 146.5, 3, 3);
INSERT INTO Gastos VALUES (12307, '2009-08-14 00:00:00.000', 51.5, 3, 1);
INSERT INTO Gastos VALUES (12308, '2009-08-15 00:00:00.000', 87.5, 3, 3);
INSERT INTO Gastos VALUES (12309, '2009-07-13 00:00:00.000', 1234, 3, 4);
INSERT INTO Gastos VALUES (12310, '2009-08-13 00:00:00.000', 77, 3, 2);
INSERT INTO Gastos VALUES (12311, '2009-07-07 00:00:00.000', 99.25, 3, 1);
INSERT INTO Gastos VALUES (12312, '2009-07-30 00:00:00.000', 65.75, 3, 3);
INSERT INTO Gastos VALUES (12313, '2009-08-14 00:00:00.000', 51.5, 3, 1);
INSERT INTO Gastos VALUES (12314, '2009-08-15 00:00:00.000', 87.5, 3, 3);
INSERT INTO Gastos VALUES (12315, '2009-07-13 00:00:00.000', 1234, 3, 4);
INSERT INTO Gastos VALUES (12316, '2009-08-13 00:00:00.000', 77, 3, 2);
INSERT INTO Gastos VALUES (12317, '2009-07-07 00:00:00.000', 99.25, 3, 1);
INSERT INTO Gastos VALUES (12318, '2009-07-30 00:00:00.000', 65.75, 3, 3);
INSERT INTO Gastos VALUES (12319, '2009-07-19 00:00:00.000', 1184, 4, 4);
INSERT INTO Gastos VALUES (12320, '2009-07-07 00:00:00.000', 88, 4, 1);
INSERT INTO Gastos VALUES (12321, '2009-07-10 00:00:00.000', 163.5, 4, 3);
INSERT INTO Gastos VALUES (12322, '2009-08-15 00:00:00.000', 68.5, 4, 1);
INSERT INTO Gastos VALUES (12323, '2009-08-16 00:00:00.000', 104.5, 4, 3);
INSERT INTO Gastos VALUES (12324, '2009-07-14 00:00:00.000', 1251, 4, 4);
INSERT INTO Gastos VALUES (12325, '2009-08-14 00:00:00.000', 94, 4, 2);
INSERT INTO Gastos VALUES (12326, '2009-07-08 00:00:00.000', 116.25, 4, 1);
INSERT INTO Gastos VALUES (12327, '2009-07-31 00:00:00.000', 82.75, 4, 3);
INSERT INTO Gastos VALUES (12328, '2009-08-15 00:00:00.000', 68.5, 4, 1);
INSERT INTO Gastos VALUES (12329, '2009-08-16 00:00:00.000', 104.5, 4, 3);
INSERT INTO Gastos VALUES (12330, '2009-07-14 00:00:00.000', 1251, 4, 4);
INSERT INTO Gastos VALUES (12331, '2009-08-14 00:00:00.000', 94, 4, 2);
INSERT INTO Gastos VALUES (12332, '2009-07-08 00:00:00.000', 116.25, 4, 1);
INSERT INTO Gastos VALUES (12333, '2009-07-31 00:00:00.000', 82.75, 4, 3);
INSERT INTO Gastos VALUES (12334, '2009-07-20 00:00:00.000', 1201, 5, 4);
INSERT INTO Gastos VALUES (12335, '2009-07-08 00:00:00.000', 105, 5, 1);
INSERT INTO Gastos VALUES (12336, '2009-07-11 00:00:00.000', 180.5, 5, 3);
INSERT INTO Gastos VALUES (12337, '2009-08-16 00:00:00.000', 85.5, 5, 1);
INSERT INTO Gastos VALUES (12338, '2009-08-17 00:00:00.000', 121.5, 5, 3);
INSERT INTO Gastos VALUES (12339, '2009-07-15 00:00:00.000', 1268, 5, 4);
INSERT INTO Gastos VALUES (12340, '2009-08-15 00:00:00.000', 111, 5, 2);
INSERT INTO Gastos VALUES (12341, '2009-07-09 00:00:00.000', 133.25, 5, 1);
INSERT INTO Gastos VALUES (12342, '2009-08-01 00:00:00.000', 99.75, 5, 3);
INSERT INTO Gastos VALUES (12343, '2009-08-16 00:00:00.000', 85.5, 5, 1);
INSERT INTO Gastos VALUES (12344, '2009-08-17 00:00:00.000', 121.5, 5, 3);
INSERT INTO Gastos VALUES (12345, '2009-07-15 00:00:00.000', 1268, 5, 4);
INSERT INTO Gastos VALUES (12346, '2009-08-15 00:00:00.000', 111, 5, 2);
INSERT INTO Gastos VALUES (12347, '2009-07-09 00:00:00.000', 133.25, 5, 1);
INSERT INTO Gastos VALUES (12348, '2009-08-01 00:00:00.000', 99.75, 5, 3);

INSERT INTO Unidades VALUES (1, '0', '1', 'Departamento', 1, 1);
INSERT INTO Unidades VALUES (1, '0', '2', 'Departamento', 1, 3);
INSERT INTO Unidades VALUES (1, '1', '1', 'Departamento', 1, 1);
INSERT INTO Unidades VALUES (1, '1', '2', 'Departamento', 1, 6);
INSERT INTO Unidades VALUES (1, '1', '3', 'Departamento', 1, 7);
INSERT INTO Unidades VALUES (1, '1', '40', 'Cochera', 1, 1);
INSERT INTO Unidades VALUES (1, '2', '1', 'Departamento', 1, 1);
INSERT INTO Unidades VALUES (2, '0', '1', 'Departamento', 1, 8);
INSERT INTO Unidades VALUES (2, '0', '2', 'Departamento', 1, 9);
INSERT INTO Unidades VALUES (2, '1', '1', 'Departamento', 1, 10);
INSERT INTO Unidades VALUES (2, '1', '2', 'Departamento', 1, 10);
INSERT INTO Unidades VALUES (2, '1', '3', 'Departamento', 1, 11);

INSERT INTO Expensas VALUES (1, '0', '1', '2009-05-01 00:00:00.000', 251, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '1', '2009-06-01 00:00:00.000', 251, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '1', '2009-07-01 00:00:00.000', 251, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '1', '2009-08-01 00:00:00.000', 251, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '2', '2009-05-01 00:00:00.000', 160, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '2', '2009-06-01 00:00:00.000', 160, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '2', '2009-07-01 00:00:00.000', 160, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '0', '2', '2009-08-01 00:00:00.000', 160, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '1', '2009-05-01 00:00:00.000', 220, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '1', '2009-06-01 00:00:00.000', 220, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '1', '2009-07-01 00:00:00.000', 220, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '1', '2009-08-01 00:00:00.000', 220, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '2', '2009-05-01 00:00:00.000', 160, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '2', '2009-06-01 00:00:00.000', 160, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '2', '2009-07-01 00:00:00.000', 160, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '2', '2009-08-01 00:00:00.000', 160, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '3', '2009-05-01 00:00:00.000', 200, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '3', '2009-06-01 00:00:00.000', 200, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '3', '2009-07-01 00:00:00.000', 200, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (1, '1', '3', '2009-08-01 00:00:00.000', 200, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '1', '2009-05-01 00:00:00.000', 216, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '1', '2009-06-01 00:00:00.000', 216, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '1', '2009-07-01 00:00:00.000', 216, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '1', '2009-08-01 00:00:00.000', 216, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '2', '2009-05-01 00:00:00.000', 125, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '2', '2009-06-01 00:00:00.000', 125, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '2', '2009-07-01 00:00:00.000', 125, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '0', '2', '2009-08-01 00:00:00.000', 125, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '1', '2009-05-01 00:00:00.000', 185, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '1', '2009-06-01 00:00:00.000', 185, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '1', '2009-07-01 00:00:00.000', 185, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '1', '2009-08-01 00:00:00.000', 185, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '2', '2009-05-01 00:00:00.000', 125, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '2', '2009-06-01 00:00:00.000', 125, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '2', '2009-07-01 00:00:00.000', 125, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '2', '2009-08-01 00:00:00.000', 125, '2009-09-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '3', '2009-05-01 00:00:00.000', 165, '2009-06-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '3', '2009-06-01 00:00:00.000', 165, '2009-07-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '3', '2009-07-01 00:00:00.000', 165, '2009-08-12 00:00:00.000');
INSERT INTO Expensas VALUES (2, '1', '3', '2009-08-01 00:00:00.000', 165, '2009-09-12 00:00:00.000');

-- resuelvo sp_movimientos
CREATE DEFINER=`juan`@`localhost` PROCEDURE `sp_movimientos`(pFechaInicio INT, pFechaFin INT, OUT pMensaje VARCHAR(255))
SALIR:BEGIN
DECLARE pAux INT;

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

DROP TEMPORARY TABLE IF EXISTS Balance;
CREATE TEMPORARY TABLE Balance(
    `Mes` VARCHAR(10) NOT NULL,
    `Gastos` DECIMAL(10,2) NOT NULL DEFAULT 0,
    `Expensas` DECIMAL (10,2) NOT NULL DEFAULT 0)
ENGINE = InnoDB;

INSERT INTO Balance(Mes,Expensas)
SELECT CASE Month(Periodo) 
	WHEN 1 THEN 'Enero'
	WHEN 2 THEN  'Febrero'
	WHEN 3 THEN 'Marzo' 
	WHEN 4 THEN 'Abril' 
	WHEN 5 THEN 'Mayo'
	WHEN 6 THEN 'Junio'
	WHEN 7 THEN 'Julio'
	WHEN 8 THEN 'Agosto'
	WHEN 9 THEN 'Septiembre'
	WHEN 10 THEN 'Octubre'
	WHEN 11 THEN 'Noviembre'
	WHEN 12 THEN 'Diciembre'
 END Mes, SUM(Importe) FROM Expensas
WHERE  Month(Periodo) BETWEEN pFechaInicio AND pFechaFin
GROUP BY Mes, Month(Periodo);

INSERT INTO Balance(Mes,Gastos) 
SELECT CASE Month(Fecha)
	WHEN 1 THEN 'Enero'
	WHEN 2 THEN  'Febrero'
	WHEN 3 THEN 'Marzo' 
	WHEN 4 THEN 'Abril' 
	WHEN 5 THEN 'Mayo'
	WHEN 6 THEN 'Junio'
	WHEN 7 THEN 'Julio'
	WHEN 8 THEN 'Agosto'
	WHEN 9 THEN 'Septiembre'
	WHEN 10 THEN 'Octubre'
	WHEN 11 THEN 'Noviembre'
	WHEN 12 THEN 'Diciembre'
 END Mes, SUM(Importe) FROM Gastos
WHERE  Month(Fecha) BETWEEN pFechaInicio AND pFechaFin
GROUP BY Mes, Month(Fecha);

SELECT Mes, SUM(Gastos) AS Gastos, SUM(Expensas) AS Expensas FROM Balance
GROUP BY Mes;

DROP TEMPORARY TABLE IF EXISTS Balance;
END

-- Probar...

-- vista_unidades
DROP VIEW IF EXISTS vista_unidades;
CREATE VIEW vista_unidades AS
SELECT 		edi.Nombre, edi.Domicilio 'Domicilio edificio', edi.Superficie 'Superficie Edificio', 
			uni.Piso, uni.Numero, uni.Tipo, uni.Superficie 'Superficie Unidad',
            pro.Apellidos, pro.Nombres, pro.Domicilio 'Domicilio Propietario'
FROM		Unidades uni 
RIGHT JOIN 	Edificios edi ON uni.IdEdificio = edi.IdEdificio
LEFT JOIN	Propietarios pro ON uni.IdPropietario = pro.IdPropietario
ORDER BY	edi.Nombre, uni.Piso, uni.Numero;

SELECT * FROM vista_unidades;

