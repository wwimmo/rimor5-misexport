--fibubuchung auf letzte >= heute minus 3 Jahre einschränken
CREATE OR REPLACE VIEW vWPfibubuchsaldo (FIBUNR, JAHR, MONAT, KONTONR, KONTOBEZEICHNUNG, BETRAG) AS 
SELECT F.FIBUNR, FK.JAHR, DATEFORMAT(FB.BUCHDAT,'Mm') MONAT,  FK.KTO KONTONR, FK.KONTOBEZ1 KONTOBEZEICHNUNG,
TRIM(STR(SUM(CASE WHEN FB.SOLL = 'Y' THEN FB.BETRAG ELSE -FB.BETRAG END), 13,2))  BETRAG
FROM FIBU F 
JOIN FIBUKONTO1 FK ON FK.FIBUNR = F.FIBUNR
JOIN FIBUBUCHUNG FB ON FB.FIBUNR = FK.FIBUNR AND FB.JAHR = FK.JAHR AND FB.KTO = FK.KTO
WHERE fk.jahr >= (DATEFORMAT(GETDATE(),'YYYY')-3)
GROUP BY F.FIBUNR, FK.JAHR, DATEFORMAT(FB.BUCHDAT,'Mm'), FK.KTO, FK.KONTOBEZ1
ORDER BY F.FIBUNR, FK.JAHR, DATEFORMAT(FB.BUCHDAT,'Mm'), FK.KTO;

--fibukonto1 auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vWPfibukonto1 AS
SELECT * from fibukonto1
WHERE jahr >= (DATEFORMAT(GETDATE(),'YYYY')-3);

--fibujahr1 auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vWPfibujahr1 AS
SELECT * from fibujahr1
WHERE jahr >= (DATEFORMAT(GETDATE(),'YYYY')-3);

--bilanztx auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vWPbilanztx AS
SELECT * from bilanztx
WHERE jahr >= (DATEFORMAT(GETDATE(),'YYYY')-3);

--fibubudget auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vWPfibubudget AS
SELECT * from fibubudget
WHERE jahr >= (DATEFORMAT(GETDATE(),'YYYY')-3);

--budgetprokonto auf letzte >= heute minus 3 Jahre einschränken
CREATE or REPLACE VIEW vWPbudgetprokonto AS
SELECT * from budgetprokonto
WHERE jahr >= (DATEFORMAT(GETDATE(),'YYYY')-3);