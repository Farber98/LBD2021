-- Creacion tablas para auditoria.

-- 
-- TABLE: AudCompras 
--
DROP TABLE IF EXISTS AudCompras;
CREATE TABLE AudCompras(
    IdAudCompras    INT            AUTO_INCREMENT,
    FechaAud        DATETIME       NOT NULL,
    Usuario         VARCHAR(30)    NOT NULL,
    Ip              VARCHAR(40)    NOT NULL,
    Tipo            CHAR(1)        NOT NULL
                    CHECK (Tipo IN ('I', 'M', 'B' ,'A', 'D')),
    IdCompra        INT            NOT NULL,
    IdEmpleado      INT            NOT NULL,
    IdProveedor     SMALLINT       NOT NULL,
    NumFactura      VARCHAR(30)    NOT NULL,
    FechaCompra     DATETIME       NOT NULL,
    FechaEntrega    DATETIME,
    FechaPago       DATETIME,
    PRIMARY KEY (IdAudCompras)
)
;

-- 
-- TABLE: AudLineasCompras 
--
DROP TABLE IF EXISTS AudLineasCompras;
CREATE TABLE AudLineasCompras(
    IdAudLineasCompras    INT               AUTO_INCREMENT,
    FechaAud              DATETIME          NOT NULL,
    Usuario               VARCHAR(30)       NOT NULL,
    Ip                    VARCHAR(40)       NOT NULL,
    Tipo                  CHAR(1)           NOT NULL
                          CHECK (Tipo IN ('I', 'M', 'B', 'A', 'D')),
    IdLineaCompra         INT               NOT NULL,
    IdCompra              INT               NOT NULL,
    IdEmpleado            INT               NOT NULL,
    IdProveedor           SMALLINT          NOT NULL,
    IdRubro               SMALLINT          NOT NULL,
    IdProducto            INT               NOT NULL,
    Cantidad              SMALLINT          NOT NULL,
    Precio                DECIMAL(10, 2)    NOT NULL,
    PRIMARY KEY (IdAudLineasCompras)
)
;

-- Modificaciones.
UPDATE `LBD202110`.`Empleados` SET `EstadoEmpleado` = 'I' WHERE (`IdEmpleado` = '18');
UPDATE `LBD202110`.`Proveedores` SET `Estado` = 'I' WHERE (`IdProveedor` = '18');
UPDATE `LBD202110`.`NombreProductos` SET `Estado` = 'I' WHERE (`IdNombreProducto` = '18');
UPDATE `LBD202110`.`Rubros` SET `Estado` = 'I' WHERE (`IdRubro` = '18');


-- Auditoria con tipo de operación que se realizó (creación, borrado, modificación), el usuario que la hizo, la fecha y hora de la operación, 
-- la máquina desde donde se la hizo y todas las información necesaria para la auditoría (en el caso de las modificaciones, 
-- se deberán auditar tanto los valores viejos como los nuevos).

-- 1. Creación

-- Auditoria compra
DROP TRIGGER IF EXISTS `LBD202110`.`Compras_AFTER_INSERT`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `LBD202110`.`Compras_AFTER_INSERT` AFTER INSERT ON `Compras` FOR EACH ROW
BEGIN
	INSERT INTO AudCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'I',NEW.IdCompra, NEW.IdEmpleado, NEW.IdProveedor, NEW.NumFactura, NEW.FechaCompra, NEW.FechaEntrega, NEW.FechaPago);
END$$
DELIMITER ;

-- Auditoria linea compra
DROP TRIGGER IF EXISTS `LBD202110`.`LineasCompras_AFTER_INSERT`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `LBD202110`.`LineasCompras_AFTER_INSERT` AFTER INSERT ON `LineasCompras` FOR EACH ROW
BEGIN
	INSERT INTO AudLineasCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'I',NEW.IdLineaCompra,NEW.IdCompra, NEW.IdEmpleado, NEW.IdProveedor, NEW.IdRubro, NEW.IdProducto, NEW.Cantidad, NEW.Precio);
END$$
DELIMITER ;

    
-- 2. Modificación

