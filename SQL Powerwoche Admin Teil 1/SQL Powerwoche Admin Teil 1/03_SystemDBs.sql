/* SystemDBs
master
Logins, Datenbank, Konfiguration

Backup: ja auf jeden Fall

msdb (DB f�r den Agent)
--Jobs, Auftr�ge , Zeitpl�ne, Verlauf, Emailsystem

Backup: auf jeden Backup!

model
..Vorlage f�r neue DB
create database testdb --Kopie der Model
evtl werden Einstellungen ge�ndert

ALTER DATABASE [model] SET RECOVERY SIMPLE WITH NO_WAIT
GO

ALTER DATABASE [model] SET RECOVERY FULL WITH NO_WAIT
GO


Backup der Model DB: ja.. aber auch per Script keine dumme Idee


tempdb
#tabellen , ##Tabellen
Zeilenversionierung
Wartungsarbeiten (IX Wartung)
Auslagerungen
hohe Traffic..

Backup: neee...



distribution 



--Wartungsplan:
--jeden Tag einmal SystemDBs sichern (Vollst�ndig)


