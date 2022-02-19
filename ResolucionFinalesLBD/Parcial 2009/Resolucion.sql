DROP DATABASE IF EXISTS Parcial2009;
CREATE DATABASE Parcial2009;
USE  Parcial2009;

-- BD
--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      jf
-- Project :      Model2.DM1
-- Author :       jf
--
-- Date Created : Thursday, June 24, 2021 12:22:36
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Cargos 
--

CREATE TABLE Cargos(
    IdCargo    INT            NOT NULL,
    Cargo      VARCHAR(50)    NOT NULL,
    PRIMARY KEY (IdCargo)
)ENGINE=INNODB
;



-- 
-- TABLE: Empleados 
--

CREATE TABLE Empleados(
    IdEmpleado    INT            NOT NULL,
    IdCargo       INT            NOT NULL,
    IdJefe        INT,
    Apellidos     VARCHAR(50)    NOT NULL,
    Nombres       VARCHAR(50),
    Direccion     VARCHAR(75)    NOT NULL,
    Telefono      CHAR(7)        NOT NULL,
    PRIMARY KEY (IdEmpleado), 
    INDEX Ref36(IdCargo),
    INDEX Ref47(IdJefe), 
    CONSTRAINT RefCargos6 FOREIGN KEY (IdCargo)
    REFERENCES Cargos(IdCargo),
    CONSTRAINT RefEmpleados7 FOREIGN KEY (IdJefe)
    REFERENCES Empleados(IdEmpleado)
)ENGINE=INNODB
;



-- 
-- TABLE: Obras 
--

CREATE TABLE Obras(
    IdObra           INT            NOT NULL,
    NombreObra       VARCHAR(75)    NOT NULL,
    DireccionObra    VARCHAR(75)    NOT NULL,
    TotalHoras       INT            NOT NULL,
    PRIMARY KEY (IdObra)
)ENGINE=INNODB
;



-- 
-- TABLE: Trabajos 
--

CREATE TABLE Trabajos(
    IdObra         INT             NOT NULL,
    IdTrabajo      INT             NOT NULL,
    Descripcion    VARCHAR(100)    NOT NULL,
    Horas          INT,
    Estado         CHAR(1)         NOT NULL,
    PRIMARY KEY (IdObra, IdTrabajo), 
    INDEX Ref11(IdObra), 
    CONSTRAINT RefObras1 FOREIGN KEY (IdObra)
    REFERENCES Obras(IdObra)
)ENGINE=INNODB
;



-- 
-- TABLE: TrabajaEn 
--

CREATE TABLE TrabajaEn(
    IdObra             INT    NOT NULL,
    IdTrabajo          INT    NOT NULL,
    IdEmpleado         INT    NOT NULL,
    HorasTrabajadas    INT    NOT NULL,
    PRIMARY KEY (IdObra, IdTrabajo, IdEmpleado), 
    INDEX Ref22(IdTrabajo, IdObra),
    INDEX Ref43(IdEmpleado), 
    CONSTRAINT RefTrabajos2 FOREIGN KEY (IdObra, IdTrabajo)
    REFERENCES Trabajos(IdObra, IdTrabajo),
    CONSTRAINT RefEmpleados3 FOREIGN KEY (IdEmpleado)
    REFERENCES Empleados(IdEmpleado)
)ENGINE=INNODB
;





-- Inserciones
-- Tabla Obras
INSERT INTO Obras VALUES (1,'Casa Perez', 'Viamonte 777',1890);
INSERT INTO Obras VALUES (2,'Hospital Oeste', 'México 2477',4236);
INSERT INTO Obras VALUES (3,'Casa Suarez', 'San Luís 3677',2389);
INSERT INTO Obras VALUES (4,'Edificio Norte I', '25 de Mayo 3445',5789);
INSERT INTO Obras VALUES (5,'Estadio Centenario', 'Las Heras 7899',3866);

