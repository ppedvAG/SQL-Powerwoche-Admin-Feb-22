--Datensammlung


--Thema Überwachung
--live Problem
--Reihenfolge

--Taskmanager

--Trojaner
--> teakids.exe mslaugh.exe

--was läuft auf dem Rechner??
--Prozesse, Engpässe..

--Was, wenn nichts auf Engpässe hindeutet?


--Suche im SQL Server..
--Taskmanager für SQL Server: Aktivätsmonitor

select * into kunden from customers
--Alle grafischen Hilfsmittel = DMVs

select * from sys.dm_os_

select * from sys.dm_db

--Alle DMV s sind nach dem Neustart auf 0 resetet

--
select * from sys.dm_os_wait_stats
--												20ms
--|--------------------------|--------|
--0                                        80ms          100ms


--wait_time = Gesamte Wartezeit bis RUNNING
--signal_time = Anteil der CPU an der gesam. Wartezeit
--die Werte sind kummulierend

select * from sys.dm_os_wait_stats order by 3 desc

--SOS..  7314248