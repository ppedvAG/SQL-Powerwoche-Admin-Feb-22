--Die Virtualisierung sollte immer auf realen Daten basieren
--Hat der Host 2 Sockets, dann sollte auf die VM �ber 2 Sockets Beschied wissen

--Vorsicht bei MIgration. DIe VM haben die konf Daten in eine Datei und passen sich der Umgebung nicht automatisch an. So kann es passieren dass
--die VM denkt sie h�tte einen Socket mit 8 Kernen , aber real sind es 2 Sockets mit je 4 Kernen

----> hohe CPU Leistung

--Grubds�tzich gilt: jede VM behandeln als w�re es eine reale "Blechb�chse"



