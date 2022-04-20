# MIS Export Imofix

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
Aus Rimo sollen Daten in das System von Jarowa exportiert werden. Die Daten sind im Format CSV aufbereitet. Die CSV Dateien sollen automatisiert exportiert und an Jarowa geschickt werden.

# Konzept Rimo
Als Basis für diese Schnittstelle sollen folgende Standardfunktionalitäten aus Rimo verwendet werden:
- MIS-Export (Datenexport und Upload CSV)
- Jobplaner (generelle Jobautomatisierung für Rimo)
Beide Standardfunktionalitäten können nicht nur für diese Schnittstelle verwendet werden, sondern stehen ebenfalls für weitere Schnittstelle oder Anwendungsfälle zur Verfügung

## Format
Das Schnittstellenfile wird im Format CSV (comma separated value) erstellt.
Das Trennzeichen ist ein Komma **`,`** 
Die Spaltentitel werden immer angezeigt, heisst der erste Record enthält die Spaltenüberschrift (HDR).

## Tabellendefinition
Folgende Daten werden für den Export definiert.
Stammdaten
- Liegenschaft (lieg)
- Haus (haus)
- Objekt (objekt)
- Mieter (mieter)
- Verwaltung (verwaltung)
- Eigentümer (eigentuemer)
- Hauswart (hauswprolieg, hauswart)
- Bewirtschafterrollen (rollezufibu, rollen, produsers)

Vertragsdaten
- Mietvertrag (mietfall)
- Mietzins (mietzins)
- Vertragspartner (mvadressen)

Personendaten
- Person 	(person)
- Adresse	(adresse)
- Kommunikation	(kommuni


<br><br><br>
# Datenzusammenhänge
![DataRelationship](/_grafiken/DataRelationship_jarowa.png)

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

### FTP Verbindung
Im Rimo kann eine FTP Verbindung (Protokolle wie FTP oder sFTP mit TLS/SSL v3) eingerichtet werden.
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
