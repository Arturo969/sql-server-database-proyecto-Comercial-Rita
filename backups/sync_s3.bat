@echo off
set source=C:\Backups\ComercialRita
set destination=s3://comercialrita/backups

:: Sincroniza la carpeta con S3, subiendo solo archivos nuevos o modificados
aws s3 sync "%source%" "%destination%" --delete