-- Auditoria compra
DROP TRIGGER IF EXISTS `LBD202110`.`Compras_AFTER_UPDATE`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `LBD202110`.`Compras_AFTER_UPDATE` AFTER UPDATE ON `Compras` FOR EACH ROW
BEGIN
-- Valores antes del update.
    INSERT INTO AudCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'A',OLD.IdCompra, OLD.IdEmpleado, OLD.IdProveedor, OLD.NumFactura, OLD.FechaCompra, OLD.FechaEntrega, OLD.FechaPago);
    
    -- Valores despues del update.
    INSERT INTO AudCompras VALUES (0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'D',NEW.IdCompra, NEW.IdEmpleado, NEW.IdProveedor, NEW.NumFactura, NEW.FechaCompra, NEW.FechaEntrega, NEW.FechaPago);
END$$
DELIMITER ;

-- Auditoria linea compra
DROP TRIGGER IF EXISTS `LBD202110`.`LineasCompras_AFTER_UPDATE`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `LBD202110`.`LineasCompras_AFTER_UPDATE` AFTER UPDATE ON `LineasCompras` FOR EACH ROW
BEGIN
	-- Valores antes del update.
    INSERT INTO AudLineasCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'A',OLD.IdLineaCompra,OLD.IdCompra, OLD.IdEmpleado, OLD.IdProveedor, OLD.IdRubro, OLD.IdProducto, OLD.Cantidad, OLD.Precio);

	-- Valores despues del update
	INSERT INTO AudLineasCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'D',NEW.IdLineaCompra,NEW.IdCompra, NEW.IdEmpleado, NEW.IdProveedor, NEW.IdRubro, NEW.IdProducto, NEW.Cantidad, NEW.Precio);
END$$
DELIMITER ;

-- 3. Borrado

-- Auditoria compra
DROP TRIGGER IF EXISTS `LBD202110`.`Compras_AFTER_DELETE`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `LBD202110`.`Compras_AFTER_DELETE` AFTER DELETE ON `Compras` FOR EACH ROW
BEGIN
	 INSERT INTO AudCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'B',OLD.IdCompra, OLD.IdEmpleado, OLD.IdProveedor, OLD.NumFactura, OLD.FechaCompra, OLD.FechaEntrega, OLD.FechaPago);
END$$
DELIMITER ;

-- Auditoria linea compra
DROP TRIGGER IF EXISTS `LBD202110`.`LineasCompras_AFTER_DELETE`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `LBD202110`.`LineasCompras_AFTER_DELETE` AFTER DELETE ON `LineasCompras` FOR EACH ROW
BEGIN
	INSERT INTO AudLineasCompras VALUES(0, NOW(), SUBSTRING_INDEX(USER(),'@',1), SUBSTRING_INDEX(USER(),'@',-1), 
    'B',OLD.IdLineaCompra,OLD.IdCompra, OLD.IdEmpleado, OLD.IdProveedor, OLD.IdRubro, OLD.IdProducto, OLD.Cantidad, OLD.Precio);
END$$
DELIMITER ;


-- Procedimientos almacenados: Realizar (lo más eficientemente posible) los siguientes procedimientos almacenados, 
-- incluyendo el control de errores lógicos y mensajes de error:


-- 4. Creación de una Compra y sus Líneas.

