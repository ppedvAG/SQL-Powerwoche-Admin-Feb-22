
--Trennung der Logfile von Daten per Default

--MAXDOP  4 (eine Abfragen verwendet entweder 1 oder 4 Proz maximal)
---- max 8 ... oft ist weniger besser
---  Kostenschwellwert: 5 --> 25 (Taskmanager und User)

--tempdb
----so viele Dateien wie Kerne, aber nicht mehr als 8
--- Traceflags: 1117    1118
----------------> gleich große Datendateien 
---------------->Seiten / Blöcke  --> Latch -- Uniform Extents
-- trenne Daten von Logs


--RAM
--Max Arbeitspeicher: Gesamter RAM - OS
--der MIN Wert gilt erst wenn belegt