-- Tabla Cargos
INSERT INTO Cargos VALUES (1,'Capataz');
INSERT INTO Cargos VALUES (2,'Albañil 1ra');
INSERT INTO Cargos VALUES (3,'Albañil 2da');
INSERT INTO Cargos VALUES (4,'Maestro Mayor');
INSERT INTO Cargos VALUES (5,'Electricista 1ra');
INSERT INTO Cargos VALUES (6,'Electricista 2da');
INSERT INTO Cargos VALUES (7,'Plomero 1ra');
INSERT INTO Cargos VALUES (8,'Plomero 2da');
INSERT INTO Cargos VALUES (9,'Gasista 1ra');
INSERT INTO Cargos VALUES (10,'Gasista 2da');
INSERT INTO Cargos VALUES (11,'Pintor 1ra');
INSERT INTO Cargos VALUES (12,'Pintor 2da');
INSERT INTO Cargos VALUES (13,'Yesero 1ra');
INSERT INTO Cargos VALUES (14,'Yesero 2da');


-- Empleados
INSERT INTO Empleados VALUES (1,4,NULL,'Perez','Antonio','Chacabuco 4567','4251155');
INSERT INTO Empleados VALUES (2,1,1,'Juarez','Leandro','Jujuy 6777','4903556');
INSERT INTO Empleados VALUES (3,2,2,'Gomez','Sergio','Maipú 4444','4123456');
INSERT INTO Empleados VALUES (4,3,3,'Antunez','Juan','Las Piedras 15676','4098765');
INSERT INTO Empleados VALUES (5,2,2,'Hernandez','Martín','Las Heras 8888','4888888');
INSERT INTO Empleados VALUES (6,3,5,'Lopez','Manuel','General Paz 5555','4111111');
INSERT INTO Empleados VALUES (7,5,1,'Diaz','Nestor','San Lorenzo 6667','4456789');
INSERT INTO Empleados VALUES (8,6,7,'Nieva','Felipe','Muñecas 3456','4952302');
INSERT INTO Empleados VALUES (9,7,1,'Aguirre','Ernesto','Alvarez 5656','4998877');
INSERT INTO Empleados VALUES (10,8,9,'Araoz','Fabian','Lamadrid 9367','4754378');
INSERT INTO Empleados VALUES (11,9,1,'Longo','Javier','Alem 9981','4646323');
INSERT INTO Empleados VALUES (12,10,11,'Ortega','Pascual','Lilas 3456','4698742');
INSERT INTO Empleados VALUES (13,11,1,'Gimenez','Raúl','Acasuso 6654','4347689');
INSERT INTO Empleados VALUES (14,12,13,'Gamez','Pedro','Cortez 4444','4178025');
INSERT INTO Empleados VALUES (15,13,1,'Miranda','Saúl','Rondeau 15999','4117794');
INSERT INTO Empleados VALUES (16,14,15,'Sanchez','Ignacio','Pellegrini 14911','4670989');

