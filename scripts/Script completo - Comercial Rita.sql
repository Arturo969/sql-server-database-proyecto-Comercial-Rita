IF DB_ID('ComercialRita') IS NOT NULL
BEGIN
   	USE MASTER
   	DROP DATABASE ComercialRita
END
CREATE DATABASE ComercialRita
GO
USE [ComercialRita]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CalcularDescuento]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_CalcularDescuento](@Cantidad DECIMAL(10, 2))
RETURNS DECIMAL(10, 2) -- El valor que devuelve es el porcentaje de descuento
AS
BEGIN
    DECLARE @Descuento DECIMAL(10, 2);
	
    IF @Cantidad >= 10
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
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Total]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Total] (@TotalBruto DECIMAL(10, 2), @descuento DECIMAL(10,2))
		RETURNS DECIMAL(10, 2)
		AS
			BEGIN
				RETURN @TotalBruto * (1 - @descuento);
			END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TotalBruto]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_TotalBruto] (@PrecioUnitario MONEY, @cantidad DECIMAL(10, 2))
		RETURNS DECIMAL(10, 2)
		AS
			BEGIN
				RETURN @PrecioUnitario * @Cantidad;
			END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetNombreCompletoCliente]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNombreCompletoCliente] (@ClienteID INT)
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @NombreCompleto NVARCHAR(101)
    SELECT @NombreCompleto = NombreCliente + ' ' + ApellidoCliente
    FROM Cliente
    WHERE ClienteID = @ClienteID
    RETURN @NombreCompleto
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumeroProductosCategoria]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNumeroProductosCategoria] (@CategoriaID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumeroProductos INT
    SELECT @NumeroProductos = COUNT(*)
    FROM Producto
    WHERE CategoriaID = @CategoriaID
    RETURN @NumeroProductos
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumeroProductosProveedor]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNumeroProductosProveedor] (@ProveedorID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumeroProductos INT
    SELECT @NumeroProductos = COUNT(*)
    FROM Producto
    WHERE ProveedorID = @ProveedorID
    RETURN @NumeroProductos
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumeroVentasEmpleado]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNumeroVentasEmpleado] (@EmpleadoID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumeroVentas INT
    SELECT @NumeroVentas = COUNT(*)
    FROM Venta
    WHERE EmpleadoID = @EmpleadoID
    RETURN @NumeroVentas
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetTotalVenta]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTotalVenta] (@VentaID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(10, 2)
    SELECT @Total = SUM(Total)
    FROM DetalleVenta
    WHERE VentaID = @VentaID
    RETURN @Total
END
GO
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 25/01/2025 13:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[VentaID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[PrecioUnitario] [int] NULL,
	[Cantidad] [decimal](10, 2) NOT NULL,
	[TotalBruto] [decimal](10, 2) NULL,
	[Descuento] [decimal](10, 2) NULL,
	[Total] [decimal](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[NombreCliente] [nvarchar](50) NOT NULL,
	[ApellidoCliente] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](15) NULL,
	[Direccion] [nvarchar](30) NULL,
	[DepartamentoID] [int] NULL,
	[CodigoPostal] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[EmpleadoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreEmpleado] [nvarchar](50) NOT NULL,
	[ApellidoEmpleado] [nvarchar](50) NOT NULL,
	[FechaContrato] [datetime] NULL,
	[Telefono] [nvarchar](15) NULL,
	[Direccion] [nvarchar](30) NULL,
	[FechaNacimiento] [datetime] NULL,
	[DepartamentoID] [int] NULL,
	[EstadoEmpleado] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpleadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[ProductoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreProducto] [nvarchar](50) NOT NULL,
	[CategoriaID] [int] NULL,
	[ProveedorID] [int] NULL,
	[PrecioUnitario] [money] NULL,
	[UnidadesEnStock] [decimal](10, 2) NULL,
	[Descontinuado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[VentaID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[FechaVenta] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VentaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VentasDetalladas]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VentasDetalladas] AS
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
/****** Object:  Table [dbo].[CategoriaProducto]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaProducto](
	[CategoriaID] [int] IDENTITY(1,1) NOT NULL,
	[NombreCategoria] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductosPorCategoria]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductosPorCategoria] AS
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
/****** Object:  View [dbo].[ClientesVentas]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ClientesVentas] AS
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
/****** Object:  View [dbo].[EmpleadosVentas]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmpleadosVentas] AS
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
/****** Object:  Table [dbo].[Proveedor]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor](
	[ProveedorID] [int] IDENTITY(1,1) NOT NULL,
	[NombreProveedor] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](15) NULL,
	[Direccion] [nvarchar](100) NULL,
	[DepartamentoID] [int] NULL,
	[AgenciaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProveedorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductosEnStock]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductosEnStock] AS
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
/****** Object:  View [dbo].[VentasFecha]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VentasFecha] AS
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
/****** Object:  View [dbo].[ProductosDescontinuados]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductosDescontinuados] AS
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
/****** Object:  Table [dbo].[Agencia]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agencia](
	[AgenciaID] [int] IDENTITY(1,1) NOT NULL,
	[NombreEmpresa] [nvarchar](20) NOT NULL,
	[Telefono] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[AgenciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[DepartamentoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreDepartamento] [nvarchar](20) NOT NULL,
	[PaisID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartamentoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialPrecioProductosActualizados]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialPrecioProductosActualizados](
	[PrecioActualizadoID] [int] IDENTITY(1,1) NOT NULL,
	[ProductoID] [int] NOT NULL,
	[NombreProducto] [nvarchar](50) NOT NULL,
	[ProveedorID] [int] NULL,
	[PrecioUnitarioAnteior] [money] NULL,
	[PrecioUnitarioActualizado] [money] NULL,
	[FechaCambio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrecioActualizadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[PaisID] [int] IDENTITY(1,1) NOT NULL,
	[NombrePais] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Agencia] ON 
GO
INSERT [dbo].[Agencia] ([AgenciaID], [NombreEmpresa], [Telefono]) VALUES (1, N'GilGal Cargo', NULL)
GO
INSERT [dbo].[Agencia] ([AgenciaID], [NombreEmpresa], [Telefono]) VALUES (3, N'Agencia Diaz', N'989826347')
GO
SET IDENTITY_INSERT [dbo].[Agencia] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoriaProducto] ON 
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (1, N'Frutos Secos', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (2, N'Frutos Deshidratados', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (3, N'Frutas Procesadas', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (4, N'Especias', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (5, N'Condimentos', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (6, N'Harinas', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (7, N'Legumbres', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (8, N'Hierbas y Tisanas', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (9, N'Semillas', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (10, N'Cereales', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (11, N'Ingredientes para Repostería', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (12, N'Endulzantes naturales', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (13, N'Chocolates', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (14, N'Aceites', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (15, N'Vinagres', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (16, N'Dulces', N'')
GO
INSERT [dbo].[CategoriaProducto] ([CategoriaID], [NombreCategoria], [Descripcion]) VALUES (17, N'Galletas integrales', N'')
GO
SET IDENTITY_INSERT [dbo].[CategoriaProducto] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (1, N'Anthonela', N'Limay', NULL, N'', 2, N'')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (2, N'Arnold', N'Ocas', NULL, N'', 2, N'')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (3, N'Arturo', N'Valdiviezo', NULL, N'', 2, N'')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (4, N'Darick', N'Pérez', NULL, N'', 2, N'')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (5, N'Sarah', N'Herrera', NULL, N'', 2, N'')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (6, N'Sarah Daniela Fernanda', N'Herrera Arias', N'976666666', N'Los Gladiolos 666', 2, N'06003')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (7, N'Jhonatan', N'Quispe', N'976566666', N'Hell 666', 3, N'13001')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (8, N'Andree', N'Anthonelloncio', N'+57 316 1121000', N'Four 666', 4, N'05001')
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (9, N'pepe', N'marin', N'923615871', NULL, NULL, NULL)
GO
INSERT [dbo].[Cliente] ([ClienteID], [NombreCliente], [ApellidoCliente], [Telefono], [Direccion], [DepartamentoID], [CodigoPostal]) VALUES (14, N'Carlos', N'Alvarado', NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Departamento] ON 
GO
INSERT [dbo].[Departamento] ([DepartamentoID], [NombreDepartamento], [PaisID]) VALUES (1, N'Lima', 1)
GO
INSERT [dbo].[Departamento] ([DepartamentoID], [NombreDepartamento], [PaisID]) VALUES (2, N'Cajamarca', 1)
GO
INSERT [dbo].[Departamento] ([DepartamentoID], [NombreDepartamento], [PaisID]) VALUES (3, N'La Libertad', 1)
GO
INSERT [dbo].[Departamento] ([DepartamentoID], [NombreDepartamento], [PaisID]) VALUES (4, N'Antioquia', 2)
GO
SET IDENTITY_INSERT [dbo].[Departamento] OFF
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (1, 2, 46, CAST(0.25 AS Decimal(10, 2)), CAST(11.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(11.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (1, 5, 56, CAST(0.25 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (1, 7, 74, CAST(0.25 AS Decimal(10, 2)), CAST(18.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (2, 69, 40, CAST(0.50 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (2, 70, 7, CAST(1.00 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (2, 71, 8, CAST(1.00 AS Decimal(10, 2)), CAST(8.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(8.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (3, 21, 60, CAST(0.50 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (3, 23, 20, CAST(0.25 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (3, 25, 36, CAST(1.00 AS Decimal(10, 2)), CAST(36.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(36.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (3, 26, 16, CAST(1.00 AS Decimal(10, 2)), CAST(16.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(16.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (4, 36, 15, CAST(0.10 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (4, 38, 15, CAST(0.10 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (5, 76, 8, CAST(0.50 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (5, 78, 9, CAST(0.50 AS Decimal(10, 2)), CAST(4.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(4.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (5, 71, 8, CAST(0.50 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (6, 7, 74, CAST(0.25 AS Decimal(10, 2)), CAST(18.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (7, 17, 14, CAST(1.00 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (7, 9, 24, CAST(0.25 AS Decimal(10, 2)), CAST(6.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (7, 11, 17, CAST(0.50 AS Decimal(10, 2)), CAST(8.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(8.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (8, 38, 15, CAST(0.10 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (8, 39, 12, CAST(0.10 AS Decimal(10, 2)), CAST(1.20 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (8, 40, 20, CAST(0.10 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (8, 41, 30, CAST(0.50 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (8, 36, 15, CAST(0.10 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (9, 2, 46, CAST(0.25 AS Decimal(10, 2)), CAST(11.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(11.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (9, 5, 56, CAST(0.25 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (9, 7, 74, CAST(0.25 AS Decimal(10, 2)), CAST(18.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (10, 18, 17, CAST(0.25 AS Decimal(10, 2)), CAST(4.25 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(4.25 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (10, 19, 17, CAST(0.50 AS Decimal(10, 2)), CAST(8.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(8.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (10, 20, 22, CAST(0.25 AS Decimal(10, 2)), CAST(5.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(5.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (11, 41, 30, CAST(0.50 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (11, 36, 15, CAST(0.10 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (11, 1, 44, CAST(0.50 AS Decimal(10, 2)), CAST(22.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(22.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (11, 25, 36, CAST(0.50 AS Decimal(10, 2)), CAST(18.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(18.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (11, 62, 72, CAST(1.00 AS Decimal(10, 2)), CAST(72.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(72.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DetalleVenta] ([VentaID], [ProductoID], [PrecioUnitario], [Cantidad], [TotalBruto], [Descuento], [Total]) VALUES (11, 70, 7, CAST(1.00 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Empleado] ON 
GO
INSERT [dbo].[Empleado] ([EmpleadoID], [NombreEmpleado], [ApellidoEmpleado], [FechaContrato], [Telefono], [Direccion], [FechaNacimiento], [DepartamentoID], [EstadoEmpleado]) VALUES (1, N'Pablo', N'Herrera', CAST(N'2024-03-25T00:00:00.000' AS DateTime), N'955967803', N'Jr. Juncos con Gladiolos', CAST(N'1987-01-07T00:00:00.000' AS DateTime), 2, N'Activo')
GO
INSERT [dbo].[Empleado] ([EmpleadoID], [NombreEmpleado], [ApellidoEmpleado], [FechaContrato], [Telefono], [Direccion], [FechaNacimiento], [DepartamentoID], [EstadoEmpleado]) VALUES (2, N'Camila', N'Herrera', CAST(N'2024-03-26T00:00:00.000' AS DateTime), N'', N'Jr. Tulipanes', CAST(N'2007-04-04T00:00:00.000' AS DateTime), 2, N'Activo')
GO
SET IDENTITY_INSERT [dbo].[Empleado] OFF
GO
SET IDENTITY_INSERT [dbo].[HistorialPrecioProductosActualizados] ON 
GO
INSERT [dbo].[HistorialPrecioProductosActualizados] ([PrecioActualizadoID], [ProductoID], [NombreProducto], [ProveedorID], [PrecioUnitarioAnteior], [PrecioUnitarioActualizado], [FechaCambio]) VALUES (1, 35, N'Pimienta entera', 2, 46.0000, 50.0000, CAST(N'2025-01-23T21:58:41.230' AS DateTime))
GO
INSERT [dbo].[HistorialPrecioProductosActualizados] ([PrecioActualizadoID], [ProductoID], [NombreProducto], [ProveedorID], [PrecioUnitarioAnteior], [PrecioUnitarioActualizado], [FechaCambio]) VALUES (2, 35, N'Pimienta entera', 2, 50.0000, 46.0000, CAST(N'2025-01-23T21:59:55.087' AS DateTime))
GO
INSERT [dbo].[HistorialPrecioProductosActualizados] ([PrecioActualizadoID], [ProductoID], [NombreProducto], [ProveedorID], [PrecioUnitarioAnteior], [PrecioUnitarioActualizado], [FechaCambio]) VALUES (3, 45, N'Anís estrella', 1, 90.0000, 85.0000, CAST(N'2025-01-24T19:09:05.283' AS DateTime))
GO
INSERT [dbo].[HistorialPrecioProductosActualizados] ([PrecioActualizadoID], [ProductoID], [NombreProducto], [ProveedorID], [PrecioUnitarioAnteior], [PrecioUnitarioActualizado], [FechaCambio]) VALUES (4, 45, N'Anís estrella', 1, 85.0000, 90.0000, CAST(N'2025-01-24T19:09:56.240' AS DateTime))
GO
INSERT [dbo].[HistorialPrecioProductosActualizados] ([PrecioActualizadoID], [ProductoID], [NombreProducto], [ProveedorID], [PrecioUnitarioAnteior], [PrecioUnitarioActualizado], [FechaCambio]) VALUES (5, 1, N'Almendras naturales', 1, 44.0000, 41.0000, CAST(N'2025-01-24T19:11:52.807' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[HistorialPrecioProductosActualizados] OFF
GO
SET IDENTITY_INSERT [dbo].[Pais] ON 
GO
INSERT [dbo].[Pais] ([PaisID], [NombrePais]) VALUES (1, N'Peru')
GO
INSERT [dbo].[Pais] ([PaisID], [NombrePais]) VALUES (2, N'Colombia')
GO
SET IDENTITY_INSERT [dbo].[Pais] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (1, N'Almendras naturales', 1, 1, 41.0000, CAST(4.50 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (2, N'Almendras tostadas', 1, 1, 46.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (3, N'Castañas de primera', 1, 1, 48.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (4, N'Cashews tostados', 1, 1, 44.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (5, N'Pistachos tostados', 1, 1, 56.0000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (6, N'Pecanas con cascara', 1, 1, 34.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (7, N'Pecanas peladas', 1, 1, 74.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (8, N'Pasas rubias grandes', 2, 2, 32.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (9, N'Pasas rubias pequeñas', 2, 2, 24.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (10, N'Pasas morenas importadas', 2, 2, 17.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (11, N'Pasas bebe', 2, 2, 18.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (12, N'Guindones con pepa', 2, 1, 20.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (13, N'Guindones sin pepa', 2, 1, 24.0000, CAST(2.50 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (14, N'Avellanas tostadas', 1, 1, 60.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (15, N'Nueces peladas', 1, 1, 46.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (16, N'Nueces con cascara', 1, 1, 22.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (17, N'Maní tostado partido', 1, 1, 14.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (18, N'Maní tostado bola', 1, 1, 17.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (19, N'Habas tostadas', 7, 1, 17.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (20, N'Flor de Jamaica', 8, 2, 22.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (21, N'Semilla de calabaza tostada', 9, 2, 60.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (22, N'Semilla de calabaza natural', 9, 2, 58.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (23, N'Semilla de girasol tostada', 9, 2, 20.0000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (24, N'Semilla de girasol tostado', 9, 2, 15.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (25, N'Sacha inchi tostado', 9, 2, 36.0000, CAST(8.50 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (26, N'Ajonjolí tostad imp', 9, 2, 16.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (27, N'Ajonjolí natural', 9, 2, 13.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (28, N'Ajonjolí negro', 9, 2, 20.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (29, N'Avena en hojuelas', 10, 1, 8.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (30, N'Coco rallado fino', 3, 1, 15.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (31, N'Coco rallado grueso', 3, 1, 18.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (32, N'Clavo de olor', 4, 2, 58.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (33, N'Bicarbonato', 11, 1, 7.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (34, N'Pimienta molida', 4, 2, 22.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (35, N'Pimienta entera', 4, 2, 46.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (36, N'Comino molido', 4, 2, 15.0000, CAST(6.90 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (37, N'Comino entero', 4, 2, 40.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (38, N'Tomillo molido', 4, 1, 15.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (39, N'Semillas de linaza', 9, 1, 12.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (40, N'Semilla de chía', 9, 1, 20.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (41, N'Canela en polvo', 4, 1, 30.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (42, N'Canela entera h1', 4, 2, 80.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (43, N'Orégano', 4, 2, 20.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (44, N'Laurel', 4, 2, 90.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (45, N'Anís estrella', 4, 1, 90.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (46, N'Cúrcuma molida', 4, 1, 15.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (47, N'Palillo molido', 4, 2, 8.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (48, N'Ajo en polvo', 4, 1, 30.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (49, N'Anís en grano', 4, 1, 26.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (50, N'Ajino moto a granel', 5, 1, 10.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (51, N'Colapiz importado', 11, 1, 50.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (52, N'Levadura', 11, 1, 18.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (53, N'Orégano molido', 4, 1, 16.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (55, N'Soya entera', 7, 2, 8.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (56, N'Romero molido', 4, 2, 16.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (57, N'Quinua lavada', 10, 2, 12.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (58, N'Kiwicha', 10, 1, 11.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (59, N'Porn corn', 10, 1, 5.5000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (60, N'Sal de maras fino', 5, 1, 10.0000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (61, N'Panela orgánica', 12, 2, 7.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (62, N'Nuez moscada', 4, 1, 72.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (63, N'Grajeas', 11, 1, 9.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (64, N'Lluvia de colores', 11, 1, 30.0000, CAST(2.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (65, N'Cebada tostada', 10, 1, 6.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (66, N'Chocolate Shilico', 13, 2, 8.0000, CAST(10.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (67, N'Harina de camote', 6, 2, 11.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (68, N'Harina de coca', 6, 2, 50.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (69, N'Harina de almendras', 6, 2, 40.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (70, N'Harina de 7 semillas', 6, 2, 7.0000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (71, N'Harina de maca', 6, 2, 8.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (72, N'Harina de plátano', 6, 2, 10.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (73, N'Harina de cañihua', 6, 2, 16.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (74, N'Harina de kiwicha', 6, 2, 10.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (75, N'Harina de quinua', 6, 2, 10.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (76, N'Soya molida', 6, 2, 8.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (77, N'Harina integral', 6, 2, 7.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (78, N'Ponche de habas', 6, 2, 9.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (79, N'Maizena', 6, 2, 9.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (80, N'Chuño ingles', 6, 2, 10.0000, CAST(6.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (81, N'Cocoa en polvo', 13, 1, 12.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (82, N'Cacao en polvo', 13, 1, 40.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (83, N'Cacao en nibs', 13, 1, 35.0000, CAST(10.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (84, N'Kiwicha pop', 10, 1, 18.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (85, N'Quinua pop', 10, 1, 18.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (86, N'Huesillos', 2, 2, 32.0000, CAST(9.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (87, N'Orejones', 2, 2, 50.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (88, N'Cereza deshidratada', 2, 2, 42.0000, CAST(4.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (89, N'Fresa deshidratada', 2, 2, 42.0000, CAST(3.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (90, N'Manzana deshidratada', 2, 2, 54.0000, CAST(1.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (91, N'Kiwi deshidratado', 2, 2, 32.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (92, N'Naranja deshidratada', 2, 2, 54.0000, CAST(5.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (93, N'Piña deshidratada', 2, 2, 40.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (94, N'Mango deshidratado', 2, 2, 54.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (95, N'Aguaymanto deshidratado', 2, 2, 38.0000, CAST(9.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (96, N'Arándano deshidratado entero', 2, 2, 32.0000, CAST(1.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (97, N'Mistura deshidratada', 2, 2, 60.0000, CAST(9.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (98, N'Bayas de goji', 2, 2, 60.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (99, N'Aceite coco de 250 ml ', 14, 4, 16.0000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (100, N'Aceite de oliva 500 ml ', 14, 4, 25.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (101, N'Aceite de oliva 1 lt ', 14, 4, 40.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (102, N'Vinagre de manzana lt ', 15, 4, 9.5000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (103, N'Aceite de sachainchi ', 14, 4, 20.0000, CAST(7.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (104, N'Aceite de ajonjoli ', 14, 4, 20.0000, CAST(6.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (105, N'Algarrobina ', 12, 1, 15.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (106, N'Stevia 50 g', 12, 3, 9.0000, CAST(5.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (107, N'Stevia 120 g', 12, 3, 15.0000, CAST(15.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (108, N'Stevia con yacón 120 g', 12, 3, 17.0000, CAST(8.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (109, N'Stevia con cuentagotas 100 ml', 12, 3, 22.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (110, N'Toffies de algarrobina ', 15, 4, 6.5000, CAST(2.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (111, N'Toffies de natilla ', 15, 4, 6.5000, CAST(1.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (112, N'Galletas integrales con coco 42 g', 17, 4, 2.0000, CAST(3.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (113, N'Galletas integrales con naranja 42 g', 17, 4, 2.0000, CAST(4.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (114, N'Galletas integrales con kiwicha 42 g', 17, 4, 2.0000, CAST(2.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (115, N'Galletas integrales con coco 100 g', 17, 4, 5.0000, CAST(0.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (116, N'Galletas integrales con naranja 100 g', 17, 4, 5.0000, CAST(0.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (117, N'Galletas integrales con kiwicha 100 g', 17, 4, 5.0000, CAST(0.00 AS Decimal(10, 2)), 0)
GO
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[Proveedor] ON 
GO
INSERT [dbo].[Proveedor] ([ProveedorID], [NombreProveedor], [Telefono], [Direccion], [DepartamentoID], [AgenciaID]) VALUES (1, N'FrutoLar', N'', N'1', 1, 1)
GO
INSERT [dbo].[Proveedor] ([ProveedorID], [NombreProveedor], [Telefono], [Direccion], [DepartamentoID], [AgenciaID]) VALUES (2, N'FlowersFood', N'', N'1', 1, 1)
GO
INSERT [dbo].[Proveedor] ([ProveedorID], [NombreProveedor], [Telefono], [Direccion], [DepartamentoID], [AgenciaID]) VALUES (3, N'Nutra Estevia', N'', N'1', 1, 1)
GO
INSERT [dbo].[Proveedor] ([ProveedorID], [NombreProveedor], [Telefono], [Direccion], [DepartamentoID], [AgenciaID]) VALUES (4, N'Liz Conde', N'', N'2', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta] ON 
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (1, 1, 1, CAST(N'2024-12-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (2, 3, 2, CAST(N'2024-12-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (3, 4, 2, CAST(N'2024-12-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (4, 1, 1, CAST(N'2024-12-04T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (5, 4, 1, CAST(N'2024-12-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (6, 3, 2, CAST(N'2024-12-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (7, 2, 1, CAST(N'2024-12-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (8, 1, 2, CAST(N'2024-12-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (9, 3, 2, CAST(N'2024-12-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (10, 1, 2, CAST(N'2024-12-10T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (11, 1, 1, CAST(N'2025-01-24T17:46:33.347' AS DateTime))
GO
INSERT [dbo].[Venta] ([VentaID], [ClienteID], [EmpleadoID], [FechaVenta]) VALUES (12, 5, 1, CAST(N'2025-01-25T11:45:42.447' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
ALTER TABLE [dbo].[DetalleVenta] ADD  DEFAULT ((0)) FOR [Descuento]
GO
ALTER TABLE [dbo].[Empleado] ADD  CONSTRAINT [DF_Empleado_FechaContrato]  DEFAULT (NULL) FOR [FechaContrato]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ('Activo') FOR [EstadoEmpleado]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((0)) FOR [PrecioUnitario]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((0)) FOR [UnidadesEnStock]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD FOREIGN KEY([DepartamentoID])
REFERENCES [dbo].[Departamento] ([DepartamentoID])
GO
ALTER TABLE [dbo].[Departamento]  WITH CHECK ADD FOREIGN KEY([PaisID])
REFERENCES [dbo].[Pais] ([PaisID])
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Producto] ([ProductoID])
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([VentaID])
REFERENCES [dbo].[Venta] ([VentaID])
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_DepartamentoID] FOREIGN KEY([DepartamentoID])
REFERENCES [dbo].[Departamento] ([DepartamentoID])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_DepartamentoID]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([CategoriaID])
REFERENCES [dbo].[CategoriaProducto] ([CategoriaID])
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([ProveedorID])
REFERENCES [dbo].[Proveedor] ([ProveedorID])
GO
ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD FOREIGN KEY([DepartamentoID])
REFERENCES [dbo].[Departamento] ([DepartamentoID])
GO
ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_AgenciaID] FOREIGN KEY([AgenciaID])
REFERENCES [dbo].[Agencia] ([AgenciaID])
GO
ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [FK_AgenciaID]
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Cliente] ([ClienteID])
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD FOREIGN KEY([EmpleadoID])
REFERENCES [dbo].[Empleado] ([EmpleadoID])
GO
ALTER TABLE [dbo].[Agencia]  WITH CHECK ADD  CONSTRAINT [chk_TelefonoPositivo3] CHECK  ((NOT [Telefono] like '-%'))
GO
ALTER TABLE [dbo].[Agencia] CHECK CONSTRAINT [chk_TelefonoPositivo3]
GO
ALTER TABLE [dbo].[Agencia]  WITH CHECK ADD  CONSTRAINT [Telefono] CHECK  (([Telefono]>(0)))
GO
ALTER TABLE [dbo].[Agencia] CHECK CONSTRAINT [Telefono]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [chk_TelefonoPositivo] CHECK  ((NOT [Telefono] like '-%'))
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [chk_TelefonoPositivo]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [chk_TelefonoPositivo1] CHECK  ((NOT [Telefono] like '-%'))
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [chk_TelefonoPositivo1]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [chk_PrecioUnitario1] CHECK  (([PrecioUnitario]>(0)))
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [chk_PrecioUnitario1]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [chk_UnidadesEnStock] CHECK  (([UnidadesEnStock]>=(0)))
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [chk_UnidadesEnStock]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD CHECK  (([PrecioUnitario]>=(0)))
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD CHECK  (([UnidadesEnStock]>=(0)))
GO
ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [chk_TelefonoPositivo2] CHECK  ((NOT [Telefono] like '-%'))
GO
ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [chk_TelefonoPositivo2]
GO
/****** Object:  StoredProcedure [dbo].[sp_AgregarDetalleVenta]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AgregarDetalleVenta]
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
        
				DECLARE @Descuento DECIMAL (10,2);
				SET @Descuento = dbo.fn_CalcularDescuento(@Cantidad);

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
GO
/****** Object:  StoredProcedure [dbo].[sp_cambiarPrecioUnitario]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cambiarPrecioUnitario]
	@ProductoID INT,
	@PrecioNuevo MONEY
	AS
	BEGIN
		UPDATE Producto
		SET PrecioUnitario = @PrecioNuevo
		WHERE ProductoID = @ProductoID
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_ingresarNuevaVenta]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ingresarNuevaVenta]
@ClienteID INT,
@EmpleadoID INT
AS
	BEGIN
		INSERT INTO Venta (ClienteID, EmpleadoID, FechaVenta)
		VALUES (@ClienteID, @EmpleadoID, GETDATE())
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarCliente]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarCliente]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarSoloNombreYApellidoCliente]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarSoloNombreYApellidoCliente]
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
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerVentasPorCliente]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerVentasPorCliente]
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
/****** Object:  Trigger [dbo].[trg_actualizarPrecio]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_actualizarPrecio]
	ON [dbo].[DetalleVenta]
	INSTEAD OF DELETE, UPDATE
	AS
		BEGIN
			ROLLBACK TRANSACTION;
			--PRINT 'No se pueden eliminar ni actualizar los detalles de venta una vez procesados.'
			RAISERROR('No se permite eliminar ni actualizar registros en la tabla DetalleVenta.', 16, 1);
		END
GO
ALTER TABLE [dbo].[DetalleVenta] ENABLE TRIGGER [trg_actualizarPrecio]
GO
/****** Object:  Trigger [dbo].[trg_actualizarStock]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_actualizarStock]
	ON [dbo].[DetalleVenta]
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
GO
ALTER TABLE [dbo].[DetalleVenta] ENABLE TRIGGER [trg_actualizarStock]
GO
/****** Object:  Trigger [dbo].[trg_CalcularTotales]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_CalcularTotales]
	ON [dbo].[DetalleVenta]
	AFTER INSERT
	AS
		BEGIN
			UPDATE DetalleVenta
			SET DetalleVenta.PrecioUnitario = p.PrecioUnitario, TotalBruto = dbo.fn_TotalBruto(p.PrecioUnitario, i.Cantidad),
				Total = dbo.fn_Total(dbo.fn_TotalBruto(p.PrecioUnitario, i.Cantidad), (i.Descuento))
			FROM DetalleVenta dv INNER JOIN inserted i ON dv.VentaID = i.VentaID AND dv.ProductoID = i.ProductoID
				INNER JOIN Producto p ON p.ProductoID = i.ProductoID;
		END
GO
ALTER TABLE [dbo].[DetalleVenta] ENABLE TRIGGER [trg_CalcularTotales]
GO
/****** Object:  Trigger [dbo].[trg_insertarUltimaVenta]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_insertarUltimaVenta]
	ON [dbo].[DetalleVenta]
	AFTER INSERT
	AS
		BEGIN
			IF EXISTS ( SELECT * FROM inserted i WHERE i.VentaID < (SELECT MAX(VentaID) FROM Venta) )
				BEGIN
					ROLLBACK TRANSACTION;
					RAISERROR('No se permite insertar un producto a ventas anteriores a la última.', 16, 1);
				END
		END
GO
ALTER TABLE [dbo].[DetalleVenta] ENABLE TRIGGER [trg_insertarUltimaVenta]
GO
/****** Object:  Trigger [dbo].[trg_preciosActualizados]    Script Date: 25/01/2025 13:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_preciosActualizados]
	ON [dbo].[Producto]
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
GO
ALTER TABLE [dbo].[Producto] ENABLE TRIGGER [trg_preciosActualizados]
GO
