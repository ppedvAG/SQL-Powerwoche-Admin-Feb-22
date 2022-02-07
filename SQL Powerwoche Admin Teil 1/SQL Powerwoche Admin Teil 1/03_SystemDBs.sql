/* SystemDBs
master
Logins, Datenbank, Konfiguration

Backup: ja auf jeden Fall

msdb (DB für den Agent)
--Jobs, Aufträge , Zeitpläne, Verlauf, Emailsystem

Backup: auf jeden Backup!

model
..Vorlage für neue DB
create database testdb --Kopie der Model
evtl werden Einstellungen geändert

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
--jeden Tag einmal SystemDBs sichern (Vollständig)


