-- Creamos la BD
DROP DATABASE IF EXISTS Parcial2017;
CREATE DATABASE Parcial2017;
USE Parcial2017;

-- 
-- TABLE: Categorias 
--

CREATE TABLE Categorias(
    IdCategoria    INT            NOT NULL,
    Nombre         VARCHAR(50)    NOT NULL,
    PRIMARY KEY (IdCategoria), 
    UNIQUE INDEX UI_Nombre(Nombre)
)ENGINE=INNODB
;



-- 
-- TABLE: Clientes 
--

CREATE TABLE Clientes(
    IdCliente    INT            NOT NULL,
    Apellidos    VARCHAR(50)    NOT NULL,
    Nombres      VARCHAR(50)    NOT NULL,
    Telefono     VARCHAR(25)    NOT NULL,
    PRIMARY KEY (IdCliente), 
    UNIQUE INDEX UI_Telefono(Telefono)
)ENGINE=INNODB
;



-- 
-- TABLE: Productos 
--

CREATE TABLE Productos(
    IdProducto     INT               NOT NULL,
    Nombre         VARCHAR(50)       NOT NULL,
    Color          VARCHAR(15),
    Precio         DECIMAL(10, 4)    NOT NULL,
    IdCategoria    INT,
    PRIMARY KEY (IdProducto), 
    UNIQUE INDEX UI_Nombre(Nombre),
    INDEX Ref53(IdCategoria), 
    CONSTRAINT RefCategorias3 FOREIGN KEY (IdCategoria)
    REFERENCES Categorias(IdCategoria)
)ENGINE=INNODB
;



-- 
-- TABLE: Ofertas 
--

CREATE TABLE Ofertas(
    IdOferta          INT            NOT NULL,
    Descuento         FLOAT   DEFAULT 0.05 NOT NULL,
    FechaInicio       DATETIME       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FechaFin          DATETIME       NOT NULL,
    CantidadMinima    INT            DEFAULT 1 NOT NULL,
    CantidadMaxima    INT,
    PRIMARY KEY (IdOferta), 
    INDEX IX_FechaInicio(FechaInicio),
    INDEX IX_FechaFin(FechaFin),
    CONSTRAINT chk_1 CHECK (FechaFin > FechaInicio)
)ENGINE=INNODB
;



-- 
-- TABLE: OfertasDelProducto 
--

CREATE TABLE OfertasDelProducto(
    IdProducto    INT    NOT NULL,
    IdOferta      INT    NOT NULL,
    PRIMARY KEY (IdProducto, IdOferta), 
    INDEX Ref44(IdProducto),
    INDEX Ref85(IdOferta), 
    CONSTRAINT RefProductos4 FOREIGN KEY (IdProducto)
    REFERENCES Productos(IdProducto),
    CONSTRAINT RefOfertas5 FOREIGN KEY (IdOferta)
    REFERENCES Ofertas(IdOferta)
)ENGINE=INNODB
;



-- 
-- TABLE: Ventas 
--

CREATE TABLE Ventas(
    IdVenta      INT         NOT NULL,
    Fecha        DATETIME    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    IdCliente    INT         NOT NULL,
    PRIMARY KEY (IdVenta), 
    INDEX IX_Fecha(Fecha),
    INDEX Ref32(IdCliente), 
    CONSTRAINT RefClientes2 FOREIGN KEY (IdCliente)
    REFERENCES Clientes(IdCliente)
)ENGINE=INNODB
;



-- 
-- TABLE: Detalles 
--

CREATE TABLE Detalles(
    IdDetalle     INT               NOT NULL,
    IdVenta       INT               NOT NULL,
    IdProducto    INT               NOT NULL,
    Cantidad      INT               NOT NULL,
    Precio        DECIMAL(10, 4)    NOT NULL,
    Descuento     FLOAT      DEFAULT 0 NOT NULL,
    IdOferta      INT               NOT NULL,
    PRIMARY KEY (IdDetalle, IdVenta), 
    INDEX Ref76(IdProducto, IdOferta),
    INDEX Ref67(IdVenta), 
    CONSTRAINT RefOfertasDelProducto6 FOREIGN KEY (IdProducto, IdOferta)
    REFERENCES OfertasDelProducto(IdProducto, IdOferta),
    CONSTRAINT RefVentas7 FOREIGN KEY (IdVenta)
    REFERENCES Ventas(IdVenta)
)ENGINE=INNODB
;

