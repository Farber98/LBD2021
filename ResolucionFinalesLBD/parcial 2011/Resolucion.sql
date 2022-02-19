DROP DATABASE IF EXISTS Parcial2011;
CREATE DATABASE Parcial2011;
USE Parcial2011;

-- BD
--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      jf
-- Project :      Model1.DM1
-- Author :       jf
--
-- Date Created : Thursday, June 24, 2021 10:39:08
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Artistas 
--

CREATE TABLE Artistas(
    IdArtista       INT            NOT NULL,
    Apellidos       VARCHAR(30)    NOT NULL,
    Nombres         VARCHAR(30)    NOT NULL,
    Nacionalidad    VARCHAR(30)    NOT NULL,
    PRIMARY KEY (IdArtista)
)ENGINE=INNODB
;



-- 
-- TABLE: Estilos 
--

CREATE TABLE Estilos(
    IdEstilo    INT            NOT NULL,
    Estilo      VARCHAR(30)    NOT NULL,
    PRIMARY KEY (IdEstilo)
)ENGINE=INNODB
;



-- 
-- TABLE: Exposiciones 
--

CREATE TABLE Exposiciones(
    IdExposicion         INT             NOT NULL,
    Titulo               VARCHAR(50)     NOT NULL,
    Descripcion          VARCHAR(200),
    FechaInauguracion    DATE            NOT NULL,
    FechaClausura        DATE,
    PRIMARY KEY (IdExposicion)
)ENGINE=INNODB
;



-- 
-- TABLE: Obras 
--

CREATE TABLE Obras(
    IdObra          INT               NOT NULL,
    IdArtista       INT               NOT NULL,
    IdEstilo        INT               NOT NULL,
    Titulo          VARCHAR(60)       NOT NULL,
    Fecha           DATE              NOT NULL,
    PrecioSalida    DECIMAL(12, 2)    NOT NULL,
    PRIMARY KEY (IdObra, IdArtista), 
    INDEX Ref11(IdEstilo),
    INDEX Ref22(IdArtista), 
    CONSTRAINT RefEstilos1 FOREIGN KEY (IdEstilo)
    REFERENCES Estilos(IdEstilo),
    CONSTRAINT RefArtistas2 FOREIGN KEY (IdArtista)
    REFERENCES Artistas(IdArtista)
)ENGINE=INNODB
;



-- 
-- TABLE: Muestras 
--

CREATE TABLE Muestras(
    IdObra          INT    NOT NULL,
    IdArtista       INT    NOT NULL,
    IdExposicion    INT    NOT NULL,
    PRIMARY KEY (IdObra, IdArtista, IdExposicion), 
    INDEX Ref43(IdObra, IdArtista),
    INDEX Ref34(IdExposicion), 
    CONSTRAINT RefObras3 FOREIGN KEY (IdObra, IdArtista)
    REFERENCES Obras(IdObra, IdArtista),
    CONSTRAINT RefExposiciones4 FOREIGN KEY (IdExposicion)
    REFERENCES Exposiciones(IdExposicion)
)ENGINE=INNODB
;



-- 
-- TABLE: Ofertas 
--

CREATE TABLE Ofertas(
    IdOferta        CHAR(10)          NOT NULL,
    IdObra          INT               NOT NULL,
    IdArtista       INT               NOT NULL,
    IdExposicion    INT               NOT NULL,
    Fecha           DATE,
    Importe         DECIMAL(12, 2)    NOT NULL,
    Ofertante       VARCHAR(100)      NOT NULL,
    Vendida         CHAR(1)           NOT NULL,
    PRIMARY KEY (IdOferta, IdObra, IdArtista, IdExposicion), 
    INDEX Ref55(IdObra, IdArtista, IdExposicion), 
    CONSTRAINT RefMuestras5 FOREIGN KEY (IdObra, IdArtista, IdExposicion)
    REFERENCES Muestras(IdObra, IdArtista, IdExposicion)
)ENGINE=INNODB
;



-- Inserciones
-- Artistas
INSERT INTO Artistas VALUES(1,'Miró', 'Joan', 'Española');
INSERT INTO Artistas VALUES(2,'Dalí', 'Salvador', 'Española');
INSERT INTO Artistas VALUES(3,'Monet', 'Claude', 'Francesa');
INSERT INTO Artistas VALUES(4,'Escher', 'Maurits', 'Holandesa');
INSERT INTO Artistas VALUES(5,'Spilimbergo', 'Lino', 'Argentina');
INSERT INTO Artistas VALUES(6,'Quinquela Martin', 'Benito', 'Argentina');

