-- Año: 2021 
-- Grupo Nro: 10
-- Integrantes: Romano, Hugo Leandro - Farber, Juan.  
-- Tema: Compra y venta de materiales eléctricos.
-- Nombre del Esquema: LBD202110
-- Plataforma (SO + Versión): Windows 10 Home Version 20H2 - Ubuntu 20.04.2 LTS (Focal Fossa)
-- Motor y Versión: 8.0.23 for Windows on x86_64 (MySQL Community Server - GPL) - 8.0.23 for Linux on x86_64 (MySQL Community Server - GPL)
-- GitHub Repositorio: LBD2021G10
-- GitHub Usuario: leoromano98, Farber98

-- Trabajo Practico Nº2
USE LBD202110;

-- Modificacion datos para consulta 2 
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2016-10-30 20:12:30' WHERE (`IdVenta` = '5') and (`IdEmpleado` = '2') and (`IdCliente` = '7');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-01-03 16:45:20' WHERE (`IdVenta` = '12') and (`IdEmpleado` = '8') and (`IdCliente` = '7');

-- Modificacion datos para consulta 3
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '10' WHERE (`IdLineaVenta` = '1') and (`IdVenta` = '1') and (`IdEmpleado` = '2') and (`IdCliente` = '1') and (`IdRubro` = '2') and (`IdProducto` = '1');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '20' WHERE (`IdLineaVenta` = '2') and (`IdVenta` = '1') and (`IdEmpleado` = '2') and (`IdCliente` = '1') and (`IdRubro` = '2') and (`IdProducto` = '2');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '30' WHERE (`IdLineaVenta` = '3') and (`IdVenta` = '1') and (`IdEmpleado` = '2') and (`IdCliente` = '1') and (`IdRubro` = '2') and (`IdProducto` = '3');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '40' WHERE (`IdLineaVenta` = '4') and (`IdVenta` = '1') and (`IdEmpleado` = '2') and (`IdCliente` = '1') and (`IdRubro` = '2') and (`IdProducto` = '4');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '20' WHERE (`IdLineaVenta` = '5') and (`IdVenta` = '2') and (`IdEmpleado` = '4') and (`IdCliente` = '1') and (`IdRubro` = '16') and (`IdProducto` = '5');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '40' WHERE (`IdLineaVenta` = '6') and (`IdVenta` = '2') and (`IdEmpleado` = '4') and (`IdCliente` = '1') and (`IdRubro` = '16') and (`IdProducto` = '6');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '14' WHERE (`IdLineaVenta` = '7') and (`IdVenta` = '2') and (`IdEmpleado` = '4') and (`IdCliente` = '1') and (`IdRubro` = '16') and (`IdProducto` = '7');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '54' WHERE (`IdLineaVenta` = '8') and (`IdVenta` = '2') and (`IdEmpleado` = '4') and (`IdCliente` = '1') and (`IdRubro` = '11') and (`IdProducto` = '8');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '70' WHERE (`IdLineaVenta` = '9') and (`IdVenta` = '3') and (`IdEmpleado` = '6') and (`IdCliente` = '3') and (`IdRubro` = '11') and (`IdProducto` = '9');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '23' WHERE (`IdLineaVenta` = '10') and (`IdVenta` = '3') and (`IdEmpleado` = '6') and (`IdCliente` = '3') and (`IdRubro` = '11') and (`IdProducto` = '10');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '93' WHERE (`IdLineaVenta` = '11') and (`IdVenta` = '3') and (`IdEmpleado` = '6') and (`IdCliente` = '3') and (`IdRubro` = '5') and (`IdProducto` = '11');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '101' WHERE (`IdLineaVenta` = '12') and (`IdVenta` = '3') and (`IdEmpleado` = '6') and (`IdCliente` = '3') and (`IdRubro` = '13') and (`IdProducto` = '12');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '34' WHERE (`IdLineaVenta` = '13') and (`IdVenta` = '4') and (`IdEmpleado` = '8') and (`IdCliente` = '5') and (`IdRubro` = '13') and (`IdProducto` = '13');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '133' WHERE (`IdLineaVenta` = '14') and (`IdVenta` = '4') and (`IdEmpleado` = '8') and (`IdCliente` = '5') and (`IdRubro` = '20') and (`IdProducto` = '14');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '101' WHERE (`IdLineaVenta` = '15') and (`IdVenta` = '4') and (`IdEmpleado` = '8') and (`IdCliente` = '5') and (`IdRubro` = '20') and (`IdProducto` = '15');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '150' WHERE (`IdLineaVenta` = '16') and (`IdVenta` = '4') and (`IdEmpleado` = '8') and (`IdCliente` = '5') and (`IdRubro` = '8') and (`IdProducto` = '16');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '180' WHERE (`IdLineaVenta` = '17') and (`IdVenta` = '5') and (`IdEmpleado` = '2') and (`IdCliente` = '7') and (`IdRubro` = '2') and (`IdProducto` = '17');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '109' WHERE (`IdLineaVenta` = '18') and (`IdVenta` = '5') and (`IdEmpleado` = '2') and (`IdCliente` = '7') and (`IdRubro` = '7') and (`IdProducto` = '18');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '95' WHERE (`IdLineaVenta` = '19') and (`IdVenta` = '5') and (`IdEmpleado` = '2') and (`IdCliente` = '7') and (`IdRubro` = '7') and (`IdProducto` = '19');
UPDATE `LBD202110`.`LineasVentas` SET `Cantidad` = '101' WHERE (`IdLineaVenta` = '20') and (`IdVenta` = '5') and (`IdEmpleado` = '2') and (`IdCliente` = '7') and (`IdRubro` = '12') and (`IdProducto` = '20');

UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2015-09-10 20:10:10' WHERE (`IdCompra` = '1') and (`IdEmpleado` = '10') and (`IdProveedor` = '1');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2011-03-19 14:50:10' WHERE (`IdCompra` = '2') and (`IdEmpleado` = '12') and (`IdProveedor` = '2');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2014-09-30 10:30:10' WHERE (`IdCompra` = '3') and (`IdEmpleado` = '14') and (`IdProveedor` = '3');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2010-09-25 09:20:11' WHERE (`IdCompra` = '4') and (`IdEmpleado` = '16') and (`IdProveedor` = '4');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2013-03-25 14:10:30' WHERE (`IdCompra` = '5') and (`IdEmpleado` = '10') and (`IdProveedor` = '5');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2012-09-30 09:30:25' WHERE (`IdCompra` = '6') and (`IdEmpleado` = '12') and (`IdProveedor` = '6');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2009-10-20 12:58:24' WHERE (`IdCompra` = '7') and (`IdEmpleado` = '14') and (`IdProveedor` = '7');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2012-06-15 08:38:24' WHERE (`IdCompra` = '8') and (`IdEmpleado` = '16') and (`IdProveedor` = '8');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2001-02-25 17:10:24' WHERE (`IdCompra` = '9') and (`IdEmpleado` = '10') and (`IdProveedor` = '9');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2002-10-15 10:11:12' WHERE (`IdCompra` = '10') and (`IdEmpleado` = '12') and (`IdProveedor` = '10');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2011-05-21 08:38:24' WHERE (`IdCompra` = '11') and (`IdEmpleado` = '14') and (`IdProveedor` = '11');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2012-05-21 09:38:24' WHERE (`IdCompra` = '12') and (`IdEmpleado` = '16') and (`IdProveedor` = '12');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2013-05-21 10:12:24' WHERE (`IdCompra` = '13') and (`IdEmpleado` = '10') and (`IdProveedor` = '13');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2014-05-21 12:00:24' WHERE (`IdCompra` = '14') and (`IdEmpleado` = '12') and (`IdProveedor` = '14');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2015-05-21 11:58:24' WHERE (`IdCompra` = '15') and (`IdEmpleado` = '14') and (`IdProveedor` = '15');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2003-05-21 16:48:24' WHERE (`IdCompra` = '16') and (`IdEmpleado` = '16') and (`IdProveedor` = '16');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2004-05-21 13:38:24' WHERE (`IdCompra` = '17') and (`IdEmpleado` = '10') and (`IdProveedor` = '17');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2005-05-21 14:28:24' WHERE (`IdCompra` = '18') and (`IdEmpleado` = '12') and (`IdProveedor` = '18');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2006-05-21 15:18:24' WHERE (`IdCompra` = '19') and (`IdEmpleado` = '14') and (`IdProveedor` = '19');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2007-05-21 16:08:24' WHERE (`IdCompra` = '20') and (`IdEmpleado` = '16') and (`IdProveedor` = '20');

UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2016-03-19 12:38:24' WHERE (`IdVenta` = '1') and (`IdEmpleado` = '2') and (`IdCliente` = '1');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2017-04-30 12:38:24' WHERE (`IdVenta` = '2') and (`IdEmpleado` = '4') and (`IdCliente` = '1');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2018-05-31 12:38:24' WHERE (`IdVenta` = '3') and (`IdEmpleado` = '6') and (`IdCliente` = '3');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-06-19 12:38:24' WHERE (`IdVenta` = '4') and (`IdEmpleado` = '8') and (`IdCliente` = '5');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-06-10 12:38:24' WHERE (`IdVenta` = '6') and (`IdEmpleado` = '4') and (`IdCliente` = '9');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-02-14 12:38:24' WHERE (`IdVenta` = '8') and (`IdEmpleado` = '8') and (`IdCliente` = '13');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-03-10 12:38:24' WHERE (`IdVenta` = '9') and (`IdEmpleado` = '2') and (`IdCliente` = '1');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2018-04-19 12:38:24' WHERE (`IdVenta` = '10') and (`IdEmpleado` = '4') and (`IdCliente` = '3');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2017-06-13 12:38:24' WHERE (`IdVenta` = '11') and (`IdEmpleado` = '6') and (`IdCliente` = '5');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2016-03-13 12:38:24' WHERE (`IdVenta` = '13') and (`IdEmpleado` = '2') and (`IdCliente` = '9');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-02-15 12:38:24' WHERE (`IdVenta` = '14') and (`IdEmpleado` = '4') and (`IdCliente` = '13');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-01-20 12:38:24' WHERE (`IdVenta` = '15') and (`IdEmpleado` = '6') and (`IdCliente` = '1');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-05-21 12:38:24' WHERE (`IdVenta` = '16') and (`IdEmpleado` = '8') and (`IdCliente` = '3');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2018-05-21 12:38:24' WHERE (`IdVenta` = '17') and (`IdEmpleado` = '2') and (`IdCliente` = '5');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2017-05-21 12:38:24' WHERE (`IdVenta` = '18') and (`IdEmpleado` = '4') and (`IdCliente` = '7');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-10-21 12:38:24' WHERE (`IdVenta` = '19') and (`IdEmpleado` = '6') and (`IdCliente` = '9');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-05-21 12:38:24' WHERE (`IdVenta` = '20') and (`IdEmpleado` = '8') and (`IdCliente` = '11');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2021-05-10 12:38:24' WHERE (`IdVenta` = '7') and (`IdEmpleado` = '6') and (`IdCliente` = '11');
UPDATE `LBD202110`.`Rubros` SET `Estado` = 'I' WHERE (`IdRubro` = '2');

-- Modificacion de datos consulta 4.
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2012-01-30 09:30:25' WHERE (`IdCompra` = '6') and (`IdEmpleado` = '12') and (`IdProveedor` = '6');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2009-02-20 12:58:24' WHERE (`IdCompra` = '7') and (`IdEmpleado` = '14') and (`IdProveedor` = '7');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2012-04-15 08:38:24' WHERE (`IdCompra` = '8') and (`IdEmpleado` = '16') and (`IdProveedor` = '8');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2001-06-25 17:10:24' WHERE (`IdCompra` = '9') and (`IdEmpleado` = '10') and (`IdProveedor` = '9');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2002-07-15 10:11:12' WHERE (`IdCompra` = '10') and (`IdEmpleado` = '12') and (`IdProveedor` = '10');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2011-08-21 08:38:24' WHERE (`IdCompra` = '11') and (`IdEmpleado` = '14') and (`IdProveedor` = '11');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2012-09-21 09:38:24' WHERE (`IdCompra` = '12') and (`IdEmpleado` = '16') and (`IdProveedor` = '12');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2013-10-21 10:12:24' WHERE (`IdCompra` = '13') and (`IdEmpleado` = '10') and (`IdProveedor` = '13');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2014-11-21 12:00:24' WHERE (`IdCompra` = '14') and (`IdEmpleado` = '12') and (`IdProveedor` = '14');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2015-12-21 11:58:24' WHERE (`IdCompra` = '15') and (`IdEmpleado` = '14') and (`IdProveedor` = '15');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2003-09-21 16:48:24' WHERE (`IdCompra` = '16') and (`IdEmpleado` = '16') and (`IdProveedor` = '16');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2004-02-21 13:38:24' WHERE (`IdCompra` = '17') and (`IdEmpleado` = '10') and (`IdProveedor` = '17');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2005-07-21 14:28:24' WHERE (`IdCompra` = '18') and (`IdEmpleado` = '12') and (`IdProveedor` = '18');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2006-05-21 15:18:24' WHERE (`IdCompra` = '19') and (`IdEmpleado` = '14') and (`IdProveedor` = '19');
UPDATE `LBD202110`.`Compras` SET `FechaCompra` = '2007-01-21 16:08:24' WHERE (`IdCompra` = '20') and (`IdEmpleado` = '16') and (`IdProveedor` = '20');

UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-01-10 12:38:24' WHERE (`IdVenta` = '6') and (`IdEmpleado` = '4') and (`IdCliente` = '9');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2021-02-10 12:38:24' WHERE (`IdVenta` = '7') and (`IdEmpleado` = '6') and (`IdCliente` = '11');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-03-14 12:38:24' WHERE (`IdVenta` = '8') and (`IdEmpleado` = '8') and (`IdCliente` = '13');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2017-05-13 12:38:24' WHERE (`IdVenta` = '11') and (`IdEmpleado` = '6') and (`IdCliente` = '5');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-07-03 16:45:20' WHERE (`IdVenta` = '12') and (`IdEmpleado` = '8') and (`IdCliente` = '7');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2016-08-13 12:38:24' WHERE (`IdVenta` = '13') and (`IdEmpleado` = '2') and (`IdCliente` = '9');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-09-15 12:38:24' WHERE (`IdVenta` = '14') and (`IdEmpleado` = '4') and (`IdCliente` = '13');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2020-10-20 12:38:24' WHERE (`IdVenta` = '15') and (`IdEmpleado` = '6') and (`IdCliente` = '1');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2019-11-21 12:38:24' WHERE (`IdVenta` = '16') and (`IdEmpleado` = '8') and (`IdCliente` = '3');
UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2018-12-21 12:38:24' WHERE (`IdVenta` = '17') and (`IdEmpleado` = '2') and (`IdCliente` = '5');

UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2014-09-19 12:38:24' WHERE (`IdVenta` = '4') and (`IdEmpleado` = '8') and (`IdCliente` = '5');

UPDATE `LBD202110`.`Ventas` SET `FechaVenta` = '2015-09-19 12:38:24' WHERE (`IdVenta` = '1') and (`IdEmpleado` = '2') and (`IdCliente` = '1');

-- Modificaciones de datos punto 9
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('21', '1', '10', '1', '2', '1', '30', '25.00');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('22', '2', '12', '2', '16', '5', '20', '17.00');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('23', '3', '14', '3', '11', '9', '10', '7.00');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('24', '4', '16', '4', '13', '13', '10', '3.00');
INSERT INTO `LBD202110`.`LineasCompras` (`IdLineaCompra`, `IdCompra`, `IdEmpleado`, `IdProveedor`, `IdRubro`, `IdProducto`, `Cantidad`, `Precio`) VALUES ('25', '5', '10', '5', '7', '18', '20', '23.00');

-- Consultas
-- 1. Realizar un listado de productos ordenados por nombre alfabéticamente. Mostrar el
-- nombre del producto, color y nombre del rubro al que pertenece.

SELECT  np.IdNombreProducto, np.NombreProducto, p.Color, r.IdRubro, r.Rubro 
FROM NombreProductos np INNER JOIN Productos p ON np.IdNombreProducto = p.IdNombreProducto
INNER JOIN Rubros r ON p.IdRubro = r.IdRubro
ORDER BY np.NombreProducto;

-- 2. Dado un cliente, listar el detalle de sus ventas entre un rango de fechas. Mostrar la fecha,
-- nombre del producto, cantidad, precio y cantidad x precio.

