use ComercialRita

-- FUNCIONES
 -- 1. b.	Calcular Total
 CREATE FUNCTION fn_Total (@TotalBruto DECIMAL(10, 2), @descuento DECIMAL(10,2))
RETURNS DECIMAL(10, 2)
AS
BEGIN	
RETURN @TotalBruto * (1 - @descuento);
END;


--2. b.	Calcular TotalBruto
CREATE FUNCTION fn_TotalBruto (@PrecioUnitario MONEY, @cantidad DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
	RETURN @PrecioUnitario * @Cantidad;
END;


-- 3. Funcion que calcula el descuento:
CREATE FUNCTION fn_CalcularDescuento(@Cantidad DECIMAL(10, 2))
RETURNS DECIMAL(5, 2) -- El valor que devuelve es el porcentaje de descuento
AS
BEGIN
    DECLARE @Descuento DECIMAL(5, 2);
	
    IF @Cantidad >= 20 
    BEGIN
        SET @Descuento = 0.2; -- 20% de descuento si la cantidad es mayor o igual a 20 kilos
    END
    ELSE IF @Cantidad >= 5
    BEGIN
        SET @Descuento = 0.05; -- 5% de descuento si la cantidad es mayor o igual a 5 kilos
    END
    ELSE
    BEGIN
        SET @Descuento = 0; -- No hay descuento si la cantidad es menor a 5 kilos
    END

    RETURN @Descuento; -- Retornamos el valor de descuento calculado
END;
--Prueba
DECLARE @descuentoPorcentaje Decimal(10,2);
SET @descuentoPorcentaje = dbo.fn_CalcularDescuento(10);
PRINT @descuentoPorcentaje

--4. Crear una función que reciba un ID de cliente y devuelva su nombre completo concatenado (NombreCliente + ApellidoCliente).
CREATE FUNCTION dbo.GetNombreCompletoCliente (@ClienteID INT)
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @NombreCompleto NVARCHAR(101)
    SELECT @NombreCompleto = NombreCliente + ' ' + ApellidoCliente
    FROM Cliente
    WHERE ClienteID = @ClienteID
    RETURN @NombreCompleto
END

--Prueba
SELECT dbo.GetNombreCompletoCliente(1) AS NombreCompletoCliente


--5. Diseñar una función que calcule el total de una venta a partir del ID de venta, considerando el subtotal, los descuentos y el total final.
CREATE FUNCTION dbo.GetTotalVenta (@VentaID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(10, 2)
    SELECT @Total = SUM(Total)
    FROM DetalleVenta
    WHERE VentaID = @VentaID
    RETURN @Total
END

-- Prueba
SELECT dbo.GetTotalVenta(1) AS TotalVenta

--6. Escribir una función que reciba un ID de proveedor y devuelva el número total de productos que suministra.
CREATE FUNCTION dbo.GetNumeroProductosProveedor (@ProveedorID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumeroProductos INT
    SELECT @NumeroProductos = COUNT(*)
    FROM Producto
    WHERE ProveedorID = @ProveedorID
    RETURN @NumeroProductos
END

--prueba
SELECT dbo.GetNumeroProductosProveedor(1) AS NumeroProductosProveedor


-- 7. Cantidad de ventas realizadas por un empleado
CREATE FUNCTION dbo.GetNumeroVentasEmpleado (@EmpleadoID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumeroVentas INT
    SELECT @NumeroVentas = COUNT(*)
    FROM Venta
    WHERE EmpleadoID = @EmpleadoID
    RETURN @NumeroVentas
END

--prueba
SELECT dbo.GetNumeroVentasEmpleado(1) AS NumeroVentasEmpleado

--8. Crear una función que reciba el ID de una categoría y devuelva el número total de productos dentro de esa categoría.
CREATE FUNCTION dbo.GetNumeroProductosCategoria (@CategoriaID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumeroProductos INT
    SELECT @NumeroProductos = COUNT(*)
    FROM Producto
    WHERE CategoriaID = @CategoriaID
    RETURN @NumeroProductos
END

--prueba
SELECT dbo.GetNumeroProductosCategoria(1) AS NumeroProductosCategoria