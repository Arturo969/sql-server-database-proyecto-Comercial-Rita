IF DB_ID('ComercialRita') IS NOT NULL
BEGIN
   	USE MASTER
   	DROP DATABASE ComercialRita
END
CREATE DATABASE ComercialRita
GO
USE [ComercialRita]
GO
/****** Object:  Table [dbo].[Agencia]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[CategoriaProducto]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[Departamento]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 22/01/2025 0:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[VentaID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[PrecioUnitario] [int] NOT NULL,
	[Cantidad] [decimal](10, 2) NOT NULL,
	[TotalBruto] [decimal](10, 2) NOT NULL,
	[Descuento] [decimal](10, 2) NOT NULL,
	[Total] [decimal](10, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 22/01/2025 0:43:15 ******/
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
PRIMARY KEY CLUSTERED 
(
	[EmpleadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[Proveedor]    Script Date: 22/01/2025 0:43:15 ******/
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
/****** Object:  Table [dbo].[Venta]    Script Date: 22/01/2025 0:43:15 ******/
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
SET IDENTITY_INSERT [dbo].[Agencia] ON 
GO
INSERT [dbo].[Agencia] ([AgenciaID], [NombreEmpresa], [Telefono]) VALUES (1, N'GilGal Cargo', NULL)
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
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Departamento] ON 
GO
INSERT [dbo].[Departamento] ([DepartamentoID], [NombreDepartamento], [PaisID]) VALUES (1, N'Lima', 1)
GO
INSERT [dbo].[Departamento] ([DepartamentoID], [NombreDepartamento], [PaisID]) VALUES (2, N'Cajamarca', 1)
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
SET IDENTITY_INSERT [dbo].[Empleado] ON 
GO
INSERT [dbo].[Empleado] ([EmpleadoID], [NombreEmpleado], [ApellidoEmpleado], [FechaContrato], [Telefono], [Direccion], [FechaNacimiento], [DepartamentoID]) VALUES (1, N'Herrera', N'Pablo', CAST(N'2024-03-25T00:00:00.000' AS DateTime), N'955967803', N'Jr. Juncos con Gladiolos', CAST(N'1987-01-07T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[Empleado] ([EmpleadoID], [NombreEmpleado], [ApellidoEmpleado], [FechaContrato], [Telefono], [Direccion], [FechaNacimiento], [DepartamentoID]) VALUES (2, N'Herrera', N'Camila', CAST(N'2024-03-26T00:00:00.000' AS DateTime), N'', N'Jr. Tulipanes', CAST(N'2007-04-04T00:00:00.000' AS DateTime), 2)
GO
SET IDENTITY_INSERT [dbo].[Empleado] OFF
GO
SET IDENTITY_INSERT [dbo].[Pais] ON 
GO
INSERT [dbo].[Pais] ([PaisID], [NombrePais]) VALUES (1, N'Peru')
GO
SET IDENTITY_INSERT [dbo].[Pais] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (1, N'Almendras naturales', 1, 1, 44.0000, CAST(5.00 AS Decimal(10, 2)), 0)
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
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (13, N'Guindones sin pepa', 2, 1, 24.0000, CAST(3.00 AS Decimal(10, 2)), 0)
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
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (25, N'Sacha inchi tostado', 9, 2, 36.0000, CAST(9.00 AS Decimal(10, 2)), 0)
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
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (36, N'Comino molido', 4, 2, 15.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (37, N'Comino entero', 4, 2, 40.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (38, N'Tomillo molido', 4, 1, 15.0000, CAST(9.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (39, N'Semillas de linaza', 9, 1, 12.0000, CAST(10.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (40, N'Semilla de chía', 9, 1, 20.0000, CAST(7.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (41, N'Canela en polvo', 4, 1, 30.0000, CAST(7.00 AS Decimal(10, 2)), 0)
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
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (62, N'Nuez moscada', 4, 1, 72.0000, CAST(10.00 AS Decimal(10, 2)), 0)
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
INSERT [dbo].[Producto] ([ProductoID], [NombreProducto], [CategoriaID], [ProveedorID], [PrecioUnitario], [UnidadesEnStock], [Descontinuado]) VALUES (70, N'Harina de 7 semillas', 6, 2, 7.0000, CAST(5.00 AS Decimal(10, 2)), 0)
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
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
ALTER TABLE [dbo].[Empleado] ADD  CONSTRAINT [DF_Empleado_FechaContrato]  DEFAULT (NULL) FOR [FechaContrato]
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
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD CHECK  (([PrecioUnitario]>=(0)))
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD CHECK  (([UnidadesEnStock]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [ComercialRita] SET  READ_WRITE 
GO
