-- Año: 2021 
-- Grupo Nro: 10
-- Integrantes: Romano, Hugo Leandro - Farber, Juan.  
-- Tema: Compra y venta de materiales eléctricos.
-- Nombre del Esquema: LBD202110
-- Plataforma (SO + Versión): Windows 10 Home Version 20H2 - Ubuntu 20.04.2 LTS (Focal Fossa)
-- Motor y Versión: 8.0.23 for Windows on x86_64 (MySQL Community Server - GPL) - 8.0.23 for Linux on x86_64 (MySQL Community Server - GPL)
-- GitHub Repositorio: LBD2021G10
-- GitHub Usuario: leoromano98, Farber98

DROP DATABASE IF EXISTS LBD202110;

CREATE DATABASE LBD202110;

USE LBD202110;

-- 
-- TABLE: Cargos 
--

CREATE TABLE Cargos(
    IdCargo    TINYINT        AUTO_INCREMENT,
    Cargo      VARCHAR(60)    NOT NULL
                              CHECK (Cargo IN ('Gerente','Cajero','Vendedor','Comprador')),
    Estado     CHAR(1)        DEFAULT 'A' NOT NULL
                              CHECK (Estado IN ('A','I')),
    PRIMARY KEY (IdCargo), 
    UNIQUE INDEX UI_IdCargo(Cargo)
)ENGINE=INNODB
;



-- 
-- TABLE: Personas 
--

CREATE TABLE Personas(
    IdPersona    INT             AUTO_INCREMENT,
    Apellidos    VARCHAR(60)     NOT NULL,
    Nombres      VARCHAR(60)     NOT NULL,
    Email        VARCHAR(100)    NOT NULL,
    TipoDoc      VARCHAR(4)      NOT NULL,
    NumDoc       VARCHAR(30)     NOT NULL,
    FechaNac     DATE            NOT NULL,
    Direccion    VARCHAR(100)    NOT NULL,
    Telefono     VARCHAR(30)     NOT NULL,
    PRIMARY KEY (IdPersona), 
    UNIQUE INDEX UI_Email(Email),
    UNIQUE INDEX UI_NumDocTipoDoc(NumDoc, TipoDoc),
    INDEX IX_ApellidosNombres(Apellidos, Nombres)
)ENGINE=INNODB
;



-- 
-- TABLE: Clientes 
--

CREATE TABLE Clientes(
    IdCliente        INT        NOT NULL,
    EstadoCliente    CHAR(1)    DEFAULT 'A' NOT NULL 
                                CHECK (EstadoCliente IN ('A','I')),
    PRIMARY KEY (IdCliente), 
    INDEX Ref527(IdCliente), 
    CONSTRAINT RefPersonas274 FOREIGN KEY (IdCliente)
    REFERENCES Personas(IdPersona)
)ENGINE=INNODB
;



-- 
-- TABLE: Proveedores 
--

CREATE TABLE Proveedores(
    IdProveedor    SMALLINT        AUTO_INCREMENT,
    RazonSocial    VARCHAR(60)     NOT NULL,
    TipoDoc        VARCHAR(4)      NOT NULL,
    NumDoc         VARCHAR(30)     NOT NULL,
    Domicilio      VARCHAR(100)    NOT NULL,
    Telefono       VARCHAR(30)     NOT NULL,
    Email          VARCHAR(100)    NOT NULL,
    Estado         CHAR(1)         DEFAULT 'A' NOT NULL
                                   CHECK (Estado IN ('A','I')),
    PRIMARY KEY (IdProveedor), 
    UNIQUE INDEX UI_RazonSocial(RazonSocial),
    UNIQUE INDEX UI_NumDocTipoDoc(NumDoc, TipoDoc)
)ENGINE=INNODB
;



-- 
-- TABLE: Empleados 
--

