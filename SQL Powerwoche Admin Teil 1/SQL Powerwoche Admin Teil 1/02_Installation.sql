--Installation

--Instanzen 50 pro Rechern
--Instanz ist komplett isoliert mit eig Prozessen und Datein

--zB Software braucht eine "älterte Version"

--wg Rechten.. sysadmin dürfen ja grundsätzlich alles

--Standardinstanz: Aufruf  "Rechername"
--Port: 1433

--weitere Instanzen: Aufruf "Rechnername\Instanzname"
--Port: ???? random


--Pfade
--Binärkram.. egal 
--Pfade für DBs 
	--Pfad für Daten und Pfad für Logdatei
	--Trenne Log von Daten physikalisch per versch HDDs...!


--Security
--Windows Auth oder gemischte Auth (Windows oder SQL Auth)
--SQL Login , wenn kein Windows Auth möglich
----SA   sysadmin... deaktiviern  nach Installation und stattdessen ein Ersatz SA
-- Windows Admins sind nicht autom SQL Admin


--Dienstkonten
--SQL Server   
--SQL Agent (Jobs per Zeitplan)
--Volltextsuche
--Browser

--Verw. Dienstkonten.. autom Kennwortänderungen
--Lokales Konto -- arbeitet im Netz mit dem Computerkonto

-->NT Service\mssqlserver

--auch wenn wir beim Setuo kein NT Servicekonto, so wird das immer 
--bei lok Zugriffen verwenden.


--Instanzfeature: Volltextsuche und Replikation zu SQL DB Engine
--Freig Feature: CLientkonnevität


--TEMPDB sollte eigtl eig HDDs haben
--Datendateien soviele wie Kerne.. max 8


--Arbeitsspeicher
--Max Wert definieren
--Min Wert zunächst auf 0 belassen
--Immer das OS berücksichtigen  (mind 2 GB oder mehr....)



--MAXDOP
--wieviel Kerne darf eine Abfrage max verwenden
--Regel: alle Kerne , aber nicht mehr als 8













