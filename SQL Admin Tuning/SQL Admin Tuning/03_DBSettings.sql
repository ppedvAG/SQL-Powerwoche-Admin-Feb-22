/*
create database ... viele Fehler!!!

wie gro� ist die DB?
16 MB				(8 MB Daten 8 MB Log)
Wachstumsraten	      +64MB

SQL 2014 ;-)
5 MB + 2 MB ==> 7 MB 
Wachstum: 1 MB pro Datendatei + 10% Logfile

Was ist besser?
was wird in 3 Jahren sein .. wie gro�?
Perfmon
DMV Systemsichten
DataCollector
getrennte bzw evtl andere Laufwerke



*/

create database demodb;
GO

use demodb;
GO



create table t1(id int identity, spx char(4100)) --varchar variabel


insert into t1
select 'XY'
GO 20000

--Dauer : 44 Sekunden
--Wie gro� ist eigtl t1: 20000* 4kb ==> 80MB


--NUN DB auf 1000 MB und 200 MB Log vergr��ert.


--nach man. Vergr��erung: 37 Sek

--ca 150 Vergr��erungen * 5 ms + Logilewachstum


--Ziel also: 
--REduziere Last auf HDD durch
--getrennte Laufwerke f�r Log und DAten
--evtl eig HDD f�r die DB
--Startgr��en, damit kein Wachstum stattfindet
--Wachstumsrate gro� aber nicht zu gro�
	--> reduziert VLF, kein unn�tiges h�ufiges Wachstum
	--> das immer Zeit kostet