CREATE TABLE Empleados(
    IdEmpleado        INT            NOT NULL,
    IdCargo           TINYINT        NOT NULL,
    Usuario           VARCHAR(40)    NOT NULL,
    Contrasena        CHAR(32)       NOT NULL,
    EstadoEmpleado    CHAR(1)        DEFAULT 'A' NOT NULL
                                     CHECK (EstadoEmpleado IN ('A','I')),
    PRIMARY KEY (IdEmpleado), 
    UNIQUE INDEX UI_Usuario(Usuario),
    INDEX Ref526(IdEmpleado),
    INDEX Ref1729(IdCargo), 
    CONSTRAINT RefPersonas264 FOREIGN KEY (IdEmpleado)
    REFERENCES Personas(IdPersona),
    CONSTRAINT RefCargos294 FOREIGN KEY (IdCargo)
    REFERENCES Cargos(IdCargo)
)ENGINE=INNODB
;



-- 
-- TABLE: Compras 
--

CREATE TABLE Compras(
    IdCompra        INT            AUTO_INCREMENT,
    IdEmpleado      INT            NOT NULL,
    IdProveedor     SMALLINT       NOT NULL,
    NumFactura      VARCHAR(30)    NOT NULL,
    FechaCompra     DATETIME       DEFAULT current_timestamp NOT NULL,
    FechaEntrega    DATETIME       DEFAULT null,
    FechaPago       DATETIME       DEFAULT null,
    PRIMARY KEY (IdCompra, IdEmpleado, IdProveedor), 
    UNIQUE INDEX UI_IdCompra(IdCompra),
    UNIQUE INDEX UI_NumFactura(NumFactura),
    INDEX IX_FechaCompra(FechaCompra),
    INDEX Ref146(IdProveedor),
    INDEX Ref621(IdEmpleado), 
    CONSTRAINT RefProveedores64 FOREIGN KEY (IdProveedor)
    REFERENCES Proveedores(IdProveedor),
    CONSTRAINT RefEmpleados214 FOREIGN KEY (IdEmpleado)
    REFERENCES Empleados(IdEmpleado)
)ENGINE=INNODB
;



-- 
-- TABLE: NombreProductos 
--

CREATE TABLE NombreProductos(
    IdNombreProducto    SMALLINT        AUTO_INCREMENT,
    NombreProducto      VARCHAR(100)    NOT NULL,
    UmbralStock         SMALLINT        NOT NULL,
    Estado              CHAR(1)         DEFAULT 'A' NOT NULL
                                        CHECK (Estado IN ('A','I')),
    PRIMARY KEY (IdNombreProducto), 
    UNIQUE INDEX UI_NombreProducto(NombreProducto)
)ENGINE=INNODB
;



-- 
-- TABLE: Rubros 
--

CREATE TABLE Rubros(
    IdRubro    SMALLINT       AUTO_INCREMENT,
    Rubro      VARCHAR(60)    NOT NULL,
    Estado     CHAR(1)        DEFAULT 'A' NOT NULL
                              CHECK (Estado IN ('A','I')),
    PRIMARY KEY (IdRubro), 
    UNIQUE INDEX UI_Rubro(Rubro)
)ENGINE=INNODB
;



-- 
-- TABLE: Productos 
--

CREATE TABLE Productos(
    IdProducto          INT            AUTO_INCREMENT,
    IdRubro             SMALLINT       NOT NULL,
    IdNombreProducto    SMALLINT       NOT NULL,
    Color               VARCHAR(60)    NOT NULL,
    PRIMARY KEY (IdProducto, IdRubro), 
    INDEX Ref1515(IdRubro),
    INDEX Ref1930(IdNombreProducto),
    UNIQUE INDEX UI_IdProducto(IdProducto),
    INDEX IX_Color(Color), 
    CONSTRAINT RefNombreProductos304 FOREIGN KEY (IdNombreProducto)
    REFERENCES NombreProductos(IdNombreProducto),
    CONSTRAINT RefRubros154 FOREIGN KEY (IdRubro)
    REFERENCES Rubros(IdRubro)
)ENGINE=INNODB
;



