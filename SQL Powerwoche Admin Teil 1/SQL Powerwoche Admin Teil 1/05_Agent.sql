--Agent


/*
per Zeitplan Jobs...

Job besteht us einzelnen Schritten

Auftr�ge  haben Zeitpl�ne


Agent Jobs k�nnen Nachrichten zusenden..
--per Mail
--per Pager

--Windows Protokoll

--Per Email.. dann muss der Agent per SMTP Mail versenden k�nnen..

--SMTP Server   Zugangsdaten Port 
--Profil merkt Zugangsdaten


--Windows SMTP Server ( = Features)



--Mailserver in SQL aktivieren

--> Datenbankemail einrichten

1. Verwaltung --> Datenbankemail
2. Profil mit Angabe der SMTP Settings

Profilart w�hlen:
Privates Profil 
.. ein direktes Recht auf das Profil

�fftl Profil
..dann muss ein User in der DB Rolle DatabaseMailUserRole sein
--k�nnte dann auch zuk�nftige Mailprofile verwenden

Systemparameter:
Tipp: Die Gr��e auf 10 MB festsetzen.. Dann gelingt es auch gr��ere Abfrageergebnisse oder Dateien sich 
zusenden zu lassen


--um eine Email zu bekommen am Ende eine Jobs..:


1: Operator

Andreas   andreasr@ppedv.de

--damit der Agent Email versendet:
1: Agent Warnugssystem: DB Email aktivieren und Profil zuweisen
2: Agent neu starten


*/


