--ADMINISTRADOR:
-- Crear el Login (a nivel de servidor)
CREATE LOGIN LoginAdmin WITH PASSWORD = 'Admin123';

-- Crear el Usuario en la Base de Datos (a nivel de base de datos)
USE ComercialRita; -- Reemplaza con el nombre de tu base de datos
GO

CREATE USER AdminU FOR LOGIN LoginAdmin;

-- Crear el Rol Administrador en la Base de Datos
CREATE ROLE Administrador;

-- Agregar el Usuario al Rol Administrador
ALTER ROLE Administrador ADD MEMBER AdminU;

-- Otorgar TODOS los permisos al Rol Administrador
GRANT CONTROL TO Administrador;

-- Verificar la Configuración
-- Ver usuarios asignados al rol
SELECT r.name AS Rol, m.name AS Miembro
FROM sys.database_principals r
INNER JOIN sys.database_role_members rm ON r.principal_id = rm.role_principal_id
INNER JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
WHERE r.name = 'Administrador';

-- Ver permisos asignados al rol
SELECT permission_name, state_desc, class_desc
FROM sys.database_permissions
WHERE grantee_principal_id = DATABASE_PRINCIPAL_ID('Administrador');



--EMPLEADOS:
-- Crear los Logins (a nivel de servidor)
CREATE LOGIN LoginEmpleado1 WITH PASSWORD = 'Empleado1';
CREATE LOGIN LoginEmpleado2 WITH PASSWORD = 'Empleado2';
CREATE LOGIN LoginEmpleado3 WITH PASSWORD = 'Empleado3';

-- Crear Usuarios en la Base de Datos (a nivel de base de datos)
USE [ComercialRita]; -- Reemplaza con el nombre de tu base de datos
GO

CREATE USER EmpleadoU1 FOR LOGIN LoginEmpleado1;
CREATE USER EmpleadoU2 FOR LOGIN LoginEmpleado2;
CREATE USER EmpleadoU3 FOR LOGIN LoginEmpleado3;

-- Crear el Rol en la Base de Datos
CREATE ROLE EmpleadoR1;

-- Agregar Usuarios al Rol
ALTER ROLE EmpleadoR1 ADD MEMBER EmpleadoU1;
ALTER ROLE EmpleadoR1 ADD MEMBER EmpleadoU2;
ALTER ROLE EmpleadoR1 ADD MEMBER EmpleadoU3;

-- Otorgar permisos al Rol
-- Permiso para conectar a la base de datos
GRANT CONNECT TO EmpleadoR1;

-- Permiso para insertar en todas las tablas de la base de datos
GRANT INSERT TO EmpleadoR1;

-- Permiso para seleccionar todas las tablas y vistas de la base de datos
GRANT SELECT TO EmpleadoR1;



-- Verificar la configuración
-- Ver usuarios asignados al rol
SELECT r.name AS Rol, m.name AS Miembro
FROM sys.database_principals r
INNER JOIN sys.database_role_members rm ON r.principal_id = rm.role_principal_id
INNER JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
WHERE r.name = 'EmpleadoR1';

-- Ver permisos asignados al rol
SELECT permission_name, state_desc, class_desc
FROM sys.database_permissions
WHERE grantee_principal_id = DATABASE_PRINCIPAL_ID('EmpleadoR1');
