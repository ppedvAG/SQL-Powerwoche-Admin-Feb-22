/*
nur mit Inidzes kann man SEEK erreichen
IX = Telefonbuch / Verzeichnis

IX--> Abfrage statt 30 Sek in 0 fertig
--> User A ändert einen DS und User B einen anderen.. klappt
--> Sperrniveau sinkt auf Zeile

statt SCAN einen Seek---> weniger IO, weniger CPU weniger RAM Verbrauch


in Memory Tabelle --> Hash Index
PK braucht einen eindeutigen IX


Clustered Index  gruppierter IX = Tabelle in sortierter Form  und HEAP gibt es nicht mehr
wieviele CL IX pro Tabelle?  1x 
cool für Bereichsabfragen 
bei Tab Design immer zuerst den PK festlegen und vor allem die Spalte für den CL IX


NON Clustered IX  nicht gruppierte Index
 = Kopie von DAte in sortierter mit Zeiger auf den OrgDatensatz
wieviele kann man denn machen ?  ca 1000 
Lookups sollten vermieden werden
ist gut bei rel geringer Ergebnismenge unter 1% 


---------------------------------------------
 eindeutiger IX
 zusammengesetzter IX   kann nur max 16 Spalten oder 900 byte
 IX mit eingeschlossenen Spalten
 abdeckender IX = derfekte Plan (reiner Seek)

 gefilterter IX nur dann wenn es weniger Ebenen gebene wird... statt 3  2
 hat nicht alle DAten enthaten

 part. IX
 Filter UK USA GER
 
 ----GER--IT--UK-----USA

 ind Sicht
 hypoth. (realer) IX --Tool
 --------------------------------------------
 Columnstore IX 



 */

 set statistics io, time on

 select id from ku where id = 100 --HEAP
 --NIX_ID

  select id from ku where id = 100 --- SEEK  3 Seiteen statt 22000  0ms

   select id, freight from ku where id = 100 --Lookup 4 Seiten

    select id, freight from ku where id = 100 --Lookup 4 Seiten
   select id, freight from ku where id < 100 --Lookup 102 Seiten
   --je mehr IDs desto mehr Lookup

   --NIX_ID_FR--> sogar bei 500000  reiner IX Seek
   select id, freight from ku where id <500000

   --wir würden wieder neuen IX brauchen....
      select id, freight, orderid from ku where id <500000

--NIX_UK
	  select  country, city , freight
	  from ku
	  where orderid < 10900 and Country = 'UK'

--NIX_Welt
	  	  select  country, city , freight
	  from ku
	  where orderid < 10900 and Country = 'USA'
	  -













*/

select * from customers
insert into customers (CustomerID, CompanyName) values ('ppedv', 'Fa ppedv')

--PK =  als CL IX eindeutig 
select * from best2



select country, count(*)  from ku
group by country


--Sichten
create view vdemo1 
as
select country, count(*) as Anz from ku
group by country


select * from vdemo1 --gleich schnell

alter view vdemo1 with schemabinding --man muss exakt arbeiten
as
select country, COUNT_BIG(*) as Anz from dbo.ku
group by country

select country, count(*) as Anz from ku --22000  80ms 180
group by country


select * into ku2 from ku


select top 3 * from ku

--Best Spalten , Agg where 
--Table Scan... CLIX Orderdate
--Tab KU = 300 MB
select companyname, sum(unitprice*quantity) from ku 
where orderdate between '1.3.1997' and '30.6.1997'
group by companyname
--3642       , CPU-Zeit = 16 ms, verstrichene Zeit = 24 ms.

--Tabelle KU2 = 4 MB
select companyname, sum(unitprice*quantity) from ku2
where orderdate between '1.3.1997' and '30.6.1997'
group by companyname

--korrekt 4 MB?  ... Ja -->muss also komprimiert sein

---nach Archivkompression: statt 300MB = 3 MB!!!!!!
--auf der HDD und im RAM!!!!


select companyname, sum(unitprice*quantity) from ku2
where  city = 'London' -- orderdate between '1.3.1997' and '30.6.1997'
group by companyname



-- ABC -- 1000 IX

--> Fehlende IX
--> Überflüssge IX
--IX Wartung
--IX Strategie

--Überflüssige

select * from sys.dm_db_index_usage_stats --
--indexid = 0 Heap    1CL IX  >1 N CL IX