-- Compra
DROP procedure IF EXISTS `LBD202110`.`sp_insertarCompra`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_insertarCompra`(pIdEmpleado int, pIdProveedor smallint, pNumFactura varchar(30))
SALIR:BEGIN
/*
	Permite insertar una Compra  controlando que los parametros ingresados sean correctos,
    que las personas involucradas existan y esten dadas de alta. 
    Crea con FechaCompra NOW(). 
    Devuelve OK + Id o el mensaje de error en Mensaje.
*/
DECLARE pIdCompra int;
DECLARE EXIT HANDLER FOR SQLEXCEPTION 

-- Manejo de error en la transaccion
BEGIN
	SELECT 'Error en la transacción. Contáctese con el administrador' Mensaje;
	-- SHOW ERRORS;
    ROLLBACK;
END;

 -- Control pIdEmpleado
    IF pIdEmpleado IS NULL OR pIdEmpleado = 0 THEN
		SELECT 'El empleado es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
    -- Control pIdProveedor
    IF pIdProveedor IS NULL OR pIdProveedor = 0 THEN
		SELECT 'El proveedor es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
	
    -- Controlo pNumFactura
    IF pNumFactura IS NULL OR pNumFactura = '' THEN
		SELECT 'El numero de factura es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
	
	 -- Controlo que Empleado exista  y no este dado de baja.
    IF NOT EXISTS(SELECT IdEmpleado FROM Empleados WHERE (
		pIdEmpleado = IdEmpleado AND EstadoEmpleado = 'A' ))
		THEN SELECT 'Empleado no existe o esta dado de baja.' AS Mensaje;
        LEAVE SALIR;
	END IF;

	-- Controlo que Proveedor exista  y no este dado de baja.
    IF NOT EXISTS(SELECT IdProveedor FROM Proveedores WHERE (
		pIdProveedor = IdProveedor AND Estado = 'A' ))
		THEN SELECT 'Proveedor no existe o esta dado de baja.' AS Mensaje;
        LEAVE SALIR;
	END IF;

	 -- Controlo NumFactura no este repetido para un mismo proveedor.
    IF EXISTS(SELECT NumFactura FROM Compras WHERE (
				NumFactura = pNumFactura AND IdProveedor = pIdProveedor))
		THEN SELECT 'El numero de factura ya existe para ese proveedor.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
	START TRANSACTION;
        -- Inserta
        INSERT INTO Compras VALUES(0, pIdEmpleado, pIdProveedor,pNumFactura,NOW(), NULL, NULL);
		SET pIdCompra = LAST_INSERT_ID();
		SELECT 'OK' Mensaje, pIdCompra AS Id;
    COMMIT;
END$$

DELIMITER ;
;

-- Linea Compra

DROP procedure IF EXISTS `LBD202110`.`sp_insertarLineaCompra`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_insertarLineaCompra`(pIdCompra int, pIdProducto int, pCantidad int, pPrecio decimal(10,2))
SALIR:BEGIN
/*
	Permite insertar una LineaCompra controlando que los parametros ingresados sean 
    correctos y que tanto la compra como el producto existan. El producto debe estar activo.
    Accedemos al proveedor y al empleado que se introdujo en la compra.
    Devuelve OK o el mensaje de error en Mensaje.
*/

DECLARE IdProv smallint;
DECLARE IdEmpl int;
DECLARE IdRub smallint;

-- Manejo de error de la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador' Mensaje;
        ROLLBACK;
    END;

-- Control pIdCompra
    IF pIdCompra IS NULL OR pIdCompra = 0 THEN
		SELECT 'La compra es obligatoria.' AS Mensaje ;
        LEAVE SALIR;
    END IF;

-- Control pIdProducto
    IF pIdProducto IS NULL OR pIdProducto = 0 THEN
		SELECT 'El producto es obligatorio.' AS Mensaje ;
        LEAVE SALIR;
    END IF;

-- Control pIdCantidad
    IF pCantidad IS NULL OR pCantidad = 0 THEN
		SELECT 'La cantidad es obligatoria.' AS Mensaje ;
        LEAVE SALIR;
    END IF;

-- Control pPrecio
    IF pPrecio IS NULL OR pPrecio = 0 THEN
		SELECT 'El precio es obligatorio.' AS Mensaje ;
        LEAVE SALIR;
    END IF;
    
-- Controlo que la compra exista.
    IF NOT EXISTS(SELECT IdCompra FROM Compras WHERE IdCompra = pIdCompra) 
		THEN SELECT 'La compra no existe.' AS Mensaje;
        LEAVE SALIR;
    END IF;
        
-- Accedemos al rubro del producto
	SET IdRub = (SELECT IdRubro FROM Productos WHERE IdProducto = pIdProducto);

-- Controlamos que el rubro exista y no este dado de baja.
	IF NOT EXISTS(SELECT IdRubro FROM Rubros WHERE (IdRubro = IdRub AND Estado = 'A')) THEN 
		SELECT 'El rubro no existe o esta dado de baja.' AS Mensaje;
        LEAVE SALIR;
    END IF;
        
-- Controlo que el producto exista y no este dado de baja.
    IF NOT EXISTS(SELECT IdProducto FROM Productos p INNER JOIN NombreProductos np
    ON p.IdNombreProducto = np.IdNombreProducto
    WHERE (p.IdProducto = pIdProducto AND np.Estado = 'A')) THEN 
		SELECT 'El producto no existe o esta dado de baja.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
	START TRANSACTION;
		-- Accedemos al proveedor que se inserto en la compra.
		SET IdProv = (SELECT IdProveedor FROM Compras WHERE IdCompra = pIdCompra);
		
        -- Accedemos al empleado que se inserto en la compra.
        SET IdEmpl = (SELECT IdEmpleado FROM Compras WHERE IdCompra = pIdCompra);

        -- Inserta
        INSERT INTO LineasCompras VALUES(0, pIdCompra, IdEmpl, IdProv, IdRub ,pIdProducto, pCantidad, pPrecio);
		SET pIdCompra = LAST_INSERT_ID();
		SELECT 'OK' Mensaje, pIdCompra AS Id;
    
    COMMIT;