-- Inserciones
insert into Categorias values(1, 'Mountain Bikes');
insert into Categorias values(2, 'Road Bikes');
insert into Categorias values(3, 'Touring Bikes');
insert into Categorias values(4, 'Handlebars');
insert into Categorias values(5, 'Bottom Brackets');
insert into Categorias values(6, 'Brakes');
insert into Categorias values(7, 'Chains');
insert into Categorias values(8, 'Cranksets');
insert into Categorias values(9, 'Derailleurs');
insert into Categorias values(10, 'Forks');
insert into Categorias values(11, 'Headsets');
insert into Categorias values(12, 'Mountain Frames');
insert into Categorias values(13, 'Pedals');
insert into Categorias values(14, 'Road Frames');
insert into Categorias values(15, 'Saddles');
insert into Categorias values(16, 'Touring Frames');
insert into Categorias values(17, 'Wheels');
insert into Categorias values(18, 'Bib-Shorts');
insert into Categorias values(19, 'Caps');
insert into Categorias values(20, 'Gloves');
insert into Categorias values(21, 'Jerseys');
insert into Categorias values(22, 'Shorts');
insert into Categorias values(23, 'Socks');
insert into Categorias values(24, 'Tights');
insert into Categorias values(25, 'Vests');
insert into Categorias values(26, 'Bike Racks');
insert into Categorias values(27, 'Bike Stands');
insert into Categorias values(28, 'Bottles and Cages');
insert into Categorias values(29, 'Cleaners');
insert into Categorias values(30, 'Fenders');
insert into Categorias values(31, 'Helmets');
insert into Categorias values(32, 'Hydration Packs');
insert into Categorias values(33, 'Lights');
insert into Categorias values(34, 'Locks');
insert into Categorias values(35, 'Panniers');
insert into Categorias values(36, 'Pumps');
insert into Categorias values(37, 'Tires and Tubes');

