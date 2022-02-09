--Sicherheit


-->user wird von Login getrennt behandelt


--Logins sind in master
select * from syslogins --sind in Master DB

--user in der DB
use northwind
select * from sysusers --User sind immer in der UserDatenbank

--
USE [master]
GO
CREATE LOGIN [Peter] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Peter2] FOR LOGIN [Peter2]




USE [master]
GO
CREATE LOGIN [Petra] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Petra] FOR LOGIN [Petra]
GO


USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

USE [Northwind]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO



use northwind

create table it.projekte (itpro int)
create table ma.projekte (mapro int)

create table it.mitarbeiter (itma int)
create table ma.mitarbeiter (mama int)


select * from orders

select * from projekte --gibts nicht..

--jeder User hat ein Std Schema


USE [Northwind]
GO
ALTER USER [Petra] WITH DEFAULT_SCHEMA=[MA]
GO
USE [Northwind]
GO
ALTER USER [Peter2] WITH DEFAULT_SCHEMA=[IT]
GO


use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Peter2]
GO
use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [Petra]
GO

--man sieht keine vererbeten Rechte--> Effiktive rausfinden
use [Northwind]
GO
GRANT SELECT ON [IT].[projekte] TO [Petra]
GO

--Rollen
--Vergabe der Rechte am besten über Rollen = Gruppe
--Aufwand wird deutlich geringer

USE [Northwind]
GO
CREATE ROLE [ITGruppe] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITGruppe] ADD MEMBER [Peter2]
GO
use [Northwind]
GO
REVOKE SELECT ON SCHEMA::[IT] TO [Peter2] AS [dbo]
GO
use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [ITGruppe]
GO



--Es gibt für Peter einen neunen Kollegen: Fritz 
--Fritz soll die gleichen Dinge tun dürfen, die Peter kann
USE [master]
GO
CREATE LOGIN [Fritz] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Fritz] FOR LOGIN [Fritz]
GO
USE [Northwind]
GO
ALTER USER [Fritz] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITGruppe] ADD MEMBER [Fritz]
GO


use [Northwind]
GO
GRANT CREATE TABLE TO [Petra]
GO



use [Northwind]
GO
DENY SELECT ON [dbo].[Employees] TO [Peter2]
GO