SELECT c.IdCliente, lv.IdLineaVenta, pe.Apellidos AS 'Apellidos', pe.Nombres AS 'Nombres', 
v.IdVenta AS 'N° de factura', v.FechaVenta AS 'Fecha',
np.NombreProducto AS 'Producto', lv.Cantidad, lv.Precio AS 'Precio unitario',
lv.Cantidad * lv.Precio AS 'Importe'
FROM Personas pe INNER JOIN Clientes c ON pe.IdPersona = c.IdCliente
INNER JOIN Ventas v ON c.IdCliente = v.IdCliente
INNER JOIN LineasVentas lv ON v.IdVenta = lv.IdVenta AND v.IdEmpleado = lv.IdEmpleado AND v.IdCliente = lv.IdCliente
INNER JOIN Productos pr ON lv.IdRubro = pr.IdRubro AND lv.IdProducto = pr.IdProducto
INNER JOIN NombreProductos np ON pr.IdNombreProducto = np.IdNombreProducto
WHERE (c.IdCliente = 7 AND (v.FechaVenta BETWEEN '2016-01-30 14:15:55' AND NOW()))
ORDER BY pe.Apellidos, pe.Nombres, v.IdVenta, v.FechaVenta;

-- 3. Mostrar la diferencia entre el total de cantidad de productos comprados y el total de
-- productos vendidos de los rubros activos entre un rango de fechas.

SELECT np.NombreProducto AS 'Producto', IFNULL(SUM(lv.Cantidad),0) AS 'Cantidad'
FROM NombreProductos np
INNER JOIN Productos p ON np.IdNombreProducto = p.IdNombreProducto 
INNER JOIN Rubros r ON p.IdRubro = r.IdRubro
LEFT JOIN LineasVentas lv ON p.IdProducto = lv.IdProducto AND p.IdRubro = lv.IdRubro
LEFT JOIN Ventas v ON lv.IdVenta = v.IdVenta AND lv.IdEmpleado = v.IdEmpleado AND lv.IdCliente = v.IdCliente
WHERE (r.Estado = 'A' AND (v.FechaVenta BETWEEN '2000-01-30 14:15:55' AND NOW()))
GROUP BY np.NombreProducto
ORDER BY Cantidad DESC, Producto ASC;

-- 4. Dado un rango de fechas, mostrar mes a mes el total de lo pagado en compras y el total
-- de lo recaudado en ventas. El formato deberá ser: mes, total de compras, total de ventas.

DROP TABLE IF EXISTS Balance;
CREATE TEMPORARY TABLE Balance(
	`Anio` INT NOT NULL,
    `Mes` VARCHAR(10) NOT NULL,
    `Comprado` DECIMAL(10,2) NOT NULL DEFAULT 0,
    `Vendido` DECIMAL (10,2) NOT NULL DEFAULT 0)
ENGINE = InnoDB;

INSERT INTO Balance(Anio, Mes, Comprado)
SELECT year(c.FechaCompra)AS Año, 
CASE month(c.FechaCompra) 
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
 END Mes, 
IFNULL(SUM(lc.Cantidad * lc.Precio),0) AS Comprado
FROM Compras c LEFT JOIN LineasCompras lc ON c.IdCompra = lc.IdCompra
AND c.IdEmpleado = lc.IdEmpleado AND c.IdProveedor = lc.IdProveedor
WHERE c.FechaCompra BETWEEN '2000-01-17 08:00:00' AND NOW()
GROUP BY Año, Mes, Month(c.FechaCompra)
ORDER BY Año, Mes, Month(c.FechaCompra) ASC;


INSERT INTO Balance(Anio, Mes, Vendido)
SELECT year(v.FechaVenta)AS Año, 
	CASE month(v.FechaVenta) 
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
 END Mes, 
IFNULL(SUM(lv.Cantidad * lv.Precio),0) AS Vendido
FROM Ventas v LEFT JOIN LineasVentas lv ON v.IdVenta = lv.IdVenta
AND v.IdEmpleado = lv.IdEmpleado AND v.IdCliente = lv.IdCliente 
WHERE v.FechaVenta BETWEEN '2000-01-17 08:00:00' AND NOW()
GROUP BY Año, Mes, Month(v.FechaVenta)
ORDER BY Año, Mes, Month(v.FechaVenta) ASC;


SELECT Anio, Mes, SUM(Comprado) AS Comprado, SUM(Vendido) AS Vendido FROM Balance
GROUP BY Anio, Mes;

-- 5. Hacer un ranking con los productos que más se venden (por cantidad) entre un rango de fechas.

SELECT np.NombreProducto AS Producto, SUM(lv.Cantidad) AS Cantidad FROM NombreProductos np
INNER JOIN Productos p ON np.IdNombreProducto = p.IdNombreProducto 
LEFT JOIN LineasVentas lv ON p.IdProducto = lv.IdProducto 
AND p.IdRubro = lv.IdRubro
LEFT JOIN Ventas v ON lv.IdVenta = v.IdVenta AND lv.IdEmpleado = v.IdEmpleado
AND lv.IdCliente = v.IdCliente
WHERE (v.FechaVenta BETWEEN '2000-01-30 14:15:55' AND NOW())
GROUP BY np.NombreProducto
ORDER BY Cantidad DESC;

