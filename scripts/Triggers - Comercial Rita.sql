use ComercialRita

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

	-- ELIMINAR PRODUCTO
	CREATE TRIGGER trg_eliminarProducto
	ON Producto
	INSTEAD OF DELETE
	AS
		BEGIN
			ROLLBACK TRANSACTION;
			--PRINT 'No se pueden eliminar ni actualizar los detalles de venta una vez procesados.'
			RAISERROR('No se permite eliminar un producto, solo se puede modificar le estado a "Descontinuado (1)".', 16, 1);
		END

	--PRUEBA
	DELETE Producto WHERE ProductoID = 117


-- EMPLEADO

	-- ELIMINAR EMPLEADO
	CREATE TRIGGER trg_eliminarEmpleado
	ON Empleado
	INSTEAD OF DELETE
	AS
		BEGIN
			ROLLBACK TRANSACTION;
			--PRINT 'No se pueden eliminar ni actualizar los detalles de venta una vez procesados.'
			RAISERROR('No se permite eliminar un Empleado, solo se puede modificar le estado a "Desempleado (3)".', 16, 1);
		END

	--PRUEBA
	DELETE Empleado WHERE EmpleadoID = 4

	-- Cambio de estado de un empleado
	CREATE TRIGGER trg_cambioEstadoEmpleado
	ON Empleado
	AFTER UPDATE
	AS
		BEGIN
			IF UPDATE(EstadoEmpleado)
				BEGIN
					-- Insertar registros en la tabla de auditoría
					INSERT INTO CambioEstadoEmpleado (EmpleadoID, NombreEmpleado, ApellidoEmpleado, EstadoAnterior, EstadoActual, FechaCambio)
					SELECT 
						d.EmpleadoID,              -- ID del empleado
						d.NombreEmpleado,          -- Nombre antes del cambio
						d.ApellidoEmpleado,        -- Apellido antes del cambio
						d.EstadoEmpleado AS EstadoAnterior, -- Estado anterior desde la tabla DELETED
						i.EstadoEmpleado AS EstadoActual,   -- Estado nuevo desde la tabla INSERTED
						GETDATE()                  -- Fecha y hora del cambio
					FROM DELETED d
					INNER JOIN INSERTED i ON d.EmpleadoID = i.EmpleadoID -- Relación entre registros antiguos y nuevos
					WHERE d.EstadoEmpleado != i.EstadoEmpleado; -- Solo registrar si hubo un cambio real
				END
		END


	CREATE TABLE CambioEstadoEmpleado (
		CambioEstadoID INT IDENTITY(1,1) PRIMARY KEY,
		EmpleadoID INT,
		NombreEmpleado NVARCHAR(50),
		ApellidoEmpleado NVARCHAR(50),
		EstadoAnterior INT,
		EstadoActual INT,
		FechaCambio DATETIME DEFAULT GETDATE()
	)

	SELECT * FROM CambioEstadoEmpleado
	SELECT * FROM Empleado

	UPDATE Empleado
	SET EstadoEmpleado = 2
	WHERE EmpleadoID = 2
	
