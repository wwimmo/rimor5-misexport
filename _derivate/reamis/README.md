# MIS Export Reamis

<!--ts-->
Table of contents
   * [Anforderungen](#Anforderungen)
   * [Konzept Rimo](#Konzept-Rimo)
      * [Format](#Format)
      * [Tabellendefinition](#Tabellendefinition)
   * [Datenzusammenhänge](#Datenzusammenhänge)
   * [Exportmechanismus](#Exportmechanismus)
     * [FTP Verbindung](#FTP-Verbindung)
       * [Exportkonfiguration im Rimo](#Exportkonfiguration-im-Rimo)
       * [Exportpfad](#Exportpfad)
       * [Exportjob](#Exportjob)
   * [Hinweis: Change-Management Schnittstelle MIS-Export](#Hinweis-Change-Management-Schnittstelle-MIS-Export)
<!--te-->
# Anforderungen
Export von Datentabellen aus Rimo in Reamis. Die Daten sind im Format CSV aufbereitet. Die CSV Dateien sollen automatisiert exportiert und an Reamis geschickt werden.
Die Rimo Daten kommen als ganze Tabellensätze und sind grösstenteils nicht aufbereitet (Ausnahme Finanzdaten wegen Einschränkung auf die letzten drei Jahre).

# Konzept Rimo
Die Reamis Schnittstelle soll über die im Rimo bereits existierende Standardschnittstelle „MIS-Export“ gelöst werden. Die Schnittstelle MIS-Export exportiert Rohtabellen oder Views aus Rimo in CSV-Files.

## Format
Das Schnittstellenfile wird im Format CSV (comma separated value) erstellt.
Das Trennzeichen ist ein Komma **`,`** 
Die Spaltentitel werden immer angezeigt, heisst der erste Record enthält die Spaltenüberschrift (HDR).

## Tabellendefinition
Folgende Tabellen werden für den Export definiert.

**Liegenschaft und Mieterdaten:**
- lieg
- gebaeude
- haus
- etage
- objekt
- objlage
- objart
- mieter
- person
- mietfall
- mietzins
- verwaltung
- verwgebiet
- nutzungsart
- mvvertrart
- mwstanteil

**Gebäudeversicherungsdaten:**
- gebaeudevers
- gebaeudeverszugebaeude
- versicherungsges

**Finanzdaten:**
- fibu
- vReamisfibujahr1
- vReamisbilanztx
- vReamisfibukonto1
- bilanzkat
- vReamisfibubudget
- vReamisbudgetprokonto
- vReamisfibubuchung

Die Tabelle vReamisfibubuchungen enthält sämtliche Einzelbuchungen der selektierten Finanzbuchhaltungen eingegrenzt auf >= heute minus 3 Jahre.
**Projektnummer-Vergabe**
Im Rimo wird auf Stufe Fibukonto noch ein freies Feld für die Vergabe einer Projektnummer definiert. Die Projektnummer wird mit der Tabelle vReamis-fibukonto1 im Feld string01 exportiert.

Die benötigten View können per Script 
- [vReamis_Viewscripts_2Jahrezurück.sql](vReamis_Viewscripts_2Jahrezurück.sql) 
- [vReamis_Viewscripts_3Jahrezurück.sql](vReamis_Viewscripts_3Jahrezurück.sql) 
- [vReamis_Viewscripts_4Jahrezurück.sql](vReamis_Viewscripts_4Jahrezurück.sql) 

hinzugefügt werden.

# Datenzusammenhänge
**Liegenschaft- und Mieterdaten**<br>
![DataRelationship](/_grafiken/DataRelationship_reamis_Liegenschaft_Mieterdaten.png)

**Gebäudeversicherungsdaten**<br>
![DataRelationship](/_grafiken/DataRelationship_reamis_gebaeudeversicherungsdaten.png)

**Finanzdaten:**<br>
![DataRelationship](/_grafiken/DataRelationship_reamis_Finanzdaten.png)

# Exportmechanismus
Der Exportmechanismus kann manuell gesteuert werden. Die Selektionsmaske ist von der Standardschnittstelle MIS-Export vorgegeben:
![ExportMechanism](/_grafiken/ExportMechanism.png)
Die Selektion des Exports kann nur mittels Liegenschaftsnummer eingegrenzt werden. Eine periodische Eingrenzung ist nicht möglich – es werden somit immer sämtliche Datensätze einer Tabelle (inkl. Historydaten) exportiert.

Der Export kann ebenfalls als Job geplant werden.

## Exportkonfiguration im Rimo
Im Rimo wird folgende Exportkonfiguration (SYSTEM\MISEXP) benötigt:
- Name der Tabellen, welche exportiert werden sollen.
Hier werden die Daten definiert, welche exportiert werden (siehe vorherige Kapitel). 

Die Konfiguration der zu exportierenden Tabellen/Views kann während der Laufzeit von Rimo ohne spezifische Programmanpassung erweitert werden.

Somit sind zukünftige Datenerweiterungen derselben Schnittstelle auf einfachste Art und Weise realisierbar.

Der Export der Daten muss einmalig eingerichtet werden.
Steuer.ini und Konfig Datei: <br>
[konfig.dat](konfig%20MIS/dat-Files/konfig.dat)<br>
[STEUER_MIS.INI](konfig%20MIS/dat-Files/STEUER_MIS.INI)<br>

### FTP Verbindung
Im Rimo kann eine FTP Verbindung (Protokolle wie FTP oder FTPs mit TLS/SSL v3) eingerichtet werden.
Die exportierten Daten werden nach dem Export auf diesen Server hochgeladen.

### Exportpfad
Es muss ein Exportpfad für die Dateien definiert werden.

### Exportjob
Der Export wird als automatisierter Job eingerichtet. Zeitpunkt und Häufigkeit dieses Jobs kann frei definiert werden – z.B.
- jede Nacht um 03:00
- jeweils am 5. Tag jeden Monats um 10:00
- alle 4 Stunden
Der Job wird zum gewünschten Zeitpunkt wiederkehrend durch den Rimo R5 Server ausgeführt. Dazu ist keine Anwen-derinteraktion mehr erforderlich.

<br><br><br>

# Hinweis: Change-Management Schnittstelle MIS-Export
Aufgrund zukünftig geplanter Systemerweiterungen im Rimo kann es sein, dass die für diesen Export konfigurierten Tabellen mit einer zukünftigen Rimo Version ändern. Meist handelt es sich hier um Datenbankerweiterungen wie z.B. neue Felder auf einer der Exporttabellen. Die Datenbankerweiterungen werden automatisch nach einem entsprechenden Versionsupdate auch für diese Schnittstelle verwendet.

Grundsätzlich werden solche Datenbankänderungen im Updatejournal zum entsprechenden Versionsupdate vermerkt, jedoch werden nicht automatisch technische Dokumentationen dazu verfasst. Sofern die laufenden Datenbankerweiterungen keinen zwingenden Änderungseinfluss auf die Schnittstelle haben, werden sie von der W&W Immo Informatik nicht aktiv kommuniziert. Änderungen mit zwingendem Einfluss auf die Schnittstelle (z.B. Grundlegende Datenstrukturänderungen) werden dem Kunden vor der Auslieferung des Updates kommuniziert.

Änderungen an bestehenden Datenstrukturen, wie z.B. Formatänderungen eines bestimmten Feldes, Änderungen des Feldinhaltes bzw. der Businesslogik von Rimo sind der W&W Immo Informatik vorbehalten.