insert into Productos values(707, 'Sport-100 Helmet, Red', 'Red', 34.99, 31);
insert into Productos values(708, 'Sport-100 Helmet, Black', 'Black', 34.99, 31);
insert into Productos values(709, 'Mountain Bike Socks, M', 'White', 9.50, 23);
insert into Productos values(710, 'Mountain Bike Socks, L', 'White', 9.50, 23);
insert into Productos values(711, 'Sport-100 Helmet, Blue', 'Blue', 34.99, 31);
insert into Productos values(712, 'AWC Logo Cap', 'Multi', 8.99, 19);
insert into Productos values(713, 'Long-Sleeve Logo Jersey, S', 'Multi', 49.99, 21);
insert into Productos values(714, 'Long-Sleeve Logo Jersey, M', 'Multi', 49.99, 21);
insert into Productos values(715, 'Long-Sleeve Logo Jersey, L', 'Multi', 49.99, 21);
insert into Productos values(716, 'Long-Sleeve Logo Jersey, XL', 'Multi', 49.99, 21);
insert into Productos values(767, 'Road-650 Black, 62', 'Black', 782.99, 2);
insert into Productos values(768, 'Road-650 Black, 44', 'Black', 782.99, 2);
insert into Productos values(782, 'Mountain-200 Black, 38', 'Black', 2294.99, 1);
insert into Productos values(783, 'Mountain-200 Black, 42', 'Black', 2294.99, 1);
insert into Productos values(784, 'Mountain-200 Black, 46', 'Black', 2294.99, 1);
insert into Productos values(785, 'Mountain-300 Black, 38', 'Black', 1079.99, 1);
insert into Productos values(858, 'Half-Finger Gloves, S', 'Black', 24.49, 20);
insert into Productos values(859, 'Half-Finger Gloves, M', 'Black', 24.49, 20);
insert into Productos values(860, 'Half-Finger Gloves, L', 'Black', 24.49, 20);
insert into Productos values(861, 'Full-Finger Gloves, S', 'Black', 37.99, 20);
insert into Productos values(862, 'Full-Finger Gloves, M', 'Black', 37.99, 20);
insert into Productos values(863, 'Full-Finger Gloves, L', 'Black', 37.99, 20);
insert into Productos values(864, 'Classic Vest, S', 'Blue', 63.50, 25);
insert into Productos values(865, 'Classic Vest, M', 'Blue', 63.50, 25);
insert into Productos values(866, 'Classic Vest, L', 'Blue', 63.50, 25);
insert into Productos values(867, 'Women''s Mountain Shorts, S', 'Black', 69.99, 22);
insert into Productos values(868, 'Women''s Mountain Shorts, M', 'Black', 69.99, 22);
insert into Productos values(869, 'Women''s Mountain Shorts, L', 'Black', 69.99, 22);
insert into Productos values(870, 'Water Bottle - 30 oz.', NULL, 4.99, 28);
insert into Productos values(871, 'Mountain Bottle Cage', NULL, 9.99, 28);
insert into Productos values(872, 'Road Bottle Cage', NULL, 8.99, 28);
insert into Productos values(873, 'Patch Kit/8 Patches', NULL, 2.29, 37);
insert into Productos values(874, 'Racing Socks, M', 'White', 8.99, 23);
insert into Productos values(875, 'Racing Socks, L', 'White', 8.99, 23);
insert into Productos values(876, 'Hitch Rack - 4-Bike', NULL, 120.0, 26);
insert into Productos values(877, 'Bike Wash - Dissolver', NULL, 7.95, 29);
insert into Productos values(878, 'Fender Set - Mountain', NULL, 21.98, 30);
insert into Productos values(879, 'All-Purpose Bike Stand', NULL, 159.0, 27);
insert into Productos values(880, 'Hydration Pack - 70 oz.', 'Silver', 54.99, 32);
insert into Productos values(881, 'Short-Sleeve Classic Jersey, S', 'Yellow', 53.99, 21);
insert into Productos values(882, 'Short-Sleeve Classic Jersey, M', 'Yellow', 53.99, 21);
insert into Productos values(883, 'Short-Sleeve Classic Jersey, L', 'Yellow', 53.99, 21);
insert into Productos values(884, 'Short-Sleeve Classic Jersey, XL', 'Yellow', 53.99, 21);
insert into Productos values(921, 'Mountain Tire Tube', NULL, 4.99, 37);
insert into Productos values(922, 'Road Tire Tube', NULL, 3.99, 37);
insert into Productos values(923, 'Touring Tire Tube', NULL, 4.99, 37);
insert into Productos values(924, 'LL Mountain Frame - Black, 42', 'Black', 249.79, 12);
insert into Productos values(925, 'LL Mountain Frame - Black, 44', 'Black', 249.79, 12);
insert into Productos values(926, 'LL Mountain Frame - Black, 48', 'Black', 249.79, 12);
insert into Productos values(927, 'LL Mountain Frame - Black, 52', 'Black', 249.79, 12);
insert into Productos values(928, 'LL Mountain Tire', NULL, 24.99, 37);
insert into Productos values(929, 'ML Mountain Tire', NULL, 29.99, 37);
insert into Productos values(930, 'HL Mountain Tire', NULL, 35.0, 37);
insert into Productos values(967, 'Touring-1000 Blue, 50', 'Blue', 2384.7, 3);
insert into Productos values(982, 'Mountain-400-W Silver, 42', 'Silver', 769.49, 1);
insert into Productos values(983, 'Mountain-400-W Silver, 46', 'Silver', 769.49, 1);
insert into Productos values(984, 'Mountain-500 Silver, 40', 'Silver', 564.99, 1);
insert into Productos values(985, 'Mountain-500 Silver, 42', 'Silver', 564.99, 1);
insert into Productos values(986, 'Mountain-500 Silver, 44', 'Silver', 564.99, 1);
insert into Productos values(987, 'Mountain-500 Silver, 48', 'Silver', 564.99, 1);
insert into Productos values(988, 'Mountain-500 Silver, 52', 'Silver', 564.99, 1);
insert into Productos values(989, 'Mountain-500 Black, 40', 'Black', 539.99, 1);

