CREATE OR REPLACE FORCE VIEW VMieteropVaudoise AS
SELECT 
 liegnr, mieternr, abweichung_art, abweichung_typ, faelligkeitsdatum, mwst_satz, SUM(betrag) betrag, notiz
FROM (SELECT 
  mo.liegnr,
  mo.mieternr,
  (CASE WHEN mo.soll = 'N' THEN
     1
   ELSE
     2
   END)
  abweichung_art,
  (CASE WHEN mo.buchart in (20,21,22,23,24) THEN 
      CASE WHEN mzb.mzbartnr = 1 THEN
        100
      ELSE
        CASE WHEN mzb.mzbartnr BETWEEN 11 AND 89 THEN    
          200
        END
      END
    ELSE
      CASE WHEN mo.buchart in (38,41) THEN  
        200
      ELSE
        CASE WHEN mo.buchart BETWEEN 50 AND 59 THEN  
          700
        ELSE
          100
        END
      END
    END)
  abweichung_typ,
  LAST_DAY(mo.faelldat) faelligkeitsdatum,
  '' mwst_satz,
  mo.betrag betrag,
  '' notiz
  FROM mieterop mo
  LEFT JOIN mieterkum mk on mo.liegnr = mk.liegnr AND mo.mieternr = mk.mieternr AND mo.buchungnr = mk.buchungnr
  LEFT JOIN mzbest mzb on mzb.mzbestnr = mk.mzbestnr
  LEFT JOIN mzbart mzba on mzb.mzbartnr = mzba.mzbartnr 
  )
GROUP BY liegnr, mieternr, abweichung_art, abweichung_typ, faelligkeitsdatum, mwst_satz, notiz
ORDER BY liegnr, mieternr