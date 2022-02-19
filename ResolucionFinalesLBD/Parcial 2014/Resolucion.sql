-- Creamos la BD

DROP DATABASE IF EXISTS Parcial2014;
CREATE DATABASE Parcial2014;
USE Parcial2014;

--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      jf
-- Project :      Model1.DM1
-- Author :       jf
--
-- Date Created : Thursday, June 24, 2021 10:12:48
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Categorias 
--

CREATE TABLE Categorias(
    IdCategoria    INT            NOT NULL,
    Categoria      VARCHAR(25)    NOT NULL,
    PRIMARY KEY (IdCategoria)
)ENGINE=INNODB
;



-- 
-- TABLE: Conocimientos 
--

CREATE TABLE Conocimientos(
    IdConocimiento    INT            NOT NULL,
    IdCategoria       INT            NOT NULL,
    Conocimiento      VARCHAR(25)    NOT NULL,
    PRIMARY KEY (IdConocimiento, IdCategoria), 
    INDEX Ref22(IdCategoria), 
    CONSTRAINT RefCategorias2 FOREIGN KEY (IdCategoria)
    REFERENCES Categorias(IdCategoria)
)ENGINE=INNODB
;



-- 
-- TABLE: Niveles 
--

CREATE TABLE Niveles(
    IdNivel    INT            NOT NULL,
    Nivel      VARCHAR(25)    NOT NULL,
    PRIMARY KEY (IdNivel)
)ENGINE=INNODB
;



-- 
-- TABLE: Puesto 
--

CREATE TABLE Puestos(
    IdPuesto    INT            NOT NULL,
    Puesto      VARCHAR(25)    NOT NULL,
    PRIMARY KEY (IdPuesto)
)ENGINE=INNODB
;



-- 
-- TABLE: Personas 
--

CREATE TABLE Personas(
    IdPersona       INT            NOT NULL,
    IdPuesto        INT            NOT NULL,
    Nombres         VARCHAR(25)    NOT NULL,
    Apellidos       VARCHAR(25)    NOT NULL,
    FechaIngreso    DATE           NOT NULL,
    FechaBaja       DATE,
    PRIMARY KEY (IdPersona, IdPuesto), 
    UNIQUE INDEX UI_IdPersona(IdPersona),
    INDEX Ref31(IdPuesto), 
    CONSTRAINT RefPuesto1 FOREIGN KEY (IdPuesto)
    REFERENCES Puestos(IdPuesto)
)ENGINE=INNODB
;



-- 
-- TABLE: Skills 
--

CREATE TABLE Skills(
    IdSkill                    INT             NOT NULL,
    IdPersona                  INT             NOT NULL,
    IdConocimiento             INT             NOT NULL,
    IdCategoria                INT             NOT NULL,
    IdNivel                    INT             NOT NULL,
    FechaUltimaModificacion    DATETIME        NOT NULL,
    Observaciones              VARCHAR(144),
    PRIMARY KEY (IdSkill, IdPersona, IdConocimiento, IdCategoria, IdNivel), 
    INDEX Ref13(IdNivel),
    INDEX Ref55(IdConocimiento, IdCategoria),
    INDEX Ref46(IdPersona), 
    CONSTRAINT RefNiveles3 FOREIGN KEY (IdNivel)
    REFERENCES Niveles(IdNivel),
    CONSTRAINT RefConocimientos5 FOREIGN KEY (IdConocimiento, IdCategoria)
    REFERENCES Conocimientos(IdConocimiento, IdCategoria),
    CONSTRAINT RefPersonas6 FOREIGN KEY (IdPersona)
    REFERENCES Personas(IdPersona)
)ENGINE=INNODB
;

-- Inserciones
INSERT INTO `Categorias` (`IdCategoria`, `Categoria`) VALUES ('1', 'IDIOMA');
INSERT INTO `Categorias` (`IdCategoria`, `Categoria`) VALUES ('2', 'NET');
INSERT INTO `Categorias` (`IdCategoria`, `Categoria`) VALUES ('3', 'JAVA');
INSERT INTO `Categorias` (`IdCategoria`, `Categoria`) VALUES ('4', 'SO');
INSERT INTO `Categorias` (`IdCategoria`, `Categoria`) VALUES ('5', 'REDES');

INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('1', '1', 'INGLES ORAL');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('2', '1', 'INGLES ESCRITO');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('3', '1', 'FRANCES ORAL');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('4', '1', 'FRANCES ESCRITO');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('5', '2', 'MVC');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('6', '2', 'ASP.NET');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('7', '2', 'VB.NET');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('8', '2', 'C#.NET');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('9', '3', 'J2SE ');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('10', '3', 'Escritorio');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('11', '3', 'WEB');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('12', '3', 'Servicios');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('13', '4', 'W Server 2000');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('14', '4', 'W Server 2003');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('15', '4', 'W Server 2008');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('16', '4', 'Ubuntu');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('17', '4', 'Unix');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('18', '4', 'DOS');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('19', '5', 'Virtualizacion');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('20', '5', 'LAN');
INSERT INTO `Conocimientos` (`IdConocimiento`, `IdCategoria`, `Conocimiento`) VALUES ('21', '5', 'WAN');

INSERT INTO `Niveles` (`IdNivel`, `Nivel`) VALUES ('1', 'Nulo');
INSERT INTO `Niveles` (`IdNivel`, `Nivel`) VALUES ('2', 'Básico');
INSERT INTO `Niveles` (`IdNivel`, `Nivel`) VALUES ('3', 'Intermedio');
INSERT INTO `Niveles` (`IdNivel`, `Nivel`) VALUES ('4', 'Avanzado');
INSERT INTO `Niveles` (`IdNivel`, `Nivel`) VALUES ('5', 'Experto');

INSERT INTO `Puestos` (`IdPuesto`, `Puesto`) VALUES ('1', 'Programador');
INSERT INTO `Puestos` (`IdPuesto`, `Puesto`) VALUES ('2', 'Analista');
INSERT INTO `Puestos` (`IdPuesto`, `Puesto`) VALUES ('3', 'Líder');

INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('1', '1', 'Juan', 'Romano', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('2', '1', 'Pablo', 'García', '2014/01/01', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('3', '1', 'Miguel', 'Godoy', '2014/01/01', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('4', '1', 'Luis', 'Rolandi', '2014/01/01', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('5', '1', 'Maximiliano', 'Villafañez', '2013/10/01', '2014/11/01');
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('6', '1', 'Alejandro', 'Boixados', '2013/10/01', '2014/10/10');
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('7', '1', 'Cecilia', 'López', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('8', '1', 'Alba', 'Gómez', '2013/10/01', '2014/11/01');
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('9', '1', 'Soledad', 'Alderete', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('10', '1', 'Alfredo', 'López', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('11', '1', 'Romina', 'Torrez', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('12', '1', 'Juan', 'Giobellina', '2009/08/08', '2014/10/10');
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('13', '2', 'Sebastián', 'Gómez', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('14', '2', 'Martín', 'Gonzáles', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('15', '2', 'María Laura', 'Torres', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('16', '2', 'Jorge', 'Ibañez', '2009/08/08', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('17', '2', 'Ariel', 'Ceballos', '2009/08/08', '2014/10/10');
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('18', '3', 'Alfredo', 'Alcorta', '2012/10/01', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('19', '3', 'Miguel', 'Algañarás', '2012/10/01', null);
INSERT INTO `Personas` (`IdPersona`, `IdPuesto`, `Nombres`, `Apellidos`, `FechaIngreso`, `FechaBaja`) VALUES ('20', '3', 'Antonio', 'Martínez', '2012/10/01', null);

INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('1', '1', '1', '1', '1', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('2', '1', '2', '1', '1', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('3', '1', '3', '1', '1', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('4', '1', '4', '1', '1', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('5', '1', '5', '2', '1', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('6', '1', '6', '2', '2', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('7', '1', '7', '2', '2', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('8', '1', '8', '2', '2', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('9', '1', '9', '3', '2', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('10', '2', '1', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('11', '2', '2', '1', '3', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('12', '3', '1', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('13', '3', '2', '1', '4', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('14', '4', '1', '1', '4', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('15', '4', '2', '1', '4', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('16', '4', '3', '1', '5', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('17', '5', '1', '1', '5', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('18', '5', '2', '1', '4', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('19', '6', '1', '1', '3', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('20', '6', '2', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('21', '7', '1', '1', '2', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('22', '7', '2', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('23', '8', '1', '1', '4', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('24', '9', '2', '1', '5', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('25', '10', '1', '1', '3', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('26', '10', '2', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('27', '10', '3', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('28', '10', '4', '1', '4', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('29', '10', '5', '2', '5', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('30', '10', '6', '2', '3', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('31', '10', '7', '2', '1', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('32', '10', '8', '2', '1', '2014/11/03');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('33', '10', '9', '3', '1', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('34', '10', '10', '3', '2', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('35', '10', '11', '3', '2', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('36', '11', '1', '1', '2', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('37', '11', '2', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('38', '11', '3', '1', '3', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('39', '11', '4', '1', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('40', '11', '5', '2', '4', '2013/08/12');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('41', '11', '6', '2', '4', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('42', '11', '7', '2', '5', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('43', '11', '8', '2', '5', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('44', '11', '9', '3', '4', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('45', '11', '10', '3', '3', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('46', '11', '11', '3', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('47', '11', '12', '3', '2', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('48', '11', '13', '4', '3', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('49', '11', '14', '4', '4', '2014/10/01');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`) VALUES ('50', '11', '21', '5', '5', '2014/04/04');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`, `Observaciones`) VALUES ('51', '1', '13', '4', '1', '2014/10/01', 'Con Certificacion');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`, `Observaciones`) VALUES ('52', '10', '14', '4', '1', '2013/08/12', 'Autodidacta');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`, `Observaciones`) VALUES ('53', '11', '16', '4', '4', '2014/10/01', 'Realizando formacion');
INSERT INTO `Skills` (`IdSkill`, `IdPersona`, `IdConocimiento`, `IdCategoria`, `IdNivel`, `FechaUltimaModificacion`, `Observaciones`) VALUES ('54', '11', '17', '4', '2', '2013/08/12', 'En uso actualmente');



-- Creamos la vista
CREATE VIEW vistaConocimientosPorEmpleado AS
SELECT 		cat.Categoria, con.Conocimiento, per.Apellidos, per.Nombres, niv.Nivel
FROM		Skills ski 
INNER JOIN	Niveles niv ON ski.IdNIvel = niv.IdNivel
INNER JOIN	Conocimientos con ON ski.IdConocimiento = con.IdConocimiento AND ski.IdCategoria = con.IdCategoria
INNER JOIN 	Personas per ON ski.IdPersona = per.IdPersona
INNER JOIN 	Categorias cat ON con.IdCategoria = cat.IdCategoria
ORDER BY cat.Categoria, con.Conocimiento;

-- Probamos la vista
SELECT * FROM vistaConocimientosPorEmpleado;

-- SP SIN SER SP 
SELECT 		cat.Categoria, con.Conocimiento, COUNT(CONCAT(per.Apellidos, ', ', per.Nombres)) AS Cantidad
FROM		Skills ski 
INNER JOIN	Niveles niv ON ski.IdNIvel = niv.IdNivel
INNER JOIN	Conocimientos con ON ski.IdConocimiento = con.IdConocimiento AND ski.IdCategoria = con.IdCategoria
INNER JOIN 	Personas per ON ski.IdPersona = per.IdPersona
INNER JOIN 	Categorias cat ON con.IdCategoria = cat.IdCategoria
GROUP BY Categoria, Conocimiento
ORDER BY cat.Categoria DESC, con.Conocimiento DESC, Cantidad DESC;