insert into Ofertas values(1, 0.0, '2005-06-01 00:00:00.000', '2008-12-31 00:00:00.000', 0, NULL);
insert into Ofertas values(2, 0.2, '2005-07-01 00:00:00.000', '2008-06-30 00:00:00.000', 11, 14);
insert into Ofertas values(3, 0.5, '2005-07-01 00:00:00.000', '2008-06-30 00:00:00.000', 15, 24);
insert into Ofertas values(4, 0.10, '2005-07-01 00:00:00.000', '2008-06-30 00:00:00.000', 25, 40);
insert into Ofertas values(5, 0.15, '2005-07-01 00:00:00.000', '2008-06-30 00:00:00.000', 41, 60);
insert into Ofertas values(6, 0.20, '2005-07-01 00:00:00.000', '2008-06-30 00:00:00.000', 61, NULL);
insert into Ofertas values(7, 0.35, '2006-05-15 00:00:00.000', '2006-06-30 00:00:00.000', 0, NULL);
insert into Ofertas values(8, 0.10, '2006-07-01 00:00:00.000', '2006-07-31 00:00:00.000', 0, NULL);
insert into Ofertas values(9, 0.30, '2006-07-01 00:00:00.000', '2006-08-31 00:00:00.000', 0, NULL);
insert into Ofertas values(10, 0.50, '2007-06-15 00:00:00.000', '2007-08-30 00:00:00.000', 0, NULL);
insert into Ofertas values(11, 0.15, '2007-07-01 00:00:00.000', '2007-07-31 00:00:00.000', 0, NULL);
insert into Ofertas values(12, 0.35, '2007-07-01 00:00:00.000', '2007-08-15 00:00:00.000', 0, NULL);
insert into Ofertas values(13, 0.15, '2007-07-01 00:00:00.000', '2007-09-30 00:00:00.000', 0, NULL);
insert into Ofertas values(14, 0.20, '2007-07-01 00:00:00.000', '2007-09-30 00:00:00.000', 0, NULL);
insert into Ofertas values(15, 0.50, '2007-08-15 00:00:00.000', '2007-09-15 00:00:00.000', 0, NULL);
insert into Ofertas values(16, 0.40, '2008-05-01 00:00:00.000', '2008-06-30 00:00:00.000', 0, NULL);

insert into OfertasDelProducto values(707, 1);
insert into OfertasDelProducto values(707, 2);
insert into OfertasDelProducto values(707, 3);
insert into OfertasDelProducto values(707, 8);
insert into OfertasDelProducto values(707, 11);
insert into OfertasDelProducto values(708, 1);
insert into OfertasDelProducto values(708, 2);
insert into OfertasDelProducto values(708, 3);
insert into OfertasDelProducto values(708, 8);
insert into OfertasDelProducto values(708, 11);
insert into OfertasDelProducto values(711, 1);
insert into OfertasDelProducto values(711, 2);
insert into OfertasDelProducto values(711, 3);
insert into OfertasDelProducto values(711, 8);
insert into OfertasDelProducto values(711, 11);
insert into OfertasDelProducto values(712, 1);
insert into OfertasDelProducto values(712, 2);
insert into OfertasDelProducto values(712, 3);
insert into OfertasDelProducto values(712, 4);
insert into OfertasDelProducto values(715, 1);
insert into OfertasDelProducto values(715, 2);
insert into OfertasDelProducto values(715, 3);
insert into OfertasDelProducto values(715, 4);
insert into OfertasDelProducto values(716, 1);
insert into OfertasDelProducto values(716, 2);
insert into OfertasDelProducto values(767, 1);
insert into OfertasDelProducto values(782, 1);
insert into OfertasDelProducto values(782, 2);
insert into OfertasDelProducto values(782, 3);
insert into OfertasDelProducto values(782, 16);
insert into OfertasDelProducto values(783, 1);
insert into OfertasDelProducto values(783, 2);
insert into OfertasDelProducto values(783, 3);
insert into OfertasDelProducto values(784, 1);
insert into OfertasDelProducto values(784, 2);
insert into OfertasDelProducto values(784, 16);
insert into OfertasDelProducto values(858, 1);
insert into OfertasDelProducto values(858, 2);
insert into OfertasDelProducto values(858, 3);
insert into OfertasDelProducto values(868, 1);
insert into OfertasDelProducto values(870, 1);
insert into OfertasDelProducto values(870, 2);
insert into OfertasDelProducto values(870, 3);
insert into OfertasDelProducto values(870, 4);
insert into OfertasDelProducto values(871, 1);
insert into OfertasDelProducto values(872, 1);
insert into OfertasDelProducto values(873, 1);
insert into OfertasDelProducto values(873, 2);
insert into OfertasDelProducto values(878, 1);
insert into OfertasDelProducto values(880, 1);
insert into OfertasDelProducto values(880, 2);
insert into OfertasDelProducto values(880, 3);
insert into OfertasDelProducto values(882, 1);
insert into OfertasDelProducto values(884, 1);
insert into OfertasDelProducto values(884, 2);
insert into OfertasDelProducto values(884, 3);
insert into OfertasDelProducto values(884, 4);
insert into OfertasDelProducto values(921, 1);
insert into OfertasDelProducto values(928, 1);
insert into OfertasDelProducto values(928, 10);
insert into OfertasDelProducto values(930, 1);
insert into OfertasDelProducto values(930, 10);
insert into OfertasDelProducto values(967, 1);
insert into OfertasDelProducto values(982, 1);
insert into OfertasDelProducto values(989, 1);

