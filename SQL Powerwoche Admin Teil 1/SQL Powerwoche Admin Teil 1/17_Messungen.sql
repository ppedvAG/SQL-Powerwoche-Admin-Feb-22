--Ablauf einer Abrage
--Peter---> Abf---> Postfach(FIFO]<  ------ Worker--> Ressourcenliste (LCK_M_S)
---> Ressource ist da!!-->CPU
-------------------------------RUNNABLE--------------------RUNNING

--in os_wait_stats und Aktivit�tsmonitor kann man die Zust�nde Runnable etc sehen

select * from Kunden where customerid = 'BLAUS'
--SUSPENDED


set statistics io, time on -- Anzahl der Seiten(IO) CPU DAuer und ges Dauer
--Plan: Scan (A bis Z Suche)  Seek (gezielte Herauspicken)
--
select * from orders where orderid < 10270