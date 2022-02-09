--Bereich Sicherheit-- �berwachsungsspezifikation

--> Logfile zum Aufzeichnen best Ereignisse


--> Sicherheit--> Server�berwachung
	--> Ereignisse des Server in das Logfile aufzeichnen
	--> Ereigbnisse im Sinne: alles was auf dem Server passieren kann (Login etc)
		--> keine Ereignisse innerhlab einer DB (Select zb)

--> Sicherheit im Bereich der DB
	--> Datenbank�berwachungsspezifikation
	--> Hier lassen sie gezielt Ereignisse innerhlab der DB aufzeichen 
--		und sehr gut filtern. zB Alle SELECT des Otto auf Tabelle Employees
--		auch unspezifischer m�glich: Alle Select innerhalb eines Schemas f�r Rollen


-- Tipp: nicht permanent protkollieren. Kann sehr viel werden.. Aktivieren/Deaktivieren

--Auswerten evtl per TSQL etwas einfacher

SELECT * FROM sys.fn_get_audit_file
('d:\_Backup\SicherheitsAudit_1CDABFEA-9AB5-4830-ABA7-F0A7C6D74C47_0_132888787781870000.sqlaudit',default,default)
where database_principal_name = 'Peter2'
GO  
