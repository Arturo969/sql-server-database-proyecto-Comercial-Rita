-- Crear logins si no existen
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'LoginEmpleado1')
BEGIN
    CREATE LOGIN [LoginEmpleado1] WITH PASSWORD = 'TuContrase�aSegura1'
END

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'LoginEmpleado2')
BEGIN
    CREATE LOGIN [LoginEmpleado2] WITH PASSWORD = 'TuContrase�aSegura2'
END

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'LoginEmpleado3')
BEGIN
    CREATE LOGIN [LoginEmpleado3] WITH PASSWORD = 'TuContrase�aSegura3'
END

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'LoginAdmin')
BEGIN
    CREATE LOGIN [LoginAdmin] WITH PASSWORD = 'TuContrase�aSeguraAdmin'
END
GO