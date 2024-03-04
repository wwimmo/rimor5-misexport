--fibu und bilanzkat sind allgemein und nicht auf Jahre heruntergebrochen

--fibubuchung auf letzte >= heute minus 4 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibubuchung AS
SELECT * from fibubuchung
WHERE jahr >= (select Dateformat(getcurrentdate(),'YYYY')-4);

--fibukonto1 auf letzte >= heute minus 4 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibukonto1 AS
SELECT * from fibukonto1
WHERE jahr >= (select Dateformat(getcurrentdate(),'YYYY')-4);

--fibujahr1 auf letzte >= heute minus 4 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibujahr1 AS
SELECT * from fibujahr1
WHERE jahr >= (select Dateformat(getcurrentdate(),'YYYY')-4);

--bilanztx auf letzte >= heute minus 4 Jahre einschränken
CREATE or REPLACE VIEW vReamisbilanztx AS
SELECT * from bilanztx
WHERE jahr >= (select Dateformat(getcurrentdate(),'YYYY')-4);

--fibubudget auf letzte >= heute minus 4 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibubudget AS
SELECT * from fibubudget
WHERE jahr >= (select Dateformat(getcurrentdate(),'YYYY')-4);

--budgetprokonto auf letzte >= heute minus 4 Jahre einschränken
CREATE or REPLACE VIEW vReamisbudgetprokonto AS
SELECT * from budgetprokonto
WHERE jahr >= (select Dateformat(getcurrentdate(),'YYYY')-4);