-- 6. Hacer un ranking con los productos que más se venden (por importe) entre un rango de fechas.

SELECT np.NombreProducto AS Producto, SUM(lv.Precio * lv.Cantidad) AS Importe FROM NombreProductos np
INNER JOIN Productos p ON np.IdNombreProducto = p.IdNombreProducto 
LEFT JOIN LineasVentas lv ON p.IdProducto = lv.IdProducto 
AND p.IdRubro = lv.IdRubro
LEFT JOIN Ventas v ON lv.IdVenta = v.IdVenta AND lv.IdEmpleado = v.IdEmpleado
AND lv.IdCliente = v.IdCliente
WHERE (v.FechaVenta BETWEEN '2000-01-30 14:15:55' AND NOW())
GROUP BY np.NombreProducto
ORDER BY SUM(lv.Precio * lv.Cantidad) DESC;

-- 7. Hacer un ranking con los proveedores a los que más compras se le hicieron (por cantidad) 
-- entre un rango de fechas.

SELECT pr.RazonSocial AS Proveedor, IFNULL(SUM(lc.Cantidad),0) AS Cantidad FROM Proveedores pr
LEFT JOIN Compras c ON pr.IdProveedor = c.IdCompra 
LEFT JOIN LineasCompras lc ON c.IdCompra = lc.IdCompra AND c.IdEmpleado = lc.IdEmpleado
AND c.IdProveedor = lc.IdProveedor
WHERE (c.FechaCompra BETWEEN '2000-01-30 14:15:55' AND NOW())
GROUP BY Proveedor
ORDER BY Cantidad DESC;

-- 8. Crear una vista con la funcionalidad del apartado 2. 
DROP VIEW IF EXISTS v8;

CREATE VIEW v8 AS SELECT c.IdCliente AS IdCliente, lv.IdLineaVenta, pe.Apellidos AS 'Apellidos', pe.Nombres AS 'Nombres', 
v.IdVenta AS 'N° de factura', v.FechaVenta AS 'Fecha',
np.NombreProducto AS 'Producto', lv.Cantidad, lv.Precio AS 'Precio unitario',
lv.Cantidad * lv.Precio AS 'Importe'
FROM Personas pe INNER JOIN Clientes c ON pe.IdPersona = c.IdCliente
INNER JOIN Ventas v ON c.IdCliente = v.IdCliente
INNER JOIN LineasVentas lv ON v.IdVenta = lv.IdVenta AND v.IdEmpleado = lv.IdEmpleado AND v.IdCliente = lv.IdCliente
INNER JOIN Productos pr ON lv.IdRubro = pr.IdRubro AND lv.IdProducto = pr.IdProducto
INNER JOIN NombreProductos np ON pr.IdNombreProducto = np.IdNombreProducto
ORDER BY pe.Apellidos, pe.Nombres, v.IdVenta, v.FechaVenta;

SELECT * FROM v8 WHERE (IdCliente = 7 AND (Fecha BETWEEN '2015-01-30 14:15:55' AND NOW()));

-- 9. Crear una copia de la tabla Productos, que además tenga una columna del tipo JSON
-- para guardar el detalle de las compras. Llenar esta tabla con los mismos datos del TP1 y
-- resolver la consulta del apartado 4.

DROP TABLE IF EXISTS ProductosJSON;
DROP TABLE IF EXISTS tProductosJSON;

CREATE TEMPORARY TABLE tProductosJSON(
IdProducto          	INT            NOT NULL,
    IdRubro             SMALLINT       NOT NULL,
    IdNombreProducto    SMALLINT       NOT NULL,
    Color               VARCHAR(60)    NOT NULL,
	Detalle 	    JSON 		   NULL);
    