END$$

DELIMITER ;
;

-- 5. Modificación de una Compra y sus Líneas.

-- Compra
DROP procedure IF EXISTS `LBD202110`.`sp_modificarCompra`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_modificarCompra`(pIdCompra int, pIdEmpleado int, pIdProveedor smallint, pNumFactura varchar(30))
SALIR: BEGIN
/*
	Permite modificar una Compra controlando que exista, que los parametros ingresados sean correctos,
    que las personas involucradas existan y esten dadas de alta. Toma la fecha de modificacion.
    Devuelve OK o el mensaje de error en Mensaje. 
*/

-- Control pIdEmpleado
    IF pIdEmpleado IS NULL OR pIdEmpleado = 0 THEN
		SELECT 'El empleado es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
    -- Control pIdProveedor
    IF pIdProveedor IS NULL OR pIdProveedor = 0 THEN
		SELECT 'El proveedor es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
	
    -- Controlo pNumFactura
    IF pNumFactura IS NULL OR pNumFactura = '' THEN
		SELECT 'El numero de factura es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
	 -- Controlo que la compra exista.
    IF NOT EXISTS(SELECT IdCompra FROM Compras WHERE IdCompra = pIdCompra) 
		THEN SELECT 'La compra no existe.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
    -- Controlo que Empleado exista  y no este dado de baja.
    IF NOT EXISTS(SELECT IdEmpleado FROM Empleados WHERE (
		pIdEmpleado = IdEmpleado AND EstadoEmpleado = 'A' ))
		THEN SELECT 'Empleado no existe o esta dado de baja.' AS Mensaje;
        LEAVE SALIR;
	END IF;

	-- Controlo que Proveedor exista  y no este dado de baja.
    IF NOT EXISTS(SELECT IdProveedor FROM Proveedores WHERE (
		pIdProveedor = IdProveedor AND Estado = 'A' ))
		THEN SELECT 'Proveedor no existe o esta dado de baja.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlo NumFactura no este repetido para un mismo proveedor.
    IF EXISTS(SELECT NumFactura FROM Compras WHERE (
				NumFactura = pNumFactura AND IdProveedor = pIdProveedor))
		THEN SELECT 'El numero de factura ya existe para ese proveedor.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
     -- Actualizar
    UPDATE	Compras
    SET		IdEmpleado = pIdEmpleado, IdProveedor = pIdProveedor,
			NumFactura = pNumFactura, FechaCompra = NOW()
	WHERE	IdCompra = pIdCompra;
    SELECT 'OK' AS Mensaje;

END$$

DELIMITER ;
;

-- Linea Compra
DROP procedure IF EXISTS `LBD202110`.`sp_modificarLineaCompra`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_modificarLineaCompra`(pIdLineaCompra int, pCantidad smallint, pPrecio decimal(10,2))
SALIR:BEGIN
/*
	Permite modificar el precio y cantidad de una LineaCompra controlando que los parametros ingresados 
    sean correctos. Devuelve OK o el mensaje de error en Mensaje. 
*/

-- Control pIdLineaCompra
    IF pIdLineaCompra IS NULL OR pIdLineaCompra = 0 THEN
		SELECT 'La linea de compra es obligatoria.' AS Mensaje ;
        LEAVE SALIR;
    END IF;

-- Control pIdCantidad
    IF pCantidad IS NULL OR pCantidad = 0 THEN
		SELECT 'La cantidad es obligatoria.' AS Mensaje ;
        LEAVE SALIR;
    END IF;

-- Control pPrecio
    IF pPrecio IS NULL OR pPrecio = 0 THEN
		SELECT 'El precio es obligatorio.' AS Mensaje ;
        LEAVE SALIR;
    END IF;

 -- Controlo que la compra exista.
    IF NOT EXISTS(SELECT IdLineaCompra FROM LineasCompras WHERE IdLineaCompra = pIdLineaCompra) 
		THEN SELECT 'La linea de compra no existe.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
     -- Actualizar
    UPDATE	LineasCompras
    SET		Cantidad = pCantidad, Precio = pPrecio
	WHERE	IdLineaCompra = pIdLineaCompra;
    SELECT 'OK' AS Mensaje;

