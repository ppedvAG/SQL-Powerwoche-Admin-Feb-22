--DB Design
--Normalisierung: 1. 2. 3. BC 4. 5.
--1NF jede Zelle ein Wert
--2 NF jede Tab hat einen PK
--3 NF denk dir den PK weg, keine direkte Abh�ngigkeit unter den anderen Spalten

--unbediungt ein Diagramm anlegen. Damit erkennt man sehr schnell 
--Zusammenh�nge zwischen den Tabellen und evtl. schlechtes Design

--Normalisierung ist gut, aber langsam!!
-- Gegenteil Redundanz ist schneller
/*
Entit�ten

Prim�rschl�ssel
Fremdschl�ssel
ref Integrit�t
besteht immer zwischen PK und FK und verhindert eine Verletzung der ref INtegrit�t..
kein L�schen eines Kunden, wenn er Bestellungen hat




Bibliothek

B�cher
BuchID
ISBN
Titel

Leser
LeserID
Nachname
Strasse
HNr
Plz
Ort
Land
GebTag 




Leihe
LeihId
Leihdatum
LeserID

LeihDetails
[LeihDetailid]
BuchId
LeihId




1 MIO Kunden
2 MIO Bestell + RngSumme
4 MIO BestPos

1-2-3 = 7 MIO


1-2 --> 3 MIO 



Datentyp:

"Text": Otto

char(50)			'Otto                                               ' 50 
nchar(50)        n = unicode    'otto                           ' 50*2  = 100
varchar(50)     'Otto'   4
nvarchar(50)  'otto'   4*2  = 8 
datetime (ms)  aber nicht auf ms genau verwendet..

--> der Platz auf dem Datentr�ger spiegelt sich 1:1 im RAM


*/