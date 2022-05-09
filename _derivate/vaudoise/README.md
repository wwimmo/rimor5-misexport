# MIS Export Vaudoise

<!--ts-->
Table of contents
   * [Ausgangslage](#Ausgangslage)
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
# Ausgangslage
Rimo Export Datendump via MIS-Export für Immopac bzw. Vaudoise. Dieses Dokument enthält nur abweichende/ergänzende Informationen zu den Anforderungen Vaudoise.

# Anforderungen
Export von Datentabellen aus Rimo. Die Daten sind im Format CSV aufbereitet. Die CSV Dateien sollen automatisiert exportiert.
Alle Datentabellen werden in CSV Files mit Bezeichnung Tabellenname.csv exportiert.

# Konzept Rimo
Die Vaudoise Schnittstelle soll über die im Rimo bereits existierende Standardschnittstelle „MIS-Export“ gelöst werden. Die Schnittstelle MIS-Export exportiert Rohtabellen oder Views aus Rimo in CSV-Files.

## Format
Das Schnittstellenfile wird im Format CSV (comma separated value) erstellt.
Das Trennzeichen ist ein Komma **`,`** 
Die Spaltentitel werden immer angezeigt, heisst der erste Record enthält die Spaltenüberschrift (HDR).

## Tabellendefinition
Folgende Tabellen werden für den Export definiert.

**Export-Tabellen Vaudoise:**
- lieg
- gebaeude
- haus
- etage
- etagesp
- objekt
- verwaltung
- bank
- zeichberechtigung
- stockwerk
- hypothek
- person
- adresse
- plz
- land
- partnerzulieg
- partnerzugebaeude
- partnerzuhaus
- partnerzuobjekt
- partner
- partnerauftrausfuehr
- partnertypzupartner
- partnertyp
- sachbearbeiter
- sachbearbtypzusachbearb
- versicherungzugebaeude
- versicherungzuhaus
- gebaeudeverszugebaeude
- gebaeudeverszuhaus
- versicherung
- gebaeudevers
- praemienartzuversicherung
- deckungsartzuversicherung
- deckposzudeckartzuversich
- versicherungsges
- deckungsartzupraemienart
- praemienart
- deckungsart
- deckungspos
- eigprolieg
- hauswprohaus
- hauswprolieg
- eigentuemer
- hauswart
- mieter
- mietfall
- mieterbew
- mieterop
- mieterkum
- mietzins
- untermieter
- abrechhknk
- liegzuabrech
- anrede
- objart
- objartsp
- objlage
- konsindex
- indexwerte
- hypozins
- verwgebiet
- clearing
- mvadressen
- kommunikation
- kommart
- liegzuabrech
- mzsicherung
- komplexart
- komplexkateg
- liegart
- liegkateg
- sprache
- geschlecht
- persart
- nutzungsart
- objgrp
- rechtsform
- schlproobj
- fibu
- fibujahr1
- fibujahr2
- fibukonto1
- fibukonto2
- fibubudget
- bilanztx
- fibubuchung
- budgetprokonto
- mzbart
- mzbest
- mzbpromiet
- mvvertrart
- gebrauchzweck
- mieterausbau
- indivmzbasis
- mieteroption
- rating
- objart
- branche
- branchezumieter
- **VmieteropVaudoise**

Die View VmieteropVaudoise wird speziell auf der Datenbank erstellt und ist keine standardisierte Tabelle/View auf der Rimo Datenbank.
Die benötigten View können per Script 
- [VmieteropVaudoise.sql](VmieteropVaudoise.sql) 
hinzugefügt werden.

# Datenzusammenhänge
**Export-Tabellen Vaudoise**<br>
![DataRelationship](/_grafiken/DataRelationship_vaudoise.png)

## Spezifikation Daten zu „streitfall.csv“
Mapping Rimo R4 Daten zu Vorgaben Vaudoise:


**Freie Spalten:**
Tabelle „mieter“ (file:mieter.csv)
- Notiz -> (Spalte: string01)
- Betrag -> (Spalte: betrag01)
- Status -> (Spalte: freieSpalteerdicid01  Dictionary einrichten:
{1} Anklage
{2} Kündigung
{3} Kündigung-Anklage
{4} Räumung
{5} Ausstellung von Verlustscheinen

- Abgeschlossen am -> (Spalte: date01)



## Spezifikation Daten zu „finanzlage.csv“
Mapping Rimo R4 Daten zu Vorgaben Vaudoise:


Die Daten zur Finanzlage werden somit in einer View von Rimo R4 vorbereitet, da es zur Dateninterpretation tiefergreifende Informationen aus dem Rimo R4 Daten-Schema braucht.
Die View enthält folgende Spalten:
- Liegnr, 
- mieternr, 
- abweichung_art, 
- abweichung_typ, 
- faeilligkeitsdatum, 
- mwst_satz, 
- betrag, 
- notiz

Liegnr und mieternr entsprechen den Rimo Informationen zur Identifikation eines Mieters. Die restlichen Spalteer sind speziell für Vaudoise aufbereitet und existieren nicht als Rohdaten im Rimo.


## Liegenschaftsnummer Vaudoise
Die Liegenschaftsnummer Vaudoise wird im Spalte fibu.stdexportkoststelle geführt:
![Liegenschaftsnummer_Vaudoise](/_grafiken/Liegenschaftsnummer_Vaudoise.png)
File: fibu.csv
Spalte: stdexportkoststelle


## Kontoplan Vaudoise
Die Kontonummern Vaudoise werden im Spalte Export Hauptbuch (fibukonto1.exporthauptbuch) geführt:
![Kontoplan_Vaudoise](/_grafiken/Kontoplan_Vaudoise.png)
File: fibukonto1.csv
Spalte: expktohauptbuch


# Exportmechanismus
Der Exportmechanismus kann manuell gesteuert werden. Die Selektionsmaske ist von der Standardschnittstelle MIS-Export vorgegeben:
 ![ExportMechanism](/_grafiken/Exportmechanismus_Vaudoise.png)

Der Export kann ebenfalls als Job geplant werden.

## Exportkonfiguration im Rimo
Im Rimo wird folgende Exportkonfiguration (SYSTEM\MISEXP2) benötigt:
- Name der Tabellen, welche exportiert werden sollen.
Hier werden die Daten definiert, welche exportiert werden (siehe vorherige Kapitel). 

Die Konfiguration der zu exportierenden Tabellen/Views kann während der Laufzeit von Rimo ohne spezifische Programmanpassung erweitert werden.

Somit sind zukünftige Datenerweiterungen derselben Schnittstelle auf einfachste Art und Weise realisierbar.

Der Export der Daten muss einmalig eingerichtet werden.

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