END$$

DELIMITER ;
;

-- 6. Borrado de una Compra y sus Líneas.

-- Compra
DROP procedure IF EXISTS `LBD202110`.`sp_borrarCompra`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_borrarCompra`(pIdCompra int)
SALIR:BEGIN
/*
    Permite borrar la compra, si no esta asociada a LineasCompras. 
    Controla que los parametros ingresados sean correctos. Controla que exista. 
    Devuelve OK o el mensaje de error en Mensaje.
*/

    -- Controla parametros
	IF pIdCompra IS NULL OR pIdCompra = 0 THEN
		SELECT 'La compra es obligatoria.' AS Mensaje;
        LEAVE SALIR;
    END IF;

   -- Controlar si existe
    IF NOT EXISTS(SELECT IdCompra FROM Compras WHERE IdCompra = pIdCompra) 
    THEN SELECT 'La compra que quiere borrar no existe.' AS Mensaje;
        LEAVE SALIR; 
	END IF;
        
    -- Controlo si tiene lineas compras asociadas.
    IF EXISTS(SELECT IdCompra FROM LineasCompras WHERE IdCompra = pIdCompra) THEN
		SELECT 'No puede borrar la compra. Existen lineas de compra asociadas.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
    DELETE FROM Compras WHERE IdCompra = pIdCompra;
    SELECT 'OK' AS Mensaje;

END$$

DELIMITER ;
;

-- Linea Compra
DROP procedure IF EXISTS `LBD202110`.`sp_borrarLineaCompra`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_borrarLineaCompra`(pIdLineaCompra int)
SALIR:BEGIN
/*
	Permite borrar una LineaCompra. Controla que exista. 
    Controla que los parametros ingresados sean correctos. 
    Devuelve OK o el mensaje de error en Mensaje.
*/

    -- Control pIdLineaCompra
    IF pIdLineaCompra IS NULL OR pIdLineaCompra = 0 THEN
		SELECT 'La linea de compra es obligatoria.' AS Mensaje;
        LEAVE SALIR;
    END IF;
	
    -- Controlo que la LineaCompra exista.
    IF NOT EXISTS(SELECT IdLineaCompra FROM LineasCompras WHERE IdLineaCompra = pIdLineaCompra) 
		THEN SELECT 'La linea de compra no existe.' AS Mensaje;
        LEAVE SALIR;
    END IF;

	DELETE FROM LineasCompras WHERE IdLineaCompra = pIdLineaCompra;
    SELECT 'OK' AS Mensaje;

END$$

DELIMITER ;
;



