---Backup

/*
Welche Sicherung gibts denn?

Vollsicherung
sichert alle Daten (Datendateien und Logfile)
merkt sich Pfade und Größen und komprimiert (leerstellen raus)
Checkpoint (Wegschreiebn der Daten aus dem RAM auf die HDD)



Differenz
ist Diff zu V
Checkpoint

TLog
Chekpointdas Log merkt sich Anweisungen (I U D)






V  6:00
	T
	T
	T
	T
		D
	T
	T
	T
	T
!		D  15:00
	T
	T neuer Kunde
	T
	T Bestellung zum neuen Kunden

	--Was muss ich eigtl restoren?
	-- V  D TTTT

	--Was ist der schnellste Restore?
	--nur das V oder wenn es nicht lage her ist..

	--Wie lange dauert der Restore eines T?
	--dauert solange wie die Aktionen dauerten , diem T drin stecken
	--maximale eines T ´: die Zeit zum letzten T

	---Was sollen wir also mit der T Sicherung tun?
	--Lange T Intervalle ( ein T um fasst einen tag.. ;-( )
	--viele Ts.. 
	--V TTTTTTTTTTXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT


	Fälle:

	1. HDD defekt
	2. Datei defekt
	3. Daten versehentl manipuliert
	4. Ich weiss, dass gleich was passieren kann
	5. Server ist tot ,aber ein HDD oder sogar  2 HDDs leben

	--mit geringst mögichen Datenverlust


	/*
	Wiederherstellungsmodel (Tlog!!!)

	Einfach (schnell-weniger genau restoren)
	IUP gespeichert, aber dann etwas später automatisch gelöscht
	Bulk Oerationen werden rudimentär gespeichert
	--> keine Sicherung des Logfile
	--oft bei TestServer

	Massenprotkolliert  (Kompromiß)
		--wie einfach, aber nichts gelöscht
		--> Logfile muss gesichert werden, sonst wird das Logfile nicht mehr geleert
		--nur die LogSicherung leert das Logfile
		--man kann nur dann auf Sek restoren, wenn kein Bulk auftrat
	--Logshipping verlangt mind dieses Model

	Vollständig (langsamer aber sicherer)
--wie einfach, aber Bulk Operation sehr detailiert und auch andere Dinge wie IX werden auch protokolliert
--> Restore auf Sekunde
--> Logfile wächst stärker
--ProduktivDB
--Hochverfügbarkeitslösungen verlangen dieses Model : Spiegeln, Hochverfügbarkeitsgruppen


Sicherungsstrategie:
Ausfallzeit: 1Stunde
max Datenverlust in Zeit: nur 30min Datenverlust

DB 150GB Volumen -->Hochverfügbarkeit
Ausfallzeit 15 min
Datenverlust : 10min

--Thema Cluster


	4. Ich weiss, dass gleich was passieren kann
	5. Server ist tot ,aber ein HDD oder sogar  2 HDDs leben


	auf HV-SQL1



	*/ 
*/	 
	
--V  TTT D TTT D TTT 
	BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'Northwind-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  DIFFERENTIAL ,  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'Northwind-Diff Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'Northwind-Tlog Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO










/*
--	1. HDD defekt
	2. Datei defekt
	3. Daten versehentl manipuliert  !
	4. Ich weiss, dass gleich was passieren kann
	5. Server ist tot ,aber ein HDD oder sogar  2 HDDs leben

	*/
	--Fall 3: Daten versehentlich manipuliert (alle Kunden in Bonn)
	--DB funktioniert einwandfrei


	--Idee letzte Backup restoren .. doof.. weil neue Kunden wieder wg wären..
	--Idee:  Wann geschah der Unfall: 11:32
	--DB restoren unter anderen Namen: 11:30-- ein TSQL Dev



	--PFade korrigieren, Fragmentisicherung deaktivieren

	USE [master]
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 24,  MOVE N'Northwind' TO N'D:\_SQLDB\northwn2dsmall.mdf',  MOVE N'Northwind_log' TO N'D:\_SQLDB\northwn2dsmall.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 32,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 33,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 34,  NOUNLOAD,  STATS = 5
GO