insert into Clientes values(11037, 'Gomez', 'Joe', '1 (11); 500 555-0116');
insert into Clientes values(11132, 'Anderson', 'Kaitlyn', '1 (11); 500 555-0171');
insert into Clientes values(11340, 'Huang', 'Christy', '454-555-0161');
insert into Clientes values(11793, 'Johnson', 'Victoria', '958-555-0186');
insert into Clientes values(13789, 'Washington', 'Richard', '696-555-0112');
insert into Clientes values(13980, 'Foster', 'Seth', '1 (11); 500 555-0159');
insert into Clientes values(13981, 'Jimenez', 'Joy', '1 (11); 500 555-0145');
insert into Clientes values(13982, 'Gutierrez', 'Joanna', '984-555-0124');
insert into Clientes values(14501, 'Gray', 'Bryan', '178-555-0147');
insert into Clientes values(15614, 'Sanz', 'Ricky', '1 (11); 500 555-0112');
insert into Clientes values(15678, 'Gomez', 'Marc', '1 (11); 500 555-0120');
insert into Clientes values(16916, 'Nara', 'Jerry', '1 (11); 500 555-0190');
insert into Clientes values(16958, 'Shan', 'Carl', '1 (11); 500 555-0178');
insert into Clientes values(18690, 'Diaz', 'Erika', '1 (11); 500 555-0124');
insert into Clientes values(20046, 'Mehta', 'Donald', '1 (11); 500 555-0174');

insert into Ventas values(43700, '2005-07-01 00:00:00.000', 14501);
insert into Ventas values(51262, '2007-07-06 00:00:00.000', 11340);
insert into Ventas values(51340, '2007-07-11 00:00:00.000', 13789);
insert into Ventas values(51555, '2007-07-24 00:00:00.000', 11037);
insert into Ventas values(52524, '2007-08-14 00:00:00.000', 11793);
insert into Ventas values(52607, '2007-08-15 00:00:00.000', 16958);
insert into Ventas values(55957, '2007-10-11 00:00:00.000', 11132);
insert into Ventas values(56575, '2007-10-23 00:00:00.000', 13980);
insert into Ventas values(58845, '2007-11-30 00:00:00.000', 20046);
insert into Ventas values(67959, '2008-04-09 00:00:00.000', 15678);
insert into Ventas values(68573, '2008-04-19 00:00:00.000', 18690);
insert into Ventas values(70092, '2008-05-08 00:00:00.000', 13982);
insert into Ventas values(70714, '2008-05-16 00:00:00.000', 16916);
insert into Ventas values(72656, '2008-06-11 00:00:00.000', 15614);