INSERT INTO tProductosJSON(IdProducto, IdRubro, IdNombreProducto, Color, Detalle)
SELECT p.IdProducto, p.IdRubro, p.IdNombreProducto, p.Color, 
JSON_OBJECT('Cantidad',lc.Cantidad, 'Precio',lc.Precio, 'Proveedor',prov.RazonSocial ,'Fecha',c.FechaCompra,'Numero de factura',c.NumFactura) 
FROM Productos p LEFT JOIN LineasCompras lc ON p.IdProducto = lc.IdProducto AND p.IdRubro = lc.IdRubro
LEFT JOIN Compras c ON lc.IdCompra = c.IdCompra AND lc.IdEmpleado = c.IdEmpleado AND lc.IdProveedor = c.IdProveedor
INNER JOIN Proveedores prov ON c.IdProveedor = prov.IdProveedor;

CREATE TABLE ProductosJSON(
	IdProducto          	INT            NOT NULL,
    IdRubro             SMALLINT       NOT NULL,
    IdNombreProducto    SMALLINT       NOT NULL,
    Color               VARCHAR(60)    NOT NULL,
	Detalle 	    JSON 		   NULL);

INSERT INTO ProductosJSON
SELECT IdProducto, IdRubro,IdNombreProducto, Color, JSON_ARRAYAGG(Detalle) AS Detalle FROM tProductosJSON
GROUP BY IdProducto, IdRubro,IdNombreProducto, Color;

-- Inicia sentencia similar punto 4:
DROP TABLE IF EXISTS Balance;
CREATE TEMPORARY TABLE Balance(
	`Anio` INT NOT NULL,
    `Mes` VARCHAR(10) NOT NULL,
    `Comprado` DECIMAL(10,2) NOT NULL DEFAULT 0,
    `Vendido` DECIMAL (10,2) NOT NULL DEFAULT 0)
ENGINE = InnoDB;

	-- Cambio respecto a punto 4
	INSERT INTO Balance(Anio, Mes, Comprado)
    SELECT year(TablaJSON.FechaCompra) as 'Año', 
    	CASE month(TablaJSON.FechaCompra) 
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
	 END Mes, 
    IFNULL(SUM(TablaJSON.Cantidad * TablaJSON.Precio),0) AS 'Comprado'
	FROM  ProductosJSON, JSON_TABLE(Detalle, '$[*]' COLUMNS (
		FechaCompra datetime PATH '$.Fecha',
		Cantidad int path '$.Cantidad',
		Precio decimal PATH '$.Precio'
		)
	) AS TablaJSON 
	WHERE date(TablaJSON.FechaCompra) BETWEEN '2000-01-17 08:00:00' AND NOW()
	GROUP BY Año, Mes, month(TablaJSON.FechaCompra)
	ORDER BY Año, Mes, month(TablaJSON.FechaCompra) ASC;
	-- Fin cambio respecto punto 4

INSERT INTO Balance(Anio, Mes, Vendido)
SELECT year(v.FechaVenta)AS Año, 
	CASE month(v.FechaVenta) 
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
 END Mes, 
IFNULL(SUM(lv.Cantidad * lv.Precio),0) AS Vendido
FROM Ventas v LEFT JOIN LineasVentas lv ON v.IdVenta = lv.IdVenta AND v.IdEmpleado = lv.IdEmpleado AND v.IdCliente = lv.IdCliente
WHERE v.FechaVenta BETWEEN '2000-01-17 08:00:00' AND NOW()
GROUP BY Año, Mes, Month(v.FechaVenta)
ORDER BY Año, Mes, Month(v.FechaVenta) ASC;

SELECT Anio, Mes, SUM(Comprado) AS Comprado, SUM(Vendido) AS Vendido FROM Balance
GROUP BY Anio, Mes;
-- Fin sentencia similar punto 4


-- 10. Realizar una vista que considere importante para su modelo. También dejar escrito el
-- enunciado de la misma.
-- Enunciado: Crear una vista que contenga los apellidos, nombres, cargo, usuario, estado, email y telefono de un empleado.

DROP VIEW IF EXISTS vEmpleados;

CREATE VIEW vEmpleados AS SELECT pe.Apellidos, pe.Nombres, ca.Cargo, e.Usuario, 
CASE e.EstadoEmpleado
WHEN 'A' THEN 'Activo'
WHEN 'I' THEN  'Inactivo'
 END Estado, pe.Email, pe.Telefono 
FROM Personas pe INNER JOIN Empleados e ON pe.IdPersona = e.IdEmpleado
INNER JOIN Cargos ca ON e.IdCargo = ca.IdCargo
ORDER BY pe.Apellidos, pe.Nombres, e.Usuario;