-- 
-- TABLE: LineasCompras 
--

CREATE TABLE LineasCompras(
    IdLineaCompra    INT               AUTO_INCREMENT,
    IdCompra         INT               NOT NULL,
    IdEmpleado       INT               NOT NULL,
    IdProveedor      SMALLINT          NOT NULL,
    IdRubro          SMALLINT          NOT NULL,
    IdProducto       INT               NOT NULL,
    Cantidad         SMALLINT          NOT NULL
                     CHECK (Cantidad > 0),
    Precio           DECIMAL(10, 2)    NOT NULL
                     CHECK (Precio > 0),
    PRIMARY KEY (IdLineaCompra, IdCompra, IdEmpleado, IdProveedor, IdRubro, IdProducto), 
    UNIQUE INDEX UI_LineaCompra(IdLineaCompra),
    INDEX Ref137(IdProveedor, IdCompra, IdEmpleado),
    INDEX Ref1119(IdRubro, IdProducto), 
    CONSTRAINT RefCompras74 FOREIGN KEY (IdCompra, IdEmpleado, IdProveedor)
    REFERENCES Compras(IdCompra, IdEmpleado, IdProveedor),
    CONSTRAINT RefProductos194 FOREIGN KEY (IdProducto, IdRubro)
    REFERENCES Productos(IdProducto, IdRubro)
)ENGINE=INNODB
;



-- 
-- TABLE: Ventas 
--

CREATE TABLE Ventas(
    IdVenta         INT         AUTO_INCREMENT,
    IdEmpleado      INT         NOT NULL,
    IdCliente       INT         NOT NULL,
    FechaVenta      DATETIME    DEFAULT current_timestamp NOT NULL,
    FechaEntrega    DATETIME    DEFAULT null,
    FechaPago       DATETIME    DEFAULT null,
    PRIMARY KEY (IdVenta, IdEmpleado, IdCliente), 
    UNIQUE INDEX UI_IdVenta(IdVenta),
    INDEX IX_FechaVenta(FechaVenta),
    INDEX Ref624(IdEmpleado),
    INDEX Ref825(IdCliente), 
    CONSTRAINT RefEmpleados244 FOREIGN KEY (IdEmpleado)
    REFERENCES Empleados(IdEmpleado),
    CONSTRAINT RefClientes254 FOREIGN KEY (IdCliente)
    REFERENCES Clientes(IdCliente)
)ENGINE=INNODB
;



-- 
-- TABLE: LineasVentas 
--

CREATE TABLE LineasVentas(
    IdLineaVenta    INT               AUTO_INCREMENT,
    IdVenta         INT               NOT NULL,
    IdEmpleado      INT               NOT NULL,
    IdCliente       INT               NOT NULL,
    IdRubro         SMALLINT          NOT NULL,
    IdProducto      INT               NOT NULL,
    Cantidad         SMALLINT          NOT NULL
                     CHECK (Cantidad > 0),
    Precio           DECIMAL(10, 2)    NOT NULL
                     CHECK (Precio > 0),
    PRIMARY KEY (IdLineaVenta, IdVenta, IdEmpleado, IdCliente, IdRubro, IdProducto), 
    UNIQUE INDEX UI_IdLineaVenta(IdLineaVenta),
    INDEX Ref98(IdVenta, IdEmpleado, IdCliente),
    INDEX Ref1120(IdProducto, IdRubro), 
    CONSTRAINT RefVentas84 FOREIGN KEY (IdVenta, IdEmpleado, IdCliente)
    REFERENCES Ventas(IdVenta, IdEmpleado, IdCliente),
    CONSTRAINT RefProductos204 FOREIGN KEY (IdProducto, IdRubro)
    REFERENCES Productos(IdProducto, IdRubro)
)ENGINE=INNODB
;


-- Insert Personas

INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('1','Mendiondo', 'Alejandro Matias', 'mendiondo@yahoo.com', 'DNI', '3949234', '1943-02-25', 'Paul 304', '4394939423');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('2','Nieto', 'Luis Eduardo', 'nieto@val.com', 'DNI', '9394923', '1949-05-19', 'Lax 3043', '9394929393');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('3','Brito', 'Luis Eduardo', 'brito@uolsinectis.com', 'CUIL', '08501035054', '1950-01-02', 'Discord 39', '4985618037');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('4','Blanco', 'Franco', 'blanco@amazon.com', 'DNI', '59608215 ', '2000-02-03', 'Skype 4000', '0469813100');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('5','Flores Wittich', 'Pablo', 'floreswittich@aol.com', 'CUIL', '38713269482', '2010-03-04', 'Trx 10', '3450687413');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('6','Romano', 'Hugo Leandro', 'romano@hotmail.com', 'LE', '6163888', '1993-07-30', 'Alarm 3943', '3671519062');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('7','Coca', 'Luis Rogelio', 'coca@fanta.com', 'LE', '4105033', '1932-02-09', 'Gasoys 30', '1443841039');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('8','Pastrana', 'Gonzalo Adrian', 'pastrana@msn.com', 'CUIL', '10891831005', '1935-09-05', 'Cancel 9932', '5289517952');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('9','Diaz Fontdevilla', 'Rodrigo', 'diazfontdevilla@gob.com', 'CUIL', '70151752425', '2000-04-03', 'Roca 3041', '2942966309');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('10','Cervino', 'Josemaria', 'cervino@info.com', 'DNI', '22723875 ', '1933-05-12', 'Alsina 3211', '3686984717');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('11','De la pena', 'Climaco Rafael Tomas', 'delapena@aoe.com', 'DNI', '2449395935', '1993-10-19', 'Marcos Paz 2031', '0232734564');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('12','Odstrcil', 'Maximiliano', 'odstrcil@cs.com', 'DNI', '24209222', '1992-09-13', 'Santa Fe 123', '7612782574');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('13','Rossi', 'Guillermo', 'rossi@go.com', 'CUIL', '77234430432', '1940-05-23', 'Plata 343', '6957973492');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('14','Alvarez Gonzalez', 'Keanu', 'alvarezgonzalez@js.com', 'LE', '5791122', '1937-12-12', 'Argentum 1230', '6222527834');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('15','Boeri', 'Benjamin', 'boeri@css.com', 'LE', '8520376', '2000-04-03', 'Sodium 1923', '8989857563');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('16','Campero', 'Martin', 'campero@jsx.com', 'CUIL', '77234459006', '2000-04-30', 'Potasium 3403', '0596862071');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('17','Campero', 'Leandro', 'campero@idx.com', 'DNI', '88045228', '2000-03-07', 'Platinum 3939', '0904753078');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('18','Farber', 'Juan', 'farber@pbx.com', 'DNI', '80700461', '1935-07-30', 'Modium 933', '2121334133');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('19','Sale', 'Roberto Moises', 'sale@fac.com', 'LE', '0049131', '1945-08-25', 'Zauron 033', '3574951666');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('20','Murcani', 'Julian', 'murcani@elx.com', 'CUIL', '79010469183', '1964-05-20', 'Core 0343', '8266018608');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('21','Tucholsky', 'Kurt', 'tucholsky@man.com', 'DNI', '01046918', '1984-08-25', 'Manuk 2354', '9394929');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('22','Michel', 'Camil', 'Michle@ldx.com', 'CUIL', '06310469181', '1995-01-22', 'Mem 3341', '31231');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('23','Zahlne', 'Ein', 'Zahlne@czxb.com', 'LE', '92304423', '1933-02-21', 'Losung 3423', '9348232');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('24','Aus', 'Max', 'Aus@siomex.com', 'DNI', '39432934', '1924-09-30', 'Este 4032', '939432342');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('25','Gen', 'Julian', 'gen@nir.com', 'CUIL', '923432934', '1939-09-25', 'Senegal 3043', '39923420');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('26','Maur', 'Eve', 'Maur@lacnic.com', 'DNI', '30432034', '1950-03-08', 'Madagascar 403', '3052034');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('27','Desc', 'Pepe', 'desc@nir.com', 'LE', '3942342', '1933-01-20', 'Mali 3022', '8923423');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('28','Naux', 'Diego', 'Naux@afrinic.com', 'CUIL', '3042342393', '1950-11-30', 'Kenia 0432', '2032312');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('29','Ein', 'Gabriel', 'ein@ripe.com', 'DNI', '29321232', '1950-10-10', 'Mambru 953', '2931233');
INSERT INTO `LBD202110`.`Personas` (`IdPersona`, `Apellidos`, `Nombres`, `Email`, `TipoDoc`, `NumDoc`, `FechaNac`, `Direccion`, `Telefono`) VALUES ('30','Ave', 'Julio', 'ave@ocean.com', 'LE', '2343234', '1970-01-29', 'Ampere 3043', '3942342');

