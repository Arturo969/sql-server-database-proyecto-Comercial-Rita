# sql-server-database-proyecto-Comercial-Rita
Este proyecto contiene el diseño, implementación y datos iniciales de la base de datos requerida para el curso de Base de Datos II de la Universidad Nacional de Cajamarca.

Integrantes de Equipo:
- Limay Rodriguez, Adriana Anthonela.
- Perez Briceño, Darick André.
- Herrera Arias, Sarah Daniela Fernanda.
- Ocas Ruiz, Arnold Michel.
- Valdiviezo Zavaleta, Jesús Arturo.

## Contenido  
- `scripts/`: Contiene los scripts principales para crear la base de datos. Además, los scrips usados en la implementación de vistas, procedimientos almacenados, funciones, triggers y la asignación de logins, usuarios y roles.  
- `data/`: Datos iniciales o de ejemplo.  
- `backups/`: Scripts para programar los backups en la base de datos y descripción del uso de Amazone S3 para el almacenamiento en el Storage
- `diagrams/`: Diagramas y representaciones visuales del esquema.  
- `docs/`: Documentación adicional del proyecto y Diseño inicial.  

## Requisitos
- SQL Server 2019 o superior.  
- SQL Server Management Studio (SSMS).
- Amazon S3.

## Instalación  
1. Clona este repositorio o descargalo en .ZIP
2. Ejecuta los scripts en `scripts/` en el siguiente orden:  
    - `Script Completo - Comercial Rita.sql`
    - `CrearLogins.sql` (Estos logins son referenciales. Pueden ser modificados o personalizados. Pero deben ser 4, 3 para empleados y 1 para Administrador)
## Bakup | Storage
- En `backups/`, se encuentran los scripts de los backups Completos, Diferenciales y de Transacciones implementados para el uso del Storage.