-- Exposiciones
INSERT INTO Exposiciones VALUES(1,'Los Surrealistas', 'Renombradas obras de artistas surrealistas','2009-11-01','2009-12-30');
INSERT INTO Exposiciones VALUES(2,'Los Españoles', 'Obras de pintores españoles','2010-01-01','2010-03-30');
INSERT INTO Exposiciones VALUES(3,'Los Argentinos', 'Renombradas obras de artistas argentinos','2010-04-01','2010-05-30');
INSERT INTO Exposiciones VALUES(4,'Expo Universal', 'Las mejores obras del mundo','2010-06-01','2010-10-30');

-- Estilos
INSERT INTO Estilos VALUES(1,'Impresionismo');
INSERT INTO Estilos VALUES(2,'Surrealismo');
INSERT INTO Estilos VALUES(3,'Naturalismo');
INSERT INTO Estilos VALUES(4,'Matemático');
INSERT INTO Estilos VALUES(5,'Realismo');

-- Obras
INSERT INTO Obras VALUES(1,1,2,'Carnaval del Arlequín','1925-01-01',34000000);
INSERT INTO Obras VALUES(2,1,2,'Retrato IV','1938-02-11',36000000);
INSERT INTO Obras VALUES(3,1,2,'Azul 3','1961-05-01',22000000);
INSERT INTO Obras VALUES(4,1,2,'Personaje delante del sol','1968-05-21',46000000);
INSERT INTO Obras VALUES(5,1,2,'Tapiz Tarragona','1970-12-15',41000000);
INSERT INTO Obras VALUES(6,2,2,'Figura Asomada a la Ventana','1925-10-04',66000000);
INSERT INTO Obras VALUES(7,2,2,'El enigma del deseo','1929-05-17',60000000);
INSERT INTO Obras VALUES(8,2,2,'El Hombre Invisible','1929-12-14',76000000);
INSERT INTO Obras VALUES(9,2,2,'La persistencia de la memoria','1931-06-27',99000000);
INSERT INTO Obras VALUES(10,2,2,'Cristo de San Juan de la Cruz','1951-02-06',97000000);
INSERT INTO Obras VALUES(11,3,1,'El Desayuno','1865-02-09',77000000);
INSERT INTO Obras VALUES(12,3,1,'Mujeres en el Jardín','1866-04-11',96000000);
INSERT INTO Obras VALUES(13,3,1,'Impresión, sol naciente','1873-06-01',99000000);
INSERT INTO Obras VALUES(14,3,1,'Puente sobre el Sena','1874-07-13',69000000);
INSERT INTO Obras VALUES(15,3,1,'Metamorfosis II','1940-02-22',11000000);
INSERT INTO Obras VALUES(16,4,4,'Casa de Escaleras','1951-09-01',12000000);
INSERT INTO Obras VALUES(17,4,4,'Día y Noche','1939-05-19',21000000);
INSERT INTO Obras VALUES(18,4,4,'Reptiles','1943-07-13',9000000);
INSERT INTO Obras VALUES(19,4,4,'Manos Dibujando','1948-10-08',30000000);
INSERT INTO Obras VALUES(20,4,4,'Cascada','1961-04-23',23000000);
INSERT INTO Obras VALUES(21,5,5,'Autorretrato','1917-01-14',1000000);
INSERT INTO Obras VALUES(22,5,5,'Canto a la luna','1923-05-11',2000000);
INSERT INTO Obras VALUES(23,5,5,'Desnudo de mujer','1926-07-02',3000000);
INSERT INTO Obras VALUES(24,5,5,'Acróbata','1927-11-13',1500000);
INSERT INTO Obras VALUES(25,5,5,'Paisaje de San Juan','1929-01-26',2500000);
INSERT INTO Obras VALUES(26,6,3,'Nocturno','1930-02-20',1300000);
INSERT INTO Obras VALUES(27,6,3,'Chimeneas','1930-11-02',3000000);
INSERT INTO Obras VALUES(28,6,3,'La Despedida','1936-07-11',5000000);
INSERT INTO Obras VALUES(29,6,3,'Desfile del circo','1936-09-15',7000000);
INSERT INTO Obras VALUES(30,6,3,'Música y Danza','1936-04-19',3500000);

