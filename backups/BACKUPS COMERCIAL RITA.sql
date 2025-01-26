--BACKUPS COMERCIAL RITA

--Backup completo
DECLARE @BackupFileName NVARCHAR(225);
DECLARE @FechaHora NVARCHAR(20);
SET @FechaHora = FORMAT (GETDATE(),'yyyyMMdd_HHmmmss')
SET @BackupFileName = 'C:\Backups\ComercialRita\ComercialRitaCompletoMensual_' + @FechaHora + '.bak';
BACKUP DATABASE ComercialRita TO DISK = @BackupFileName 
WITH FORMAT, INIT, NAME = 'BackupComercialRitaCompletoMensual';

--Backup diferencial al día
DECLARE @BackupFileName NVARCHAR(225);
DECLARE @FechaHora NVARCHAR(20);
SET @FechaHora = FORMAT (GETDATE(),'yyyyMMdd_HHmmmss')
SET @BackupFileName = 'C:\Backups\ComercialRita\ComercialRitaDiferencialAlDia_' + @FechaHora + '.bak';
BACKUP DATABASE ComercialRita TO DISK = @BackupFileName 
WITH DIFFERENTIAL, INIT, NAME = 'BackupComercialRitaDiferencialAlDia';

--Backup transacciones a la hora
DECLARE @BackupFileName NVARCHAR(225);
DECLARE @FechaHora NVARCHAR(20);
SET @FechaHora = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');
SET @BackupFileName = 'C:\Backups\ComercialRita\ComercialRitaLogTransaccionesCadaHora_' + @FechaHora + '.trn';
BACKUP LOG ComercialRita 
TO DISK = @BackupFileName 
WITH INIT, NAME = 'Backup ComercialRita Log de Transacciones';

--PARA PODER USAR AMAZON S3
/*Debemos realizar lo siguiente:
1. Crear nuestro usuario en la plataforma de AWS de Amazon
2. Ir al servicio de IAM y crearnos un nuevo usuario
3. Luego de crear el usuario, dandole permisos para S3, o Interfaz de línea de comandos (CLI), ir al apartado de credenciales de seguridad y crear una llave de acceso
4. Después de crear la llave de acceso, abrir CMD (como administrador), y ejecutar el siguiente comando:
aws configure
después, debes ingresar la llave de acceso (Access Key), luego la llave de acceso secreto (Secret Access Key)
y tu servidor(us-east-2), y tu formato de salida(json)
5. Luego, en la pagina de inicio de AWS, ir al servicio S3, crear Bucket, con las credenciales otorgadas, y luego creamos una carpeta para almacenar los backups
6. Seguidamente para poder subir los backups generados anteriormente, debemos crear en bloc de notas estos comandos que podemos usarlo en CMD
--CMD (guardar el archivo de bloc de notas como .bat):
@echo off
::Ruta de la carpeta donde se están generando los backups
set source=C:\Backups\ComercialRita 
::Ruta del S3 donde se guardarán los backups
set destination=s3://comercialrita/backups 
:: Sincroniza la carpeta con S3, subiendo solo archivos nuevos o modificados
aws s3 sync "%source%" "%destination%" --delete

7. Para que el comando pueda ejecutarse cada hora automaticamente, debemos:
	I) Abrir el Programador de Tareas (Win + R, escribir taskschd.msc, presionar Enter).
	II) En el panel derecho, seleccionar Crear Tarea
	III) En la pestaña General, asignar un nombre como SyncS3_ComercialRita.
	IV) En la pestaña Desencadenadores, hacer clic en Nuevo
	V) Configurar Repetir cada 1 hora, para que se ejecute cada hora.
	VI) En la pestaña Acciones, hacer clic en Nueva
	VII) Programa o script: seleccionas el archivo .bat guardado en la ruta escogida anteriormente
	VIII) Agregar argumentos:
		-ExecutionPolicy Bypass -File "C:\ruta\del\script\sync_s3.(ps1 o .bat)"
	IX) Guardar la tarea y asegurarse de que esté habilitada.*/