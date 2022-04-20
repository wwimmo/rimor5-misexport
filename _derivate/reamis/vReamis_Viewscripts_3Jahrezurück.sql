--fibu und bilanzkat sind allgemein und nicht auf Jahre heruntergebrochen

--fibubuchung auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibubuchung AS
SELECT * from fibubuchung
WHERE jahr >= ((select to_char(SYSDATE,'YYYY') from dual)-3);

--fibukonto1 auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibukonto1 AS
SELECT * from fibukonto1
WHERE jahr >= ((select to_char(SYSDATE,'YYYY') from dual)-3);

--fibujahr1 auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibujahr1 AS
SELECT * from fibujahr1
WHERE jahr >= ((select to_char(SYSDATE,'YYYY') from dual)-3);

--bilanztx auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vReamisbilanztx AS
SELECT * from bilanztx
WHERE jahr >= ((select to_char(SYSDATE,'YYYY') from dual)-3);

--fibubudget auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vReamisfibubudget AS
SELECT * from fibubudget
WHERE jahr >= ((select to_char(SYSDATE,'YYYY') from dual)-3);

--budgetprokonto auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vReamisbudgetprokonto AS
SELECT * from budgetprokonto
WHERE jahr >= ((select to_char(SYSDATE,'YYYY') from dual)-3);