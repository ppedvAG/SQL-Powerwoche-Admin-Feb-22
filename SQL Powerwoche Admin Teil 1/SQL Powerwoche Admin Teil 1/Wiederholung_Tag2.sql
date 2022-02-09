--Restore geht nicht

--man nsieht nichts


-- Alle Endungen aktiv?.. ja

--Korrekter Server? ..ja 

--Rechte des Dienstkonto
--per Zeitplan = SQL Agent
--ohne Zeitplan = SQL Server


--
--sp_configure ist immer ein Hinweis auf Serversettings....
--ob RAM etc..
--Rs
EXEC sys.sp_configure N'min server memory (MB)', N'4001'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'min server memory (MB)', N'4001'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'min server memory (MB)', N'4001'
GO
EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO


--Contained Database

--es gibt Dinge, die zu einer DB gehören ,aber icht dort gespeichert werden
--eig Logins
--keine eig Aufträge
--keine eig temp Tabellen

USE [ContDB]
GO
CREATE USER [Max] WITH PASSWORD=N'ppedv2019!'
GO
USE [master]
GO
ALTER DATABASE CONTDB
SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO


--DB WHoAMI
---JamesBond hat kein Login
--Ein Logibn anzulegen ist keine Lösung..

--ddas Login hätte zb die SID 985798472984729374
--der User allerdings hat	SID 765348723648624876
--die Benutzerzuodnung azugeben schewitert, weil ein user JB schon vorhanden ist

--JB als User löschen und neu Anlegen .. Mitgllie in Rolle wieder setzen
USE [master]
GO
CREATE LOGIN [JB] WITH PASSWORD=N'123', DEFAULT_DATABASE=[whoamiDB], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [whoamiDB]
GO
CREATE USER [JB] FOR LOGIN [JB]
GO
USE [whoamiDB]
GO
ALTER ROLE [Personalabteilung] ADD MEMBER [JB]
GO


--Restore der DB restoremeDb
--32 Sek
--1,6GB   ca 1000MB Logfile 550 MB daten

select 1600/32 ----50MB/Sek
select 550/32 ---17 MB

--mit D
select 1100/4  --375MB/Sek

select 525/4 ---131 MB/Sek

--nur V
select 1100/2 --550MB/Sek

select 525/2 ---262 MB/Sek


--V TTTTTTTTTTTTT!xxxx  D


use restoremeDB

sp_change_users_login 'Report'

sp_change_users_login 'Auto_fix', 'JamesBond', NULL, '123@qwe'

--bei Windows Konten kein Thema