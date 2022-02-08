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