--Daten restoren mit geringstem Datenverlust


--V: 6:00
--D: 10 Uhr
-- alle 30min T Sicherung (10:00 10:30..)

--Meldung: Error 11:47 falscher Delete

--Restore des V , letzten D und alle T bis 11:30 .. Datenverlust liegt bei 17 Min

--Warten bis 12 Uhr...
--Restore von V , D, alle T bis 11:46:59
--Verlust bis 12 Uhr :... 13 min


--Backup Log von 11:47 Sicherung des Log manuell  (backup ist immer online)
--Dauer: 5min.. diese 5 min wären später wieder verloren

--Restore auf 11:46:........


--Idee: Leute von der DB runterkicken
--Sicherung des Logfiles..alle Daten gesichert
--Restore von 11:46...

--V D --vs--- T
--V und D sichern einen Zeitpunkt.. bei Wiederherstellungsmodel einfach
--T sichert den Weg zu den Daten
--wenn man von Fulll auf Simple geht: T Sicherungen per Job gehen nicht mehr
--man verliert TX, Logdatei wid leerer. 

--

---1. HDD defekt
--	2. Datei defekt
--	3. Daten versehentl manipuliert  !
--	4. Ich weiss, dass gleich was passieren kann
--	5. Server ist tot seit 15min ,aber ein HDD oder sogar  2 HDDs leben
--Backup ist aber 2 Stunden alt




-- Fall 5 DB Offline: deta



--Fall 4: Ich weiss, dass gleich was passiert


--Snapshot Sicherung: Momentaufnahme




-- Create the database snapshot
CREATE DATABASE DBNAME
ON
( NAME =LogischerNamederOrigDBdatendatei ,
FILENAME = 'D:\_SQLDB\DBNAME.mdf' ) --zunächst 128kb
AS SNAPSHOT OF OrignalDB;
GO


CREATE DATABASE SN_Nwind_1430
ON
(
	NAME =Northwind ,
	FILENAME = 'D:\_SQLDB\SN_Nwind_1430.mdf' 
) --zunächst 128kb
AS SNAPSHOT OF Northwind;
GO

--man kann mehrere Snapshots anlegen

--Kann man einen Snapshot sichern?
--Nö

--Kann man einen Snapshot restoren?
--erst recht nicht!!!!!

--Backup der OrigDB?
--jupp ..geht!

--Restore der OrigDb aus Backup, wenn Snapshot vorhanden?
--Nö..! Erst alle Snapshots löschen..!

--Kann man denn den Snapshot zum Restore verwenden?
--Ja geht...


--nur per TSQL...
--Rahmenbedingungen
--keiner darf auf dem Snapshot sein
--keiner darf auf der OrigDB sein

use master

restore database northwind from database_snapshot = 'SN_Nwind_1430'

use master
GO
select * from sysprocesses where spid > 50-- alle Prozesse der User

--dbid = Datenbank Nummer
select db_id('northwind'),db_id('sn_nwind_1430')


select * from sysprocesses where spid > 50 and dbid in(5,9) --spid suchen

--70!!

kill 70---
--alternative
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
restore database northwind from database_snapshot = 'SN_Nwind_1430'


--Sicherungszeitplan


--DBX  :   1500GB
--Arbeitszeiten:  MoSo
--                           6:00 bis 18:00

--Ausfallzeit in min:			1 Stunde
--Datenverlust in Zeit:       1 Stunde

select 50.000/300/60--nicht mehr machbar--> Hochverfügbarkeit (3 Sekunden..)

--50Gb in 2 min

--TLog: 20 bis 40MB/Sek
--50GB

--Vollsicherung: täglich 19 Uhr  Mo bis So
--T (Datenverlust)..alle 30min.. alle 15 min Mo bis So von 6:15 bis 18:16
--D alle 3 bis 4 T  von Mo bis So  von 7:05 bis 18:10

--

















select * from [SN_Nwind_1430].dbo.orders--kommt direkt von Northwind









