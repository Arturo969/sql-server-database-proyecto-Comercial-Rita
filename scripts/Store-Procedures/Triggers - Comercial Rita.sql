use ComercialRita

-- TRIGGERS

-- AGENCIA

-- CATEGORIA PRODUCTO

-- CLIENTE

-- DEPARTAMENTO


-- DETALLE VENTA
	-- Calcular PrecioUnitario, Total Bruto y total general
	CREATE TRIGGER trg_CalcularTotales
	ON DetalleVenta
	AFTER INSERT
	AS
		BEGIN
			UPDATE DetalleVenta
			SET DetalleVenta.PrecioUnitario = p.PrecioUnitario, TotalBruto = dbo.fn_TotalBruto(p.PrecioUnitario, i.Cantidad),
				Total = dbo.fn_Total(dbo.fn_TotalBruto(p.PrecioUnitario, i.Cantidad), (i.Descuento))
			FROM DetalleVenta dv INNER JOIN inserted i ON dv.VentaID = i.VentaID AND dv.ProductoID = i.ProductoID
				INNER JOIN Producto p ON p.ProductoID = i.ProductoID;
		END

	SELECT * FROM DetalleVenta

	INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad)
	VALUES (11, 1, 0.5);

	-- Auditoria para denegar eliminaciones y actuaizaciones
	CREATE TRIGGER trg_actualizarPrecio
	ON DetalleVenta
	INSTEAD OF DELETE, UPDATE
	AS
		BEGIN
			ROLLBACK TRANSACTION;
			--PRINT 'No se pueden eliminar ni actualizar los detalles de venta una vez procesados.'
			RAISERROR('No se permite eliminar ni actualizar registros en la tabla DetalleVenta.', 16, 1);
		END

	UPDATE DetalleVenta
	SET Cantidad = 0.2
	WHERE VentaID = 4 AND productoID = 36

	DELETE DetalleVenta WHERE VentaID = 4 AND productoID = 36
	
	INSERT INTO DetalleVenta(VentaID, ProductoID, Cantidad)
	VALUES	(16, 21, 0.5)

	SELECT * FROM DetalleVenta

	-- ingresar compra en la ultima venta
	ALTER TRIGGER trg_insertarUltimaVenta
	ON detalleVenta
	AFTER INSERT
	AS
		BEGIN
			IF EXISTS ( SELECT * FROM inserted i WHERE i.VentaID < (SELECT MAX(VentaID) FROM Venta) )
				BEGIN
					ROLLBACK TRANSACTION;
					RAISERROR('No se permite insertar un producto a ventas anteriores a la última.', 16, 1);
				END
		END

	INSERT INTO DetalleVenta(VentaID, ProductoID, Cantidad)
	VALUES	(4, 13, 0.5)

	-- PROC. ALM. PARA LA INSERCIÓN DE DETALLE DE VENTA
	
SELECT * FROM DetalleVenta
SELECT * FROM Venta
	ALTER PROCEDURE sp_AgregarDetalleVenta
    @NombreCliente NVARCHAR(100),
    @ApellidoCliente NVARCHAR(100),
    @EmpleadoID INT,
    @VentaID INT,
    @ProductoID INT,
    @Cantidad DECIMAL(10,2)
	AS
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION; 
				DECLARE @ClienteID INT;
				-- Intentamos obtener el ClienteID
				SELECT @ClienteID = ClienteID
				FROM Cliente
				WHERE NombreCliente = @NombreCliente
					  AND ApellidoCliente = @ApellidoCliente;

				IF @ClienteID IS NULL
				BEGIN
					-- insertando nuevo cliente
					EXEC sp_InsertarSoloNombreYApellidoCliente @NombreCliente, @ApellidoCliente;
					-- reaccinando clienteID
					SELECT @ClienteID = ClienteID
					FROM Cliente
					WHERE NombreCliente = @NombreCliente 
						  AND ApellidoCliente = @ApellidoCliente;
				END;

				-- Intentamos obtener el ID de la venta
				DECLARE @VentaIDAuxiliar INT;

				IF @VentaID = (SELECT MAX(VentaID) + 1 FROM Venta)
				BEGIN
				-- SI VENTAID ES MAYOR A LA ULTIMA VENTA, SE AGREGA LA NUEVA VENTA
					EXEC sp_ingresarNuevaVenta @ClienteID, @EmpleadoID;
					PRINT 'Venta insertada correctamente.';

					-- reaccinando ventaID
					SELECT @VentaIDAuxiliar = MAX(VentaID) 
					FROM Venta
					WHERE ClienteID = @ClienteID;
				END; 
				-- SI VENTAID ES MAYOR A LA ULTIMA VENTA O SIGUIENTE, SE CANCELA LA OPERACIÓN
				IF @VentaID > (SELECT MAX(VentaID) + 1 FROM Venta)
				BEGIN
					ROLLBACK TRANSACTION;
					PRINT 'La venta no se puede generar, conflicto con VentaID.';
					RETURN;
				END;

				-- SI VENTAID ES MENOR A LA ULTIMA VENTA, SE CANCELA LA OPERACIÓN
				IF @VentaID < ((SELECT MAX(VentaID) FROM Venta))
					BEGIN
						ROLLBACK TRANSACTION;
						PRINT 'No se puede ingresar un producto en una venta anterior.';
						RETURN;
					END;
				-- SI VENTAID ES IGUAL A LA ULTIMA VENTA, SE AGREGA EL NUEVO PRODUCTO
				IF @VentaID = (SELECT MAX(VentaID) FROM Venta)
				BEGIN
					SET @VentaIDAuxiliar = @VentaID;
				END
				-- CALCULAMOS EL DESCUENTO
				DECLARE @Descuento DECIMAL (10,2);
				SET @Descuento = dbo.fn_CalcularDescuento(@Cantidad);

				-- INSERTAMOS UN NUEVO PRODUTO EN EL DETALLE DE VENTA
				INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Descuento)
				VALUES (@VentaIDAuxiliar, @ProductoID, @Cantidad, @Descuento);

				COMMIT TRANSACTION;
				PRINT 'Detalle de venta insertada correctamente.';

			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					ROLLBACK TRANSACTION;

				-- Mostrar el mensaje de error
				DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
				PRINT 'Error: ' + @ErrorMessage;
				RAISERROR (@ErrorMessage, 16, 1);
			END CATCH
		END;

	EXEC sp_AgregarDetalleVenta 'Anthonela', 'Limay', 1, 11, 70, 1

	DELETE FROM DetalleVenta WHERE VentaID = 11 AND ProductoID = 8

	select * from Venta
	select * from DetalleVenta