-- Tabla Muestras
INSERT INTO Muestras VALUES(1,1,1);
INSERT INTO Muestras VALUES(3,1,1);
INSERT INTO Muestras VALUES(5,1,1);
INSERT INTO Muestras VALUES(7,2,1);
INSERT INTO Muestras VALUES(9,2,1);
INSERT INTO Muestras VALUES(17,4,1);
INSERT INTO Muestras VALUES(19,4,1);
INSERT INTO Muestras VALUES(1,1,2);
INSERT INTO Muestras VALUES(2,1,2);
INSERT INTO Muestras VALUES(3,1,2);
INSERT INTO Muestras VALUES(4,1,2);
INSERT INTO Muestras VALUES(5,1,2);
INSERT INTO Muestras VALUES(6,2,2);
INSERT INTO Muestras VALUES(7,2,2);
INSERT INTO Muestras VALUES(8,2,2);
INSERT INTO Muestras VALUES(9,2,2);
INSERT INTO Muestras VALUES(10,2,2);
INSERT INTO Muestras VALUES(21,5,3);
INSERT INTO Muestras VALUES(22,5,3);
INSERT INTO Muestras VALUES(23,5,3);
INSERT INTO Muestras VALUES(24,5,3);
INSERT INTO Muestras VALUES(25,5,3);
INSERT INTO Muestras VALUES(26,6,3);
INSERT INTO Muestras VALUES(27,6,3);
INSERT INTO Muestras VALUES(28,6,3);
INSERT INTO Muestras VALUES(29,6,3);
INSERT INTO Muestras VALUES(30,6,3);
INSERT INTO Muestras VALUES(1,1,4);
INSERT INTO Muestras VALUES(2,1,4);
INSERT INTO Muestras VALUES(3,1,4);
INSERT INTO Muestras VALUES(4,1,4);
INSERT INTO Muestras VALUES(5,1,4);
INSERT INTO Muestras VALUES(6,2,4);
INSERT INTO Muestras VALUES(7,2,4);
INSERT INTO Muestras VALUES(8,2,4);
INSERT INTO Muestras VALUES(9,2,4);
INSERT INTO Muestras VALUES(10,2,4);
INSERT INTO Muestras VALUES(11,3,4);
INSERT INTO Muestras VALUES(12,3,4);
INSERT INTO Muestras VALUES(13,3,4);
INSERT INTO Muestras VALUES(14,3,4);
INSERT INTO Muestras VALUES(15,3,4);
INSERT INTO Muestras VALUES(16,4,4);
INSERT INTO Muestras VALUES(17,4,4);
INSERT INTO Muestras VALUES(18,4,4);
INSERT INTO Muestras VALUES(19,4,4);
INSERT INTO Muestras VALUES(20,4,4);
INSERT INTO Muestras VALUES(21,5,4);
INSERT INTO Muestras VALUES(22,5,4);
INSERT INTO Muestras VALUES(23,5,4);
INSERT INTO Muestras VALUES(24,5,4);
INSERT INTO Muestras VALUES(25,5,4);
INSERT INTO Muestras VALUES(26,6,4);
INSERT INTO Muestras VALUES(27,6,4);
INSERT INTO Muestras VALUES(28,6,4);
INSERT INTO Muestras VALUES(29,6,4);
INSERT INTO Muestras VALUES(30,6,4);

