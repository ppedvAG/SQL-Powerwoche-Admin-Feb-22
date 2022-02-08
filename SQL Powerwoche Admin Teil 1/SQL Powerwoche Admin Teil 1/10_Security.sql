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