-- 7. Búsqueda de una Compra.
DROP procedure IF EXISTS `LBD202110`.`sp_buscarCompras`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_buscarCompras`(pFechaInicio date, pFechaFin date, pIdEmpleado int, pIdProveedor smallint)
BEGIN
/*  Procedimiento que permite buscar las compras entre fechas, filtrando por 
    proveedor (pIdProveedor = 0 no filtra) o por empleado (pIdEmpleado = 0 no filtra). 
    Ordena por fecha. 
*/

 DECLARE pAux date;
	-- Ordenamos las fechas cruzadas.
    IF pFechaInicio > pFechaFin THEN
		SET pAux = pFechaInicio;
        SET pFechaInicio = pFechaFin;
        SET pFechaFin = pAux;
	END IF;
    
    SELECT		c.IdCompra, c.NumFactura, c.FechaCompra, pr.RazonSocial AS Proveedor,
				CONCAT(pe.Apellidos,' ', pe.Nombres) AS Empleado
	FROM		Compras c INNER JOIN Proveedores pr ON c.IdProveedor = pr.IdProveedor
				INNER JOIN Empleados e ON c.IdEmpleado = e.IdEmpleado
                INNER JOIN Personas pe ON e.IdEmpleado = pe.IdPersona
	WHERE		c.FechaCompra BETWEEN pFechaInicio AND pFechaFin AND
				(pIdEmpleado = 0 OR c.IdEmpleado = pIdEmpleado) AND
                (pIdProveedor = 0 OR c.IdProveedor = pIdProveedor)
	ORDER BY	c.FechaCompra;
END$$

DELIMITER ;
;


-- 8. Listado de compras y su monto total, filtrado y ordenado por el criterio que considere más adecuado.
DROP procedure IF EXISTS `LBD202110`.`sp_listarCompras`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_listarCompras`(pFechaInicio date, pFechaFin date, pIdEmpleado int, pIdProveedor smallint)
BEGIN
/*  Procedimiento que permite buscar las compras entre fechas, filtrando por 
    proveedor (pIdProveedor = 0 no filtra), por empleado (pIdEmpleado = 0 no filtra). 
    Ordena por fecha .
*/

 DECLARE pAux date;
	-- Ordenamos las fechas cruzadas.
    IF pFechaInicio > pFechaFin THEN
		SET pAux = pFechaInicio;
        SET pFechaInicio = pFechaFin;
        SET pFechaFin = pAux;
	END IF;
    
    SELECT		c.IdCompra, c.NumFactura, c.FechaCompra, pr.RazonSocial AS Proveedor,
				CONCAT(pe.Apellidos,' ', pe.Nombres) AS Empleado, 
                SUM(lc.Cantidad * lc.Precio) AS Total
	FROM		Compras c INNER JOIN Proveedores pr ON c.IdProveedor = pr.IdProveedor
				INNER JOIN Empleados e ON c.IdEmpleado = e.IdEmpleado
                INNER JOIN Personas pe ON e.IdEmpleado = pe.IdPersona
                INNER JOIN LineasCompras lc ON 
                c.IdCompra = lc.IdCompra AND c.IdEmpleado = lc.IdEmpleado
                AND c.IdProveedor = lc.IdProveedor
	WHERE		c.FechaCompra BETWEEN pFechaInicio AND pFechaFin AND
				(pIdEmpleado = 0 OR c.IdEmpleado = pIdEmpleado) AND
                (pIdProveedor = 0 OR c.IdProveedor = pIdProveedor)
	GROUP BY 	c.IdCompra
    ORDER BY	c.FechaCompra, pr.RazonSocial, Total;
        
END$$

DELIMITER ;
;


-- 9. Dado un proveedor, listar todas las compras que se le hicieron entre un rango de fechas.
-- Esta funcionalidad esta incluida en la busqueda de compras realizada en el punto 7.

-- 10. Realizar un procedimiento almacenado con alguna funcionalidad que considere de interés.
-- Enunciado: Dado un rubro, ponerlo en estado inactivo.

DROP procedure IF EXISTS `LBD202110`.`sp_desactivarRubro`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER PROCEDURE `sp_desactivarRubro`(pIdRubro smallint)
SALIR:BEGIN
	/*
    Permite cambiar el estado de un Rubro a 'I: Inactivo' si no se encuentra en
    ese estado. No se puede poner en inactivo un rubro que tiene productos asociados
    en estado 'A: Activo'. Controla que los parametros ingresados sean correctos.
    Devuelve OK o el mensaje de error en Mensaje.
	*/
	
    -- Controla parametros
	IF pIdRubro IS NULL OR pIdRubro = 0 THEN
		SELECT 'El rubro es obligatorio.' AS Mensaje;
        LEAVE SALIR;
    END IF;
    
   -- Controlar si existe
    IF NOT EXISTS(SELECT IdRubro FROM Rubros WHERE IdRubro = pIdRubro) THEN 
		SELECT 'El rubro no existe.' AS Mensaje;
        LEAVE SALIR; 
	END IF;

    -- Controlar que no este inactivo
    IF EXISTS( SELECT IdRubro FROM Rubros WHERE IdRubro = pIdRubro AND Estado = 'I') 
    THEN SELECT 'El rubro ya está inactivo.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
    -- Controlar que no posea productos activos.
    IF EXISTS (SELECT p.IdRubro FROM Productos p INNER JOIN NombreProductos np
				ON p.IdNombreProducto = np.IdNombreProducto
                WHERE p.IdRubro = pIdRubro AND np.Estado = 'A')
	THEN SELECT 'El rubro posee productos activos asociados.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
	-- Ponemos al rubro en inactivo.
    UPDATE Rubros SET Estado = 'I' WHERE IdRubro = pIdRubro;
    SELECT 'OK' AS Mensaje;
END$$