insert into Detalles values(356, 43700, 767, 1, 699.982, 0.0, 1);
insert into Detalles values(37985, 51262, 782, 1, 2294.99, 0.0, 1);
insert into Detalles values(37986, 51262, 871, 1, 9.99, 0.0, 1);
insert into Detalles values(37987, 51262, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(37988, 51262, 884, 1, 53.99, 0.0, 1);
insert into Detalles values(38193, 51340, 982, 1, 769.49, 0.0, 1);
insert into Detalles values(38194, 51340, 715, 1, 49.99, 0.0, 1);
insert into Detalles values(38803, 51555, 783, 1, 2294.99, 0.0, 1);
insert into Detalles values(38804, 51555, 930, 1, 35.0, 0.0, 1);
insert into Detalles values(38805, 51555, 921, 1, 4.99, 0.0, 1);
insert into Detalles values(38806, 51555, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(38807, 51555, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(38808, 51555, 871, 1, 9.99, 0.0, 1);
insert into Detalles values(38809, 51555, 873, 1, 2.29, 0.0, 2);
insert into Detalles values(44505, 52524, 708, 1, 34.99, 0.0, 1);
insert into Detalles values(44697, 52607, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(44698, 52607, 707, 1, 34.99, 0.0, 1);
insert into Detalles values(44699, 52607, 858, 1, 24.49, 0.0, 1);
insert into Detalles values(57772, 55957, 783, 1, 2294.99, 0.0, 1);
insert into Detalles values(57773, 55957, 921, 1, 4.99, 0.0, 1);
insert into Detalles values(57774, 55957, 930, 1, 35.0, 0.0, 1);
insert into Detalles values(57775, 55957, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(57776, 55957, 871, 1, 9.99, 0.0, 1);
insert into Detalles values(57777, 55957, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(59315, 56575, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(59316, 56575, 711, 1, 34.99, 0.0, 1);
insert into Detalles values(67299, 58845, 989, 1, 539.99, 0.0, 1);
insert into Detalles values(67300, 58845, 928, 1, 24.99, 0.0, 1);
insert into Detalles values(67301, 58845, 921, 1, 4.99, 0.0, 1);
insert into Detalles values(67302, 58845, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(67303, 58845, 871, 1, 9.99, 0.0, 1);
insert into Detalles values(67304, 58845, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(67305, 58845, 708, 1, 34.99, 0.0, 1);
insert into Detalles values(67306, 58845, 716, 1, 49.99, 0.0, 1);
insert into Detalles values(98611, 67959, 967, 1, 2384.7, 0.0, 1);
insert into Detalles values(98612, 67959, 872, 1, 8.99, 0.0, 1);
insert into Detalles values(98613, 67959, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(98614, 67959, 712, 1, 8.99, 0.0, 1);
insert into Detalles values(98615, 67959, 882, 1, 53.99, 0.0, 1);
insert into Detalles values(100143, 68573, 868, 1, 69.99, 0.0, 1);
insert into Detalles values(100144, 68573, 716, 1, 49.99, 0.0, 1);
insert into Detalles values(106361, 70092, 928, 1, 24.99, 0.0, 1);
insert into Detalles values(107915, 70714, 782, 1, 2294.99, 0.0, 1);
insert into Detalles values(107916, 70714, 930, 1, 35.0, 0.0, 1);
insert into Detalles values(107917, 70714, 921, 1, 4.99, 0.0, 1);
insert into Detalles values(107918, 70714, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(107919, 70714, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(107920, 70714, 871, 1, 9.99, 0.0, 1);
insert into Detalles values(107921, 70714, 884, 1, 53.99, 0.0, 1);
insert into Detalles values(107922, 70714, 712, 1, 8.99, 0.0, 1);
insert into Detalles values(115359, 72656, 784, 1, 2294.99, 0.0, 1);
insert into Detalles values(115360, 72656, 878, 1, 21.98, 0.0, 1);
insert into Detalles values(115361, 72656, 871, 1, 9.99, 0.0, 1);
insert into Detalles values(115362, 72656, 870, 1, 4.99, 0.0, 1);
insert into Detalles values(115363, 72656, 880, 1, 54.99, 0.0, 1);
insert into Detalles values(115364, 72656, 708, 1, 34.99, 0.0, 1);
insert into Detalles values(115365, 72656, 716, 1, 49.99, 0.0, 1);
insert into Detalles values(115366, 72656, 712, 1, 8.99, 0.0, 1);

-- Creamos VTotalVentas
DROP VIEW IF EXISTS vAux;
CREATE VIEW vAux AS
SELECT ven.IdVenta, ven.Fecha, cli.Apellidos, cli.Nombres, pro.Nombre AS Producto, 
		CASE pro.IdCategoria
			WHEN pro.IdCategoria IS NULL THEN "S/C"
			ELSE cat.Nombre
		END AS 'Categoria', det.Cantidad, det.Precio
FROM Ventas ven 
INNER JOIN Detalles det ON ven.IdVenta = det.IdVenta
INNER JOIN Clientes cli ON ven.IdCliente = cli.IdCliente
INNER JOIN OfertasDelProducto odp ON det.IdProducto = odp.IdProducto
INNER JOIN Productos pro ON odp.IdProducto = pro.IdProducto
INNER JOIN Categorias cat ON pro.IdCategoria = cat.IdCategoria;

DROP VIEW IF EXISTS VTotalVentas;
CREATE VIEW VTotalVentas AS
SELECT * FROM vAux
UNION
SELECT NULL, NULL, NULL, NULL, NULL, NULL, NULL,SUM(Cantidad * Precio) AS Total FROM vAux;

SELECT * FROM VTotalVentas;