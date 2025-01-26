use ComercialRita

--Vista de ventas detalladas
CREATE VIEW VentasDetalladas AS
SELECT 
    v.VentaID,
    c.NombreCliente,
    c.ApellidoCliente,
    e.NombreEmpleado,
    e.ApellidoEmpleado,
    v.FechaVenta,
    dv.ProductoID,
    p.NombreProducto,
    dv.Cantidad,
    dv.PrecioUnitario,
    dv.Total
FROM 
    Venta v
INNER JOIN 
    Cliente c ON v.ClienteID = c.ClienteID
INNER JOIN 
    Empleado e ON v.EmpleadoID = e.EmpleadoID
INNER JOIN 
    DetalleVenta dv ON v.VentaID = dv.VentaID
INNER JOIN 
    Producto p ON dv.ProductoID = p.ProductoID;
GO
--PRUEBA
SELECT*FROM VentasDetalladas

--Vista de productos por categoría
CREATE VIEW ProductosPorCategoria AS
SELECT 
    cp.NombreCategoria,
    p.ProductoID,
    p.NombreProducto,
    p.PrecioUnitario,
    p.UnidadesEnStock
FROM 
    Producto p
INNER JOIN 
    CategoriaProducto cp ON p.CategoriaID = cp.CategoriaID
GO
--PRUEBA
SELECT * FROM ProductosPorCategoria
ORDER BY NombreCategoria, NombreProducto;

--Vista de proveedores por departamento
CREATE VIEW ProveedoresPorDepartamento AS
SELECT 
    d.NombreDepartamento,
    p.ProveedorID,
    p.NombreProveedor,
    p.Telefono,
    p.Direccion
FROM 
    Proveedor p
INNER JOIN 
    Departamento d ON p.DepartamentoID = d.DepartamentoID
GO
--PRUEBA
SELECT*FROM ProveedoresPorDepartamento
ORDER BY NombreProveedor;

--Vista de ventas a clientes
CREATE VIEW ClientesVentas AS
SELECT 
    c.ClienteID,
    c.NombreCliente,
    c.ApellidoCliente,
    COUNT(v.VentaID) AS TotalVentas,
    SUM(dv.Total) AS TotalPagado
FROM 
    Cliente c
INNER JOIN 
    Venta v ON c.ClienteID = v.ClienteID
INNER JOIN 
    DetalleVenta dv ON v.VentaID = dv.VentaID
GROUP BY c.ClienteID, c.NombreCliente, c.ApellidoCliente;
GO
--PRUEBA
SELECT*FROM ClientesVentas


--Vista de empleados y ventas
CREATE VIEW EmpleadosVentas AS
SELECT 
    e.EmpleadoID,
    e.NombreEmpleado,
    e.ApellidoEmpleado,
    COUNT(v.VentaID) AS TotalVentas,
    SUM(dv.Total) AS TotalVendido
FROM 
    Empleado e
INNER JOIN 
    Venta v ON v.EmpleadoID =  e.EmpleadoID 
INNER JOIN 
    DetalleVenta dv ON  dv.VentaID = v.VentaID 
GROUP BY 
    e.EmpleadoID, e.NombreEmpleado, e.ApellidoEmpleado;
GO
--PRUEBA
SELECT*FROM EmpleadosVentas

--Vista de productos en Stock
CREATE VIEW ProductosEnStock AS
SELECT 
    p.ProductoID,
    p.NombreProducto,
    p.UnidadesEnStock,
    cp.NombreCategoria,
    pr.NombreProveedor
FROM 
    Producto p
JOIN 
    CategoriaProducto cp ON p.CategoriaID = cp.CategoriaID
JOIN 
    Proveedor pr ON p.ProveedorID = pr.ProveedorID
WHERE 
    p.UnidadesEnStock > 0
GO
--PRUEBA
SELECT*FROM ProductosEnStock ORDER BY NombreProducto;

--Vista de ventas por fecha
CREATE VIEW VentasFecha AS
SELECT 
    v.VentaID,
    v.FechaVenta,
    c.NombreCliente,
    c.ApellidoCliente,
    SUM(dv.Total) AS TotalVenta
FROM 
    Venta v
INNER JOIN 
    Cliente c ON v.ClienteID = c.ClienteID
INNER JOIN 
    DetalleVenta dv ON v.VentaID = dv.VentaID
GROUP BY 
    v.VentaID, v.FechaVenta, c.NombreCliente, c.ApellidoCliente;  -- Asegúrate de incluir todas las columnas no agregadas aquí
GO
--PRUEBA
SELECT*FROM VentasFecha ORDER BY FechaVenta DESC;
--SELECT*FROM DetalleVenta
--SELECT*FROM Venta

--Vista para productos descontinuados
CREATE VIEW ProductosDescontinuados AS
SELECT 
    p.ProductoID,
    p.NombreProducto,
    p.CategoriaID,
    p.PrecioUnitario,
    p.UnidadesEnStock,
    p.Descontinuado
FROM 
    Producto p
WHERE 
    p.Descontinuado = 1;  
GO
--PRUEBA
SELECT*FROM ProductosDescontinuados

-- Empleados Desempleados
CREATE VIEW v_empleadosDesempleados
	AS
		SELECT *
		FROM Empleado
		WHERE EstadoEmpleado = '3'

--PRUEBA
SELECT*FROM v_empleadosDesempleados

-- Empleados Activos
CREATE VIEW v_empleadosActivos
	AS
		SELECT *
		FROM Empleado
		WHERE EstadoEmpleado = '1'

--PRUEBA
SELECT*FROM v_empleadosActivos