-- Trabajos
INSERT INTO Trabajos VALUES (1,1,'Cimientos Casa Perez',290,'A');
INSERT INTO Trabajos VALUES (2,2,'Cimientos Hospital Oeste',736,'A');
INSERT INTO Trabajos VALUES (3,3,'Cimientos Casa Suarez',300,'A');
INSERT INTO Trabajos VALUES (4,4,'Cimientos Edificio Norte I',1289,'A');
INSERT INTO Trabajos VALUES (5,5,'Cimientos Estadio Centenario',866,'A');
INSERT INTO Trabajos VALUES (1,6,'Paredes Casa Perez',400,'A');
INSERT INTO Trabajos VALUES (2,7,'Paredes Hospital Oeste',1200,'A');
INSERT INTO Trabajos VALUES (3,8,'Paredes Casa Suarez',600,'A');
INSERT INTO Trabajos VALUES (4,9,'Paredes Edificio Norte I',1200,'A');
INSERT INTO Trabajos VALUES (5,10,'Paredes Estadio Centenario',900,'A');
INSERT INTO Trabajos VALUES (1,11,'Techo Casa Perez',400,'A');
INSERT INTO Trabajos VALUES (2,12,'Techo Hospital Oeste',900,'A');
INSERT INTO Trabajos VALUES (3,13,'Techo Casa Suarez',600,'A');
INSERT INTO Trabajos VALUES (4,14,'Techo Edificio Norte I',900,'A');
INSERT INTO Trabajos VALUES (5,15,'Techo Estadio Centenario',600,'A');
INSERT INTO Trabajos VALUES (1,16,'Electricidad Casa Perez',200,'A');
INSERT INTO Trabajos VALUES (2,17,'Electricidad Hospital Oeste',400,'A');
INSERT INTO Trabajos VALUES (3,18,'Electricidad Casa Suarez',389,'A');
INSERT INTO Trabajos VALUES (4,19,'Electricidad Edificio Norte I',700,'A');
INSERT INTO Trabajos VALUES (5,20,'Electricidad Estadio Centenario',800,'A');
INSERT INTO Trabajos VALUES (1,21,'Plomería Casa Perez',300,'A');
INSERT INTO Trabajos VALUES (2,22,'Plomería Hospital Oeste',500,'A');
INSERT INTO Trabajos VALUES (3,23,'Plomería Casa Suarez',300,'A');
INSERT INTO Trabajos VALUES (4,24,'Plomería Edificio Norte I',800,'A');
INSERT INTO Trabajos VALUES (5,25,'Plomería Estadio Centenario',400,'A');
INSERT INTO Trabajos VALUES (1,26,'Pintura Casa Perez',300,'A');
INSERT INTO Trabajos VALUES (2,27,'Pintura Hospital Oeste',500,'A');
INSERT INTO Trabajos VALUES (3,28,'Pintura Casa Suarez',200,'A');
INSERT INTO Trabajos VALUES (4,29,'Pintura Edificio Norte I',900,'A');
INSERT INTO Trabajos VALUES (5,30,'Pintura Estadio Centenario',300,'A');
INSERT INTO Trabajos VALUES (1,31,'Dirección Casa Perez',0,'A');
INSERT INTO Trabajos VALUES (2,32,'Dirección Hospital Oeste',0,'A');
INSERT INTO Trabajos VALUES (3,33,'Dirección Casa Suarez',0,'A');
INSERT INTO Trabajos VALUES (4,34,'Dirección Edificio Norte I',0,'A');
INSERT INTO Trabajos VALUES (5,35,'Dirección Estadio Centenario',0,'A');

