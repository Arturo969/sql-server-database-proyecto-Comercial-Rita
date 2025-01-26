USE ComercialRita

-- PROCEDIMIENTOS ALMACENADOS--

--1. Procedimiento almacenado: para insertar Cliente
use ComercialRita
go

create procedure sp_InsertarCliente
	@NombreCliente nvarchar(50),
	@ApellidoCliente nvarchar(50),
	@Direccion nvarchar(30),
	@NombreDepartamento nvarchar(20),
	@NombrePais nvarchar(20),
	@Telefono nvarchar(15),
	@CodigoPostal nvarchar(10)
as
begin
	begin try
		begin transaction;
		
		--recupera el id del pais
		declare @PaisID int;
		select @PaisID = PaisID
		from Pais
		where NombrePais = @NombrePais;
		
		--si no existe el pais lo inserta en la tabla pais
		if @PaisID is null
		begin
			insert into Pais (NombrePais)
			values (@NombrePais);

			set @PaisID = SCOPE_IDENTITY(); --devuelve la ultima identidad insertada en el mismo ambito
		end

		--recupera el id del departamento
		declare @DepartamentoID int;
		select @DepartamentoID = DepartamentoID
		from Departamento
		where NombreDepartamento = @NombreDepartamento
			and PaisID = @PaisID;

		if @DepartamentoID is null
		begin
			insert into Departamento (NombreDepartamento,PaisID)
			values(@NombreDepartamento,@PaisID);

			set @DepartamentoID = SCOPE_IDENTITY();
		end

		--inserta cliente
		insert into Cliente (NombreCliente,ApellidoCliente,Telefono,Direccion,DepartamentoID,CodigoPostal)
		values (@NombreCliente, @ApellidoCliente, @Telefono, @Direccion, @DepartamentoID, @CodigoPostal);


		commit transaction;
		print 'Cliente insertado correctamente';
	end try
	begin catch
		rollback transaction;
		PRINT 'Fallo al insertar Cliente';
	end catch
end;
go
--Prueba:
exec sp_InsertarCliente 'Sarah Daniela Fernanda', 'Herrera Arias', 'Los Gladiolos 666', 'Cajamarca', 'Peru', '976666666', '06003';
go
exec sp_InsertarCliente 'Jony', 'Quispe', 'Hell 777', 'Ayacucho', 'Peru', '97656656', '13501';
go
exec sp_InsertarCliente 'Andree', 'Anthonelloncio', 'Four 666', 'Antioquia', 'Colombia', '+57 316 1121000', '05001';
go

select * from Cliente



-- 2. Procedimiento almacenado para optener ventas por cliente:
CREATE PROCEDURE sp_ObtenerVentasPorCliente
    @ClienteID INT -- Identificador del cliente para filtrar las ventas
AS
BEGIN
    BEGIN TRY
        -- Consulta detallada de las ventas del cliente
        SELECT 
            c.ClienteID,
            CONCAT(c.NombreCliente, ' ', c.ApellidoCliente) AS NombreCompletoCliente,
            v.VentaID,
            v.FechaVenta,
            P.NombreProducto,
            dv.Cantidad,
            dv.PrecioUnitario,
			dv.TotalBruto,
			dv.Descuento,
            dv.Total AS TotalVenta
        FROM 
            Venta v
        INNER JOIN 
            Cliente c ON v.ClienteID = c.ClienteID
        INNER JOIN 
            DetalleVenta dv ON v.VentaID = dv.VentaID
        INNER JOIN 
            Producto p ON dv.ProductoID = p.ProductoID
        WHERE 
            c.ClienteID = @ClienteID
        ORDER BY 
            v.FechaVenta DESC; -- Ordena las ventas por fecha de manera descendente
    END TRY
    BEGIN CATCH
        
		PRINT 'Fallo Obtener los datos'
        
    END CATCH
END;
GO

exec sp_ObtenerVentasPorCliente 4
go


-- 3. Procedimiento almacenado: Ingresar solo Nombre y Apellido de un Cliente
CREATE PROCEDURE sp_InsertarSoloNombreYApellidoCliente
@Nombre NVARCHAR(50),
@Apellido NVARCHAR(50)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
			INSERT INTO Cliente(NombreCliente, ApellidoCliente)
			VALUES (@Nombre, @Apellido);

		COMMIT TRANSACTION;
		PRINT 'Cliente insertado correctamente';
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
END

-- Prueba
EXEC sp_InsertarSoloNombreYApellidoCliente 'Pepe', 'Marin'

SELECT * FROM Cliente


-- 4. Procedimiento almacenado: Ingresar Nueva Venta
CREATE PROCEDURE sp_ingresarNuevaVenta
@ClienteID INT,
@EmpleadoID INT
AS
	BEGIN
		INSERT INTO Venta (ClienteID, EmpleadoID, FechaVenta)
		VALUES (@ClienteID, @EmpleadoID, GETDATE())
	END

-- Prueba
EXEC sp_ingresarNuevaVenta 5, 1


-- 5. LA INSERCIÓN DE DETALLE DE VENTA
	
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

-- 6. Cambiar Precio del Producto

CREATE PROCEDURE sp_cambiarPrecioUnitario
	@ProductoID INT,
	@PrecioNuevo MONEY
	AS
	BEGIN
		UPDATE Producto
		SET PrecioUnitario = @PrecioNuevo
		WHERE ProductoID = @ProductoID
	END

-- Prueba
EXEC sp_cambiarPrecioUnitario 1, 41

-- 7. Ingresar Nuevo Empleado
	CREATE PROCEDURE sp_ingresarNuevoEmpleado
	@NombreEmpleado NVARCHAR(15),
	@ApellidoEmpleado NVARCHAR(15),
	@FechaContrato DATETIME,
	@Telefono NVARCHAR(15),
	@Direccion NVARCHAR(30),
	@FechaNacimiento DATETIME,
	@DepartamentoID INT,
	@EstadoEmpleado INT
	AS
	BEGIN
		SET @FechaContrato = GETDATE();

		INSERT INTO Empleado(NombreEmpleado, ApellidoEmpleado, FechaContrato, Telefono, Direccion, FechaNacimiento, DepartamentoID, EstadoEmpleado)
		VALUES (@NombreEmpleado, @ApellidoEmpleado, @FechaContrato, @Telefono, @Direccion, @FechaNacimiento, @DepartamentoID, @EstadoEmpleado)
	END

--Prueba
	EXEC sp_ingresarNuevoEmpleado 'Eduardo', 'Herrera', NULL , NULL, NULL, NULL, NULL, 1