-- Tabla Ofertas
INSERT INTO Ofertas VALUES(1,1,1,1,'2009-12-01',34000000,'lgonzalez','N');
INSERT INTO Ofertas VALUES(2,1,1,1,'2009-12-02',35000000,'bgates','N');
INSERT INTO Ofertas VALUES(3,1,1,1,'2009-12-04',35500000,'rdeniro','S');
INSERT INTO Ofertas VALUES(4,7,2,1,'2009-12-01',60000000,'kcostner','N');
INSERT INTO Ofertas VALUES(5,7,2,1,'2009-12-06',65000000,'mjordan','S');
INSERT INTO Ofertas VALUES(6,7,2,1,'2009-12-02',63000000,'bgates','N');
INSERT INTO Ofertas VALUES(7,9,2,1,'2009-12-05',99000000,'bgates','N');
INSERT INTO Ofertas VALUES(8,17,4,1,'2009-12-19',21000000,'lgonzalez','N');
INSERT INTO Ofertas VALUES(9,19,4,1,'2009-12-20',30000000,'bgates','N');
INSERT INTO Ofertas VALUES(10,2,1,2,'2010-01-05',36000000,'lgonzalez','N');
INSERT INTO Ofertas VALUES(11,2,1,2,'2010-01-07',38000000,'bgates','N');
INSERT INTO Ofertas VALUES(12,2,1,2,'2010-02-17',40000000,'kcostner','S');
INSERT INTO Ofertas VALUES(13,3,1,2,'2010-01-17',23000000,'mjordan','N');
INSERT INTO Ofertas VALUES(14,3,1,2,'2010-02-03',24000000,'bgates','N');
INSERT INTO Ofertas VALUES(15,4,1,2,'2010-01-03',47000000,'bgates','N');
INSERT INTO Ofertas VALUES(16,8,2,2,'2010-01-05',76000000,'bgates','N');
INSERT INTO Ofertas VALUES(17,8,2,2,'2010-01-15',78000000,'bgates','N');
INSERT INTO Ofertas VALUES(18,8,2,2,'2010-01-23',83000000,'bgates','N');
INSERT INTO Ofertas VALUES(19,8,2,2,'2010-02-05',90000000,'modstrcil','S');
INSERT INTO Ofertas VALUES(20,9,2,2,'2010-02-15',99000000,'bgates','N');
INSERT INTO Ofertas VALUES(21,10,2,2,'2010-03-15',97000000,'rdeniro','N');
INSERT INTO Ofertas VALUES(22,21,5,3,'2010-01-15',1000000,'rdeniro','N');
INSERT INTO Ofertas VALUES(23,21,5,3,'2010-02-01',1200000,'lgonzalez','N');
INSERT INTO Ofertas VALUES(24,22,5,3,'2010-02-01',2000000,'bgates','N');
INSERT INTO Ofertas VALUES(25,22,5,3,'2010-03-11',2100000,'bgates','N');
INSERT INTO Ofertas VALUES(26,23,5,3,'2010-02-21',3000000,'lgonzalez','N');
INSERT INTO Ofertas VALUES(27,30,6,3,'2010-03-11',3600000,'mjordan','N');
INSERT INTO Ofertas VALUES(28,30,6,3,'2010-03-13',3700000,'bgates','N');
INSERT INTO Ofertas VALUES(29,10,2,4,'2010-01-13',97000000,'bgates','N');
INSERT INTO Ofertas VALUES(30,10,2,4,'2010-01-22',99000000,'modstrcil','N');
INSERT INTO Ofertas VALUES(31,13,3,4,'2010-01-17',99000000,'lgonzalez','N');
INSERT INTO Ofertas VALUES(32,13,3,4,'2010-01-17',91000000,'bgates','N');
INSERT INTO Ofertas VALUES(33,16,4,4,'2010-01-02',12000000,'bgates','N');
INSERT INTO Ofertas VALUES(34,16,4,4,'2010-01-03',12500000,'lgozalez','N');
INSERT INTO Ofertas VALUES(35,16,4,4,'2010-01-04',15000000,'mjordan','N');
INSERT INTO Ofertas VALUES(36,16,4,4,'2010-01-14',17000000,'rdeniro','N');
INSERT INTO Ofertas VALUES(37,30,6,4,'2010-01-04',3500000,'rdeniro','N');
INSERT INTO Ofertas VALUES(38,30,6,4,'2010-01-04',3600000,'modstrcil','N');
INSERT INTO Ofertas VALUES(39,30,6,4,'2010-01-11',3800000,'bgates','N');
INSERT INTO Ofertas VALUES(40,30,6,4,'2010-01-24',4200000,'mjordan','N');
INSERT INTO Ofertas VALUES(41,30,6,4,'2010-02-09',5000000,'lgonzalez','S');

-- Vista Ventas
DROP VIEW IF EXISTS VistaVentas;
CREATE VIEW VistaVentas AS 
SELECT		obr.IdObra, obr.Titulo Obra, est.Estilo, art.IdArtista, CONCAT(art.Apellidos, ', ', art.Nombres) Artista,
			exp.IdExposicion, exp.Titulo Exposicion, ofe.Fecha, ofe.Ofertante, ofe.Importe
FROM		Ofertas ofe
INNER JOIN	Muestras mue ON ofe.IdObra = mue.IdObra AND ofe.IdArtista = mue.IdArtista AND ofe.IdExposicion = mue.IdExposicion
INNER JOIN	Exposiciones exp ON mue.IdExposicion = exp.IdExposicion
INNER JOIN	Obras obr ON mue.IdObra = obr.IdObra AND mue.IdArtista = obr.IdArtista
INNER JOIN	Artistas art ON obr.IdArtista = art.IdArtista
INNER JOIN	Estilos est ON obr.IdEstilo = est.IdEstilo
WHERE Vendida = 'S';

-- Falta el SP de EstadoObras
SELECT 		obr.IdObra, obr.Titulo Obra, obr.PrecioSalida Precio, MAX(IFNULL(ofe.Importe,0)) AS Importe,
			MAX(IFNULL(ofe.Vendida, 'N')) AS Vendida, MAX(IFNULL(ofe.Importe - obr.PrecioSalida,0)) AS Ganancia
FROM		Ofertas ofe
LEFT JOIN	Muestras mue ON ofe.IdObra = mue.IdObra AND ofe.IdArtista = mue.IdArtista AND ofe.IdExposicion = mue.IdExposicion
RIGHT JOIN	Obras obr ON mue.IdObra = obr.IdObra AND mue.IdArtista = obr.IdArtista
GROUP BY 	obr.IdArtista, obr.IdObra, obr.Titulo, obr.PrecioSalida
ORDER BY 	obr.IdObra, Importe DESC;