-- EMPLEADO

-- PAIS


--PRODUCTO
-- Guardar en una tabla todas las actualizaciones de los precios de los productos
	ALTER TRIGGER trg_preciosActualizados
	ON Producto
	AFTER UPDATE
	AS
		BEGIN
			IF UPDATE(PrecioUnitario)
				BEGIN
					INSERT INTO HistorialPrecioProductosActualizados(ProductoID, NombreProducto, ProveedorID, PrecioUnitarioAnteior, PrecioUnitarioActualizado, FechaCambio)
					SELECT d.ProductoID, d.NombreProducto, d.ProveedorID, d.PrecioUnitario, i.PrecioUnitario, GETDATE()
					from inserted i inner join deleted d on i.ProductoID = d.ProductoID
				END
		END

	CREATE TABLE HistorialPrecioProductosActualizados(
		PrecioActualizadoID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		ProductoID INT NOT NULL,
		NombreProducto NVARCHAR(50) NOT NULL,
		ProveedorID INT,
		PrecioUnitarioAnteior MONEY,
		PrecioUnitarioActualizado MONEY,
		FechaCambio DATETIME
	)

	CREATE PROCEDURE sp_cambiarPrecioUnitario
	@ProductoID INT,
	@PrecioNuevo MONEY
	AS
	BEGIN
		UPDATE Producto
		SET PrecioUnitario = @PrecioNuevo
		WHERE ProductoID = @ProductoID
	END

	EXEC sp_cambiarPrecioUnitario 1, 41

	SELECT * FROM HistorialPrecioProductosActualizados
	SELECT * FROM Producto

	-- ACTUALIZAR STOCK EN CADA VENTA
	CREATE TRIGGER trg_actualizarStock
	ON DetalleVenta
	AFTER INSERT
	AS
	BEGIN
		BEGIN TRY
        BEGIN TRANSACTION;
        -- Actualizamos el stock de los productos involucrados en la venta
        UPDATE Producto
        SET UnidadesEnStock = UnidadesEnStock - i.Cantidad
        FROM Producto p INNER JOIN inserted i ON p.ProductoID = i.ProductoID;

        -- Validación: si el stock de algún producto cae por debajo de 0, revertimos la transacción
        IF EXISTS ( SELECT * FROM Producto WHERE UnidadesEnStock < 0 )
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'No hay stock.';
            RETURN;
        END;

        COMMIT TRANSACTION;
        PRINT 'Stock actualizado correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Mostrar el mensaje de error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
	END

	EXEC sp_AgregarDetalleVenta 'Carlos', 'Alvarado', 1, 11, 25, 0.5
	select * from Venta
	select * from DetalleVenta
	select * from Producto

	-- INGRESAR PRODUCTO



-- PROVEEDOR
select * from Proveedor
select * from Empleado
UPDATE Empleado
SET NombreEmpleado = 'Camila', ApellidoEmpleado = 'Herrera'
WHERE EmpleadoID = 2

-- VENTA
select * from Venta

DBCC CHECKIDENT ('ComercialRita.dbo.Venta',RESEED, 10)