-- TrabajaEn
INSERT INTO TrabajaEn VALUES (1,1,4,300);
INSERT INTO TrabajaEn VALUES (2,2,4,700);
INSERT INTO TrabajaEn VALUES (3,3,4,320);
INSERT INTO TrabajaEn VALUES (4,4,4,800);
INSERT INTO TrabajaEn VALUES (4,4,3,500);
INSERT INTO TrabajaEn VALUES (5,5,4,400);
INSERT INTO TrabajaEn VALUES (5,5,6,400);
INSERT INTO TrabajaEn VALUES (1,6,4,100);
INSERT INTO TrabajaEn VALUES (2,7,4,300);
INSERT INTO TrabajaEn VALUES (3,8,4,150);
INSERT INTO TrabajaEn VALUES (4,9,4,300);
INSERT INTO TrabajaEn VALUES (5,10,4,250);
INSERT INTO TrabajaEn VALUES (1,6,6,100);
INSERT INTO TrabajaEn VALUES (2,7,6,300);
INSERT INTO TrabajaEn VALUES (3,8,6,150);
INSERT INTO TrabajaEn VALUES (4,9,6,300);
INSERT INTO TrabajaEn VALUES (5,10,6,250);
INSERT INTO TrabajaEn VALUES (1,6,3,100);
INSERT INTO TrabajaEn VALUES (2,7,3,300);
INSERT INTO TrabajaEn VALUES (3,8,3,150);
INSERT INTO TrabajaEn VALUES (4,9,3,300);
INSERT INTO TrabajaEn VALUES (5,10,3,250);
INSERT INTO TrabajaEn VALUES (1,6,5,100);
INSERT INTO TrabajaEn VALUES (2,7,5,300);
INSERT INTO TrabajaEn VALUES (3,8,5,150);
INSERT INTO TrabajaEn VALUES (4,9,5,300);
INSERT INTO TrabajaEn VALUES (5,10,5,250);
INSERT INTO TrabajaEn VALUES (1,11,3,450);
INSERT INTO TrabajaEn VALUES (2,12,4,850);
INSERT INTO TrabajaEn VALUES (3,13,3,700);
INSERT INTO TrabajaEn VALUES (4,14,3,450);
INSERT INTO TrabajaEn VALUES (4,14,4,500);
INSERT INTO TrabajaEn VALUES (5,15,3,550);
INSERT INTO TrabajaEn VALUES (1,16,8,210);
INSERT INTO TrabajaEn VALUES (2,17,7,420);
INSERT INTO TrabajaEn VALUES (3,18,8,400);
INSERT INTO TrabajaEn VALUES (4,19,7,710);
INSERT INTO TrabajaEn VALUES (5,20,8,400);
INSERT INTO TrabajaEn VALUES (5,20,7,500);
INSERT INTO TrabajaEn VALUES (1,21,10,300);
INSERT INTO TrabajaEn VALUES (2,22,9,550);
INSERT INTO TrabajaEn VALUES (3,23,10,345);
INSERT INTO TrabajaEn VALUES (4,24,9,310);
INSERT INTO TrabajaEn VALUES (4,24,10,510);
INSERT INTO TrabajaEn VALUES (5,25,10,465);
INSERT INTO TrabajaEn VALUES (1,26,14,350);
INSERT INTO TrabajaEn VALUES (2,27,13,510);
INSERT INTO TrabajaEn VALUES (3,28,14,230);
INSERT INTO TrabajaEn VALUES (4,29,13,800);
INSERT INTO TrabajaEn VALUES (4,29,14,200);
INSERT INTO TrabajaEn VALUES (5,30,14,340);
INSERT INTO TrabajaEn VALUES (1,31,1,0);
INSERT INTO TrabajaEn VALUES (2,32,1,0);
INSERT INTO TrabajaEn VALUES (3,33,1,0);
INSERT INTO TrabajaEn VALUES (4,34,1,0);
INSERT INTO TrabajaEn VALUES (5,35,1,0);
INSERT INTO TrabajaEn VALUES (1,31,2,0);
INSERT INTO TrabajaEn VALUES (2,32,2,0);
INSERT INTO TrabajaEn VALUES (3,33,2,0);
INSERT INTO TrabajaEn VALUES (4,34,2,0);
INSERT INTO TrabajaEn VALUES (5,35,2,0);

-- Falta hacer el sp pero la logica es esta... 
DROP VIEW IF EXISTS aux;
CREATE VIEW aux AS 
SELECT 		emp.IdJefe, emp.IdEmpleado, emp.Apellidos, emp.Nombres, car.Cargo, SUM(tra.HorasTrabajadas) AS Horas
FROM		Empleados emp 
INNER JOIN 	Cargos car ON emp.IdCargo = car.IdCargo
INNER JOIN	TrabajaEn tra ON emp.IdEmpleado = tra.IdEmpleado
WHERE		IdJefe IS NOT NULL
GROUP BY	emp.IdJefe, emp.IdEmpleado, emp.Apellidos, emp.Nombres, car.Cargo
ORDER BY 	emp.IdJefe, Horas DESC;

SELECT * FROM aux
UNION
SELECT NULL, NULL, NULL, NULL, NULL, SUM(Horas) FROM aux;

-- VistaTrabajos
CREATE VIEW VistaTrabajos AS
SELECT 		obr.NombreObra, tra.Descripcion, SUM(tra.Horas) AS Estimado, SUM(trae.HorasTrabajadas) AS 'Real'
FROM		Trabajos tra
INNER JOIN	Obras obr ON tra.IdObra = obr.IdObra
INNER JOIN 	TrabajaEn trae ON tra.IdTrabajo = trae.IdTrabajo
INNER JOIN	Empleados emp ON trae.IdEmpleado = emp.IdEmpleado
GROUP BY 	obr.NombreObra, tra.Descripcion
ORDER BY	obr.NombreObra, tra.Descripcion;