DELIMITER ;
;

-- 11. Incluir las sentencias de llamada a los procedimientos. Para cada uno hacer 4 llamadas (una con salida correcta y las otras 3 
-- con diferentes errores explicando su intención en un comentario).

-- 4. Creación de una Compra y sus Líneas.
CALL sp_insertarCompra(0,10,423423423); -- El empleado es obligatorio.
CALL sp_insertarCompra(99,10,423423423); -- El empleado 99 no existe.
CALL sp_insertarCompra(10,1, 123123); -- Num de factura repetido para un mismo proveedor. 
CALL sp_insertarCompra(10,1,423423423); -- OK.

CALL sp_insertarLineaCompra(0,0,0,0); -- La compra es obligatoria.
CALL sp_insertarLineaCompra(99,10,30,50); -- La compra 99 no existe.
CALL sp_insertarLineaCompra(18,16,50,50) ;-- El producto 16 esta dado de baja.
CALL sp_insertarLineaCompra(18,15,50,50); -- OK.


-- 5. Modificación de una Compra y sus Líneas.
CALL sp_modificarCompra(40,40,40,40); -- Compra 40 no existe.
CALL sp_modificarCompra(10,18,40,40); -- Empleado 18 dado de baja.
CALL sp_modificarCompra(10,2,18,40); -- Proveedor 18 dado de baja.
CALL sp_modificarCompra(10,2,5,349823); -- OK. 

CALL sp_modificarLineaCompra(27, 0,50); -- Cantidad no puede ser 0.
CALL sp_modificarLineaCompra(27, 100,0); -- Precio no puede ser 0.
CALL sp_modificarLineaCompra(99999, 100,50); -- Linea de compra no existe.
CALL sp_modificarLineaCompra(18, 100,50); -- OK.

-- 6. Borrado de una Compra y sus Líneas.
CALL sp_borrarCompra(NULL); -- La compra es obligatoria.
CALL sp_borrarCompra(42342); -- La compra no existe.
CALL sp_borrarCompra(1); -- No se puede borrar la compra. Existen lineas asociadas.
CALL sp_borrarCompra(10); -- OK.

CALL sp_borrarLineaCompra(NULL); -- La linea de compra es obligatoria.
CALL sp_borrarLineaCompra(9999); -- La linea de compra no existe.
CALL sp_borrarLineaCompra(26); -- OK.

-- 7. Búsqueda de una Compra. 
-- 9. Dado un proveedor, listar todas las compras que se le hicieron entre un rango de fechas.
-- Este SP solo tiene error con el tipo de dato de los parametros. Se muestran todos casos de exito
CALL sp_buscarCompras('2013-1-1', NOW(),0,0); -- Busca desde 1-1-2013 a fecha actual, todos los empleados y todos los proveedores
CALL sp_buscarCompras('2013-1-1', NOW(),10,0); -- Busca desde 1-1-2013 a fecha actual, IdEmpleado = 5 y todos los proveedores
CALL sp_buscarCompras('2013-1-1', NOW(),0,5); -- Busca desde 1-1-2013 a fecha actual, todos los empleados y IdProveedor = 5

-- 8. Listado de compras y su monto total, filtrado y ordenado por el criterio que considere más adecuado.
-- Este SP solo tiene error con el tipo de dato de los parametros. Se muestran todos casos de exito
CALL sp_listarCompras('2010-1-1', '2014-12-31',0,0); -- Busca desde 1-1-2010 a 31-12-2014 , todos los empleados y todos los proveedores
CALL sp_listarCompras('2010-1-1', '2014-12-31',10,0); -- Busca desde 1-1-2010 a 31-12-2014 , IdEmpleado = 10 y todos los proveedores
CALL sp_listarCompras('2010-1-1', '2014-12-31',0,3); -- Busca desde 1-1-2010 a 31-12-2014 , todos los empleados y IdProveedor = 3

-- 10. Realizar un procedimiento almacenado con alguna funcionalidad que considere de interés.
-- Enunciado: Dado un rubro, ponerlo en estado inactivo.

CALL sp_desactivarRubro(0); -- El rubro es obligatorio. 
CALL sp_desactivarRubro(18); -- El rubro 18 ya esta inactivo. 
CALL sp_desactivarRubro(12); -- El rubro 12 posee productos activos asociados.
CALL sp_desactivarRubro(9); -- OK.  