-- Insert Clientes

INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('1');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('3');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('5');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('7');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('9');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('11');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('13');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('21');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('22');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('23');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('24');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('25');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('26');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('27');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('28');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('29');
INSERT INTO `LBD202110`.`Clientes` (`IdCliente`) VALUES ('30');


-- Insert Cargos

INSERT INTO `LBD202110`.`Cargos` (`IdCargo`, `Cargo`) VALUES ('1','Gerente');
INSERT INTO `LBD202110`.`Cargos` (`IdCargo`, `Cargo`) VALUES ('2','Cajero');
INSERT INTO `LBD202110`.`Cargos` (`IdCargo`, `Cargo`) VALUES ('3','Vendedor');
INSERT INTO `LBD202110`.`Cargos` (`IdCargo`, `Cargo`) VALUES ('4','Comprador');

-- Insert Empleados

INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('2', '3', 'nieto', md5('nieto'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('4', '3', 'blanco', md5('blanco'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('6', '3', 'romano', md5('romano'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('8', '3', 'pastrana', md5('pastrana'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('10', '4', 'cervino', md5('cervino'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('12', '4', 'odstrcil', md5('odstrcil'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('14', '4', 'alvarezgonzalez', md5('alvarezgonzalez'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('16', '4', 'campero', md5('campero'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('18', '2', 'farber', md5('farber'));
INSERT INTO `LBD202110`.`Empleados` (`IdEmpleado`, `IdCargo`, `Usuario`, `Contrasena`) VALUES ('20', '1', 'murcani', md5('murcani'));

-- Insert Proveedores
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('1','Jeff Bezos', 'DNI', '41344925', 'Albuquerque 175', '4225232', 'jeffbezos@amazon.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('2','Mark Zuckerberg', 'DNI', '41232592', 'Florida 225', '3815968', 'markz@facebook.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('3','Juan Roman Riquelme', 'DNI', '25285281', 'Brandsen 805', '4553818', 'jrr10@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('4','Carlos Alberto Solari', 'DNI', '20555939', '9 de Julio 229', '5492851', 'indiosolari@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('5','Franco Rinaldi', 'DNI', '46612342', 'Libertad 1010', '4221234', 'frankierinaldi@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('6','Enrique Bochini', 'DNI', '4222195', 'Avellaneda 1950', '381561230', 'bochabochini@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('7','Eduardo Federico Beilinson', 'DNI', '20564821', '9 de Julio 551', '3385718', 'skaybeilinson@hotmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('8','Sergio Dawi', 'DNI', '4112958', '25 de Mayo 991', '5129581', 'sergiodawi@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('9','Alberto Ángel Fernández', 'DNI', '41202191', 'Olivos 119', '4224443', 'albertof@argentina.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('10','Siemens', 'CUIT', '2044125102', 'Belgrano 221', '4128592', 'siemensargentina@siemens.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('11','Panasonic', 'CUIT', '2055125127', 'San Martin 229', '4129581', 'panasonicarg@panasonic.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('12','Sony', 'CUIT', '2058192852', 'Panamericana 1982', '4919286', 'sony@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('13','Ampere', 'CUIT', '2086719282', 'Ruben Dario 129', '381958182', 'ampereelectricidad@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('14','Silvia Oquendo', 'DNI', '28958291', 'Márquez Polígono 685', '4295928', 'silviao@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('15','Luisa Rolón', 'DNI', '29591820', 'Mate de Luna 222', '4829592', 'luisar@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('16','Sara Rosado', 'DNI', '40295928', 'Aconquija 220', '49201820', 'sarar@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('17','Guadalupe Cuellar', 'DNI', '25029020', 'Salas y Valdez 111', '4225019', 'guadac@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('18','Roberto Godoy', 'DNI', '4010295', '999', '4229105', 'robertog@gmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('19','General Electric', 'CUIT', '201299502', 'Monteagudo 555', '4220102', 'generalelectric@hotmail.com');
INSERT INTO `LBD202110`.`Proveedores` (`IdProveedor`, `RazonSocial`, `TipoDoc`, `NumDoc`, `Domicilio`, `Telefono`,`Email`) VALUES ('20','Hitachi', 'CUIT', '205558382', '24 de Septiembre 101', '42405019', 'hitachi@hitachi.com');

-- Insert Compras

INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('1', '10', '1', '123123');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('2', '12', '2', '34243');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('3', '14', '3', '6456');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('4', '16', '4', '43242');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('5', '10', '5', '425');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('6', '12', '6', '6436345');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('7', '14', '7', '423');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('8', '16', '8', '242');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('9', '10', '9', '4563');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('10', '12', '10', '94322834');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('11', '14', '11', '924234');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('12', '16', '12', '432834');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('13', '10', '13', '563434');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('14', '12', '14', '92321');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('15', '14', '15', '2344');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('16', '16', '16', '25234');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('17', '10', '17', '523534');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('18', '12', '18', '23534');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('19', '14', '19', '77454');
INSERT INTO `LBD202110`.`Compras` (`IdCompra`, `IdEmpleado`, `IdProveedor`, `NumFactura`) VALUES ('20', '16', '20', '3213');

-- Insert Ventas

INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`) VALUES ('1','2', '1');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('2','4', '1');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('3','6', '3');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('4','8', '5');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('5','2', '7');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('6','4', '9');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('7','6', '11');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('8','8', '13');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('9','2', '1');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('10','4', '3');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('11','6', '5');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('12','8', '7');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('13','2', '9');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('14','4', '13');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('15','6', '1');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('16','8', '3');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('17','2', '5');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('18','4', '7');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('19','6', '9');
INSERT INTO `LBD202110`.`Ventas` (`IdVenta`,`IdEmpleado`, `IdCliente`)  VALUES ('20','8', '11');

-- Insert Rubros

INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('1','Climatizacion');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('2','Iluminacion');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('3','Herramientas');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('4','Interruptores');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('5','Transformadores');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('6','Accesorios');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('7','Varios');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('8','Conductores');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('9','Automatizacion y control');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('10','Medicion');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('11','Proteccion');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('12','Canalizacion');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('13','Ferreteria');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('14','Pegamentos');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('15','Prolongadores');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('16','Pilas y baterias');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('17','Audio');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('18','Video');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('19','Comunicacion');
INSERT INTO `LBD202110`.`Rubros` (`IdRubro`,`Rubro`) VALUES ('20','Cableado');

-- Insert NombreProductos
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('1','Foco', '100');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('2','Lampara', '200');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('3','Disyuntor', '50');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('4','Bateria', '10');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('5','Cable unipolar', '1000');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('6','Transformador', '30');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('7','Luz de emergencia', '50');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('8','Cargador USB', '25');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('9','Cable espiral organizador', '100');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('10','Soporte LED', '40');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('11','Timbre inalambrico', '10');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('12','Tubo LED', '30');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('13','Cinta aisladora', '50');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('14','Portalamparas', '300');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('15','Sensor de movimiento', '150');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('16','Precintos', '500');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('17','Cable UTP', '800');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('18','Bobina', '150');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('19','UPS', '200');
INSERT INTO `LBD202110`.`NombreProductos` (`IdNombreProducto`,`NombreProducto`, `UmbralStock`) VALUES ('20','Estabilizador de tension', '100');

-- Insert Productos
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('1','2', '1', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('2','2', '2', 'Amarillo');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('3','2', '7', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('4','2', '12', 'Azul');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('5','16', '4', 'Azul');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('6','16', '8', 'Naranja');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('7','16', '19', 'Amarillo');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('8','11', '3', 'Naranja');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('9','11', '15', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('10','11', '20', 'Amarillo');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('11','5', '6', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('12','13', '13', 'Naranja');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('13','13', '16', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('14','20', '5', 'Azul');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('15','20', '17', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('16','8', '18', 'Amarillo');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('17','2', '14', 'Azul');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('18','7', '10', 'Azul');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('19','7', '11', 'Blanco');
INSERT INTO `LBD202110`.`Productos` (`IdProducto`, `IdRubro`, `IdNombreProducto`, `Color`) VALUES ('20','12', '9', 'Amarillo');

-- Insert LineasCompras
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('1', '1', '10', '1', '2', '1', '10', '50');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('2', '1', '10', '1', '2', '2', '20', '70');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('3', '1', '10', '1', '2', '3', '30', '90');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('4', '1', '10', '1', '2', '4', '40', '133');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('5', '2', '12', '2', '16', '5', '60', '3');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('6', '2', '12', '2', '16', '6', '70', '8');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('7', '2', '12', '2', '16', '7', '80', '30');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('8', '2', '12', '2', '11', '8', '90', '55');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('9', '3', '14', '3', '11', '9', '100', '234');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('10', '3', '14', '3', '11', '10', '110', '2');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('11', '3', '14', '3', '5', '11', '120', '8');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('12', '3', '14', '3', '13', '12', '130', '523');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('13', '4', '16', '4', '13', '13', '140', '865');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('14', '4', '16', '4', '20', '14', '150', '67');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('15', '4', '16', '4', '20', '15', '160', '345');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('16', '4', '16', '4', '8', '16', '170', '88');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('17', '5', '10', '5', '2', '17', '180', '455');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('18', '5', '10', '5', '7', '18', '190', '23');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('19', '5', '10', '5', '7', '19', '200', '3');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('20', '5', '10', '5', '12', '20', '210', '555');


-- Insert LineasVentas
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('1', '1', '2', '1', '2', '1', '20', '3');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('2', '1', '2', '1', '2', '2', '40', '20');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('3', '1', '2', '1', '2', '3', '60', '50');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('4', '1', '2', '1', '2', '4', '80', '100');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('5', '2', '4', '1', '16', '5', '100', '1');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('6', '2', '4', '1', '16', '6', '120', '5');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('7', '2', '4', '1', '16', '7', '140', '20');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('8', '2', '4', '1', '11', '8', '160', '40');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('9', '3', '6', '3', '11', '9', '180', '100');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('10', '3', '6', '3', '11', '10', '200', '1');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('11', '3', '6', '3', '5', '11', '220', '3');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('12', '3', '6', '3', '13', '12', '240', '200');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('13', '4', '8', '5', '13', '13', '260', '500');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('14', '4', '8', '5', '20', '14', '280', '20');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('15', '4', '8', '5', '20', '15', '300', '100');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('16', '4', '8', '5', '8', '16', '320', '10');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('17', '5', '2', '7', '2', '17', '340', '10');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('18', '5', '2', '7', '7', '18', '360', '10');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('19', '5', '2', '7', '7', '19', '380', '1');
INSERT INTO `LBD202110`.`LineasVentas` (`IdLineaVenta`, `IdVenta`, `IdEmpleado`, `IdCliente`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('20', '5', '2', '7', '12', '20', '400', '100');
