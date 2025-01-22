--Procedimiento almacenado: para insertar Cliente
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

		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	end catch
end;
go

exec sp_InsertarCliente 'Sarah Daniela Fernanda', 'Herrera Arias', 'Los Gladiolos 666', 'Cajamarca', 'Peru', '976666666', '06003';
go
exec sp_InsertarCliente 'Jhonatan', 'Quispe', 'Hell 666', 'La Libertad', 'Peru', '976566666', '13001';
go
exec sp_InsertarCliente 'Andree', 'Anthonelloncio', 'Four 666', 'Antioquia', 'Colombia', '+57 316 1121000', '05001';
go



---Procedimiento almacenado para optener ventas por cliente:
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
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

exec sp_ObtenerVentasPorCliente 1
go



select * from Proveedor
select * from Agencia
select * from CategoriaProducto
select * from Pais
select * from Departamento
select * from Cliente
select * from Producto
select * from Venta
select * from DetalleVenta
select * from Empleado