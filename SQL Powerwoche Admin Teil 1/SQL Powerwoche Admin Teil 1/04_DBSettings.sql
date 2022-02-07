drop database testdb
---auf master

--immer markiern und ausführen


use master;
GO

create database testdb

--Wie groß ist die DB jetzt?
--8MB + 8 MB


--Wachstumrate?
--64MB pro Daten oder Logfile



--SQLL 2014 und früher
-- Daten 5 MB und Logfile 2 MB
--Wachstum : 1 MB bei den Daten und 10 % bei Logfile


---ZIEL: HDD Aktionen reduzieren
CREATE DATABASE [testdb2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'testdb2', FILENAME = N'D:\_SQLDB\testdb2.mdf' , SIZE = 512000KB , FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'testdb2_log', FILENAME = N'D:\_SQLDB\testdb2_log.ldf' , SIZE = 204800KB , FILEGROWTH = 102400KB )
GO






