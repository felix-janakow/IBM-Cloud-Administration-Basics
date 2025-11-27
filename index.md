---
layout: default
title: Cloud Administration Basics I 
---

# 1. Erste Schritte
---
&nbsp;


## **1.1 Login im IBM Cloud Portal**

Der erste Schritt zur Arbeit mit der IBM Cloud ist die Anmeldung im IBM Cloud Portal

**1.** Öffnen Sie die Login-Seite: [IBM Cloud Login](cloud.ibm.com/login)

**2.** Geben Sie ihre Zugangsdaten (Benutzername und Passwort) ein

**3.** Bestätigen Sie die Anmeldung, um Zugriff auf das IBM Cloud Dashboard zu erhalten

<img src="{{ site.baseurl }}/screenshots/IBMCloud_Login.png" alt="IBM Cloud Login" width="550">


## **1.2 Multi-Faktor-Authentisierung (MFA) aktivieren**

Nach der Anmeldung im IBM Cloud Account sollte der nächste Schritt die Aktivierung der Multi-Faktor-Authentifizierung (MFA) sein.

**Warum MFA?** 

Ein ausschließlich passwortgeschütztes Konto erfüllt heutzutage nicht mehr die gängigen Sicherheitsanforderungen. MFA ist in vielen Bereichen wie Banking oder sozialen Netzwerken bereits Standard und wird auch in der IBM Cloud **als Best Practice empfohlen**.

**Um MFA zu aktivieren befolgen Sie folgende Schritte:**

**1.** Navigieren Sie in der oberen Leiste zu ``Manage`` und wählen Sie den Unterpunkt ``Access (IAM)``

**2.** In der linken Seitenleiste klicken Sie auf ``Settings``

**3.** Unter ``Settings`` wechseln Sie zu ``Authentication``

**Hier können Sie nun auswählen, wie die MFA eingerichtet werden soll. Die empfohlene Einstellung ist:**

- **MFA for a user with an IBMid**  
- **Either**, MFA für federated und non-federated User aktivieren


<img src="{{ site.baseurl }}/screenshots/MFA1:2.png" alt="MFA" width="1500">

<img src="{{ site.baseurl }}/screenshots/MFA2:2.png" alt="MFA" width="1500">

&nbsp;

## **1.3 Account-Einstellungen / Aktivieren einer Subscription**

Um wichtige Informationen wie den Account-Namen oder die Account-ID herauszufinden, sowie um Subscriptions einzulösen und andere Einstellungen wie:

- Financial Services Validated
- EU Supported
- HIPAA Supported
- Enterprise-managed IAM
- Commercial Proof of Concept (PoC)
- Virtual Routing and Forwarding
- Service Endpoints

**zu verwalten, gehen Sie wie folgt vor:**

**1.** Navigieren Sie in der oberen Leiste zu ``Manage`` und 

**2.** Wählen Sie den Unterpunkt ``Account``

**3.** Klicken Sie in der Seitenleiste auf ``Account Settings``

&nbsp;

<img src="{{ site.baseurl }}/screenshots/Settins1-2.png" alt="AccSettings" width="1500">

<img src="{{ site.baseurl }}/screenshots/Settings2-2_.png" alt="AccSettings" width="1500">

&nbsp;



# 2. Arbeiten mit Ressorucengruppen
---
&nbsp;

## **2.1 Ressourcengruppen erklärt** 

Ressourcengruppen sind **logische Container**, die zusammengehörige Cloud-Ressourcen (VMs, Datenbanken etc.) organisieren. Sie dienen als zentrale Ankerpunkte, um **IAM-Zugriffsrichtlinien auf die gesamte Gruppe anzuwenden** und so die Berechtigungsverwaltung zu vereinfachen. Zudem ermöglichen sie eine **klare Kostenverfolgung (Billing)** und die **einfache, isolierte Verwaltung** des gesamten Lebenszyklus der enthaltenen Ressourcen.

&nbsp;

<img src="{{ site.baseurl }}/screenshots/Ressourcengruppen.png" alt="Ressoucengruppen_explained" width="1500">

&nbsp;

Der physische Standort der Ressourcen ist für die Gruppierung dabei irrelevant. Eine Ressourcengruppe kann Ressourcen enthalten, die über verschiedene geografische Zonen und Regionen verteilt bereitgestellt wurden.

&nbsp;

<img src="{{ site.baseurl }}/screenshots/res_grp_zonen.png" alt="Ressoucengruppen_explained" width="1500">

&nbsp;

## **2.2 Ressourcengruppen anlegen** 

Planen Sie Ihre Hierarchie, bevor Sie die erste Ressourcengruppe anlegen. Überlegen Sie, ob eine Gliederung nach Umgebungen (Dev/Test), Projekten oder Teams für Ihren Fall am besten geeignet ist. Berücksichtigen Sie dabei, wie Sie Berechtigungen vererben, Kosten zuordnen und Ressourcen im Team verwalten möchten.

Eine Ressourcengruppe wird wie folgt angelegt: 

**1.** Navigieren Sie in der oberen Leiste zu ``Manage``

**2.** Wählen Sie den Unterpunkt ``Account``

**3.** Klicken Sie auf der linken Leiste auf ``Account resources``

**4.** Navigieren Sie in den Unterpunkt ``Resource groups``

**5.** Auf der rechten Seite können Sie nun auf ``Create +`` klicken

&nbsp;

<img src="{{ site.baseurl }}/screenshots/create_rc_grp_.png" alt="Ressoucengruppen_explained" width="1500">

&nbsp;


# 3. Identity and Access Management (IAM)
---
&nbsp;

## **3.1 IAM-Überblick** 

**Identitätsverwaltung (Manage Identities)**

- **Trusted Profiles:** Ermöglichen eine sichere, passwortlose Authentifizierung für Compute-Ressourcen (z. B. Cluster, VPCs) oder föderierte Nutzer. Sie machen die Verwaltung langlebiger Credentials in Anwendungen überflüssig.

- **Service IDs:** Identitäten für Anwendungen, Tools und automatisierte Prozesse. Da sie von menschlichen Benutzern entkoppelt sind, bleiben Workflows auch bei Mitarbeiterwechseln stabil.

- **API Keys:** Berechtigungsnachweise für die Authentifizierung über CLI oder API. Sie können entweder einem persönlichen Benutzerkonto oder einer Service-ID zugeordnet werden, um Aktionen programmatisch auszuführen.

- **Identity Providers:** Ermöglicht die Anbindung externer Firmenverzeichnisse (z. B. via SAML oder OpenID Connect). Benutzer authentifizieren sich mit ihren bestehenden Unternehmens-Zugangsdaten (Single Sign-On).

**Zugriffssteuerung (Manage Access)**

- **Access Groups:** Das wichtigste Instrument für effiziente Rechteverwaltung. IAM-Richtlinien werden einmalig der Gruppe zugewiesen; alle Mitglieder (Benutzer, Service-IDs) erben diese Berechtigungen automatisch.

- **Authorizations:** Regeln den direkten Zugriff zwischen IBM Cloud Services (Service-zu-Service), ohne dass eine Benutzeridentität involviert ist (z. B. ein Kubernetes-Cluster darf auf eine Container Registry zugreifen).

- **Roles:** Definieren die spezifisch erlaubten Aktionen. IBM unterscheidet dabei zwischen ``Plattform-Rollen`` (Verwaltung des COS, z. B. Erstellen/Löschen) und ``Service-Rollen`` (Nutzung des COS , z. B. Daten lesen/schreiben).


<img src="{{ site.baseurl }}/screenshots/IAM_overview.png" alt="IAM_overview" width="1500">

&nbsp;
&nbsp;

**Zugriff auf die IAM-Verwaltung:**

**1.** Klicken Sie in der oberen Navigationsleiste auf ``Manage``

**2.** Wählen Sie im Dropdown-Menü den Punkt ``Acess (IAM)``

In der linken Seitenleiste finden Sie anschließend eine Übersicht aller verfügbaren IAM-Optionen und Einstellungen

<img src="{{ site.baseurl }}/screenshots/IAM_overview2.png" alt="IAM_overview" width="1500">

&nbsp;


## **3.2 Access policys und Access groups**

**Access Policy (Zugriffsrichtlinie):**

Eine Access Policy ist das eigentliche Regelwerk, das definiert, wer (Subjekt) was (Ressource) wie (Rolle) tun darf. Sie besteht im Kern aus:

Der Ziel-Ressource (z. B. "Alle Kubernetes Cluster in Ressourcengruppe X").

Der Rolle (z. B. Viewer oder Administrator).

**Access Groups (Zugriffsgruppen):**

Eine Access Group ist ein logischer Container, der verschiedene Identitäten (Benutzer, Service-IDs, Trusted Profiles) bündelt. Sie dient der effizienten Verwaltung: Anstatt Berechtigungen jedem Nutzer einzeln zuzuweisen, fügen Sie den Nutzer einfach einer Gruppe (z. B. Admins oder Dev-Team) hinzu. Er erbt dann automatisch alle Rechte dieser Gruppe.

**Best Practice:** 

In der Praxis erstellen Sie eine Access Policy und weisen diese einer Access Group zu, die Sie dann User zuweisen. 

Individuelle Policies sind schwer wartbar (nicht skalierbar). Wenn Sie Berechtigungen direkt einzelnen Benutzern zuweisen, müssen Sie bei Änderungen (z. B. Teamwechsel oder Mitarbeiter-Austritt) jeden Benutzer manuell bearbeiten und jede Richtlinie einzeln entfernen. Dies ist extrem zeitaufwendig und fehleranfällig (Sicherheitsrisiko durch vergessene Rechte).

&nbsp;


## **3.3 Access groups erstellen (Plattform Admin Gruppe)** 

Die Erstellung einer Platform Admin Access Group ist einer der wichtigsten ersten Schritte in jedem neuen IBM Cloud Account.

**Warum erstellen wir sie als Erstes?**

Initial verfügt nur der Account Owner über volle Verwaltungsrechte. Dies stellt ein massives Risiko dar (Single Point of Failure): Verlässt der Owner z.B das Unternehmen oder verliert den Zugriff, ist der gesamte Account handlungsunfähig.

Aus diesem Grund erstellen wir bevor irgendeine andere Konfiguration stattfindet diese Gruppe, um Redundanz zu schaffen.

**Zweck der Gruppe:**

Diese Gruppe beinhaltet die Administratoren, die den Account technisch verwalten (User einladen, Billing einsehen, IAM steuern), ohne dabei den Account Owner Login nutzen zu müssen.

**Empfohlene Berechtigungen:**

Diese Gruppe erhält typischerweise die höchsten Rechte, wie z.B.:

- Administrator Rolle auf All Account Management Services (für Billing, Support, User-Management)

- Administrator Rolle auf All Identity and Access enabled services (um anderen Teams Rechte zu geben)


**Befolgen Sie diese Schritte, um die Gruppe für Administratoren anzulegen und mit den notwendigen Rechten auszustatten:**

**1.** Navigieren Sie in der oberen Leiste der IBM Cloud Konsole zum Menüpunkt ``Manage``

**2.** Wählen Sie im Dropdown-Menü den Eintrag ``Access (IAM)`` aus

**3.** Orientieren Sie sich in der linken Seitenleiste am Bereich ``Manage Access``

**4.** Klicken Sie dort auf den Unterpunkt ``Access groups``

**5.** Starten Sie die Erstellung einer neuen Gruppe durch Klick auf den blauen Button ``Create +``

**6.** Geben Sie der Gruppe einen eindeutigen Namen (z. B. Platform-Admins) und eine kurze Beschreibung. Bestätigen Sie anschließend mit ``Create``

**7.** Sie befinden sich nun in der Übersicht der neuen Gruppe. Klicken Sie oben in der Reiter-Leiste auf ``Access``

**8.** Klicken Sie auf den blauen Button ``Assign access +``, um den Prozess der Rechtevergabe zu starten.

**9.** Wählen Sie im ersten Schritt unter "Service" die Option ``All Account Management Services`` aus (dies steuert Zugriff auf Billing, User-Invites etc.)

**10.** Scrollen Sie zu "Roles and actions" und setzen Sie das Häkchen bei der ``Rolle Administrator``

**11.** Klicken Sie unten auf den Button ``Add``, um diese Regel vorzumerken

**12.** Legen Sie nun direkt die zweite Policy an: Wählen Sie diesmal als Service die Option ``All Identity and Access enabled services aus`` (dies ermöglicht Zugriff auf alle Ressourcen-Instanzen)

**13.** Wählen Sie unter "Roles and actions" auch hier erneut die Rolle ``Administrator`` aus

**14.** Fügen Sie diese zweite Regel ebenfalls mit einem Klick auf ``Add`` hinzu

**15.** Auf der rechten Seite sehen Sie nun im Bereich Summary eine Zusammenfassung der vorgemerkten Richtlinien. Überprüfen Sie die Auswahl und schließen Sie den Vorgang mit einem Klick auf ``Assign`` endgültig ab

&nbsp;

<img src="{{ site.baseurl }}/screenshots/admin_agrp1.png" alt="IAM_overview" width="1500">

<img src="{{ site.baseurl }}/screenshots/admin_agrp2.png" alt="IAM_overview" width="1500">

<img src="{{ site.baseurl }}/screenshots/admin_agrp3.png" alt="IAM_overview" width="1500">

<img src="{{ site.baseurl }}/screenshots/admin_agrp4.png" alt="IAM_overview" width="1500">

&nbsp;


## **3.4 User einladen (Admins)** 

Um neuen Mitarbeitern oder Usern Zugriff auf Ihr IBM Cloud Konto zu gewähren, müssen diese explizit eingeladen werden.

Befolgen Sie dazu folgende Schritte:

**1.** Navigieren Sie in der oberen Leiste zu ```Manage```

**2.** Klicken Sie auf ```Access (IAM)```

**3.** Wählen Sie in der linken Leiste  ``Manage identities`` 

**4.** Wählen Sie den Punkt ``Users`` aus

**5.** Klicken Sie nun auf den blauen Button ``Invite users +``

**6.** Wählen Sie zwischen ``Access groups`` und ``Access policy``

**8.** Wählen Sie Ihre Platform Admin ``Access group`` aus

**9.** Klicken Sie zuletzt auf ``Invite`` um die User einzuladen

&nbsp;

<img src="{{ site.baseurl }}/screenshots/invite_useres1.png" alt="user_invite1" width="1500">

<img src="{{ site.baseurl }}/screenshots/invite_users2.png" alt="user_invite2" width="1500">

&nbsp;

## **3.5 Konzept: Platform Access vs. Service Access**

Ein häufiges Missverständnis in IAM ist der Unterschied zwischen der Verwaltung der Ressource selbst und der Nutzung der darin enthaltenen Daten. IBM Cloud trennt diese Berechtigungen strikt.

Am Beispiel von Cloud Object Storage (COS) lässt sich dies am besten erklären:

**1. Platform Access (Verwaltung der "Hülle"):**

Der Platform Access bezieht sich auf Aktionen, die auf der Ebene der IBM Cloud Konsole stattfinden. Es geht darum, den Lebenszyklus des Services zu steuern, nicht dessen Inhalt.

**Fokus:** 

Management der Service-Instanz

**Typische Rollen:** Viewer, Editor, Administrator

**Beispiel COS:**

- Ein Benutzer mit der Rolle Editor kann eine neue COS-Service-Instanz erstellen oder den Namen der Instanz ändern

- Er kann die Instanz einer Ressourcengruppe zuordnen

- **Aber:** Er kann (ohne Service Access) nicht sehen, welche Dateien in den Buckets liegen oder Dateien hochladen

**2. Service Access (Nutzung des "Inhalts")**

Der Service Access bezieht sich auf Aktionen, die innerhalb des Services stattfinden, meistens über API-Aufrufe oder direkte Datenoperationen. Es geht um den Zugriff auf die eigentlichen Daten.

**Fokus:** Nutzung der API und Datenmanipulation

**Typische Rollen:** Reader, Writer, Manager

**Beispiel COS:**

- Ein Benutzer mit der Rolle Writer kann Dateien (Objekte) in einen Bucket hochladen oder löschen

- Ein Benutzer mit der Rolle Reader kann Dateien herunterladen

- **Aber:** Er kann die COS-Instanz selbst nicht löschen oder andere Benutzer dazu einladen

&nbsp;

<img src="{{ site.baseurl }}/screenshots/platform:service.png" alt="platform/service" width="1500">

&nbsp;

<img src="{{ site.baseurl }}/screenshots/platform:service_excalidraw.png" alt="platform/service" width="1100">

&nbsp;

## **3.6 Custom Roles erstellen**

Wenn die Standardrollen (wie Viewer, Editor, Admin) zu ungenau sind oder zu viele Rechte gewähren, kommen Custom Roles zum Einsatz. Sie ermöglichen eine maßgeschneiderte Zugriffssteuerung nach dem Least-Privilege-Prinzip (Nutzer erhalten nur die minimal nötigen Rechte).

**Wie es funktioniert:** 

Anstatt ein fertiges Rollen-Paket zu übernehmen, wählen Sie aus einer Liste spezifische Service-Aktionen aus und bündeln diese zu einer neuen Rolle.

**Beispiel:** 

Sie möchten, dass ein Operator virtuelle Server neu starten und stoppen darf, aber er soll keine Berechtigung haben, Server zu löschen oder neue zu erstellen.

**Standardrolle Editor:** Wäre zu mächtig (darf auch löschen).

**Custom Role:** Sie erstellen eine Rolle namens "VM-Operator" und fügen nur die Aktionen instance.start und instance.stop hinzu.


**Um eine benutzerdefinierte Rolle (Custom Role) zu erstellen, navigieren Sie wie folgt:**

**1.** Gehen Sie in der oberen Leiste auf ``Manage``

**2.** Wählen Sie den Eintrag ``Access (IAM)``

**3.** Klicken Sie in der linken Seitenleiste auf ``Roles``

**4.** Starten Sie den Prozess mit einem Klick auf ``Create +``

Im anschließenden Menü definieren Sie die Eigenschaften der Rolle. Vergeben Sie zunächst einen aussagekräftigen Namen und eine Beschreibung. Wählen Sie danach den Ziel-Service aus und fügen Sie die gewünschten Berechtigungen (Actions) granular hinzu. Sobald Sie alle Aktionen ausgewählt haben, bestätigen Sie die Erstellung abschließend über den Button Create.

&nbsp;

<img src="{{ site.baseurl }}/screenshots/custom_roles_1.png" alt="platform/service" width="1500">

<img src="{{ site.baseurl }}/screenshots/custom_roles_2.png" alt="platform/service" width="1500">

&nbsp;

## **3.7 Context Based Restrictions (CBR)**

Context Based Restrictions (CBR) erweitern das klassische IAM um eine weitere entscheidende Dimension.

Während IAM ausschließlich regelt, **wer (Identität)** auf eine Ressource zugreifen darf, definiert CBR zusätzlich, **von wo (Netzwerk-Kontext)** dieser Zugriff erfolgen muss. Es fungiert somit als eine netzwerkbasierte Sicherheitsschicht, die nach der erfolgreichen Authentifizierung geprüft wird.

**Das Konzept basiert auf zwei Hauptkomponenten:**

**1. Rules (Regeln)**

Hier verknüpfen Sie eine Zone mit einem Cloud Service. Eine Regel besagt beispielsweise: "Der Zugriff auf den Cloud Object Storage Bucket X ist nur erlaubt, wenn die Anfrage aus der Zone 'Firmen-VPN' kommt."

**Warum ist das wichtig?**

Durch diese zusätzliche Dimension schützt CBR effektiv vor Credential Theft. Selbst wenn ein Angreifer einen gültigen API-Key stiehlt (das "Wer" ist korrekt), wird der Zugriff verweigert, da er nicht aus dem sicheren Firmennetzwerk kommt (das "Wo" ist falsch).


**2. 
Network Zones (Netzwerkzonen)**

Hier definieren Sie vertrauenswürdige Ursprungsorte. Eine Zone ist eine "Allowlist" und kann beinhalten:

Spezifische IP-Adressbereiche (z. B. das Firmen-VPN)

Andere IBM Cloud VPCs

Service References (um Cloud-Services untereinander zu autorisieren)

**Um Context-Based Restrictions einzurichten, navigieren Sie wie folgt:**

**1.** Gehen Sie in der oberen Leiste auf ``Manage``

**2.** Wählen Sie den Eintrag ``Context-based restrictions``

**3.** Wählen Sie anschließend den gewünschten Bereich: ``Rules`` oder ``Network zones``

 <img src="{{ site.baseurl }}/screenshots/cbr1.png" alt="platform/cbr1" width="1500">

 &nbsp;

**Network-Based vs. Identity-Based Protection - wann macht CBR Sinn?**

&nbsp;

 <img src="{{ site.baseurl }}/screenshots/cbr2.png" alt="platform/cbr2" width="1500">

 &nbsp;

Eine sichere Cloud-Architektur nutzt das Prinzip "Defense in Depth" und kombiniert zwei grundlegende Schutzebenen:

**1. Network-Based Protection (Die Infrastruktur-Ebene)**

Hier wird der Datenverkehr auf Basis von **IP-Adressen, Ports und Protokollen** gesteuert. Es geht darum, ob ein Datenpaket physisch ankommen darf.

``Security Groups``: Eine **Stateful Firewall**, die direkt an der virtuellen Server-Instanz (VSI) sitzt. Sie regelt exakt, welcher Traffic den Server erreichen oder verlassen darf.

``Access Control Lists (ACLs)``: Ein **Stateless Filter** auf Subnetz-Ebene. Sie fungieren als erste Barriere und steuern, was überhaupt in das Subnetz hinein- oder herausfließen darf.

**2. Identity-Based Protection (Die Logik-Ebene)**

Hier wird der Zugriff auf Basis von **Identitäten und Kontext** gesteuert. Es geht darum, ob ein Benutzer oder Dienst eine Aktion (API-Call) ausführen darf, selbst wenn er netzwerktechnisch Zugriff hätte.

``IAM``: Regelt das **"Wer" und "Was"**. Es authentifiziert den User und prüft, ob er die notwendigen Rechte (Rollen) hat.

``Context-Based Restrictions (CBR)``: Verknüpft die Identität mit dem Netzwerk. Es prüft, ob der authentifizierte User auch aus einem erlaubten Netzwerk kommt.

 &nbsp;

**Zusammenfassung:**

- **Network Protection** verhindert, dass unerwünschte Datenpakete Ihre Server erreichen (z. B. Hacker-Portscans). 

- **Identity Protection** verhindert, dass authentifizierte Nutzer unerlaubte Aktionen durchführen oder gestohlene Zugangsdaten von unsicheren Orten genutzt werden.

&nbsp;


# 4. Umgang mit Ressourcen
---
&nbsp;

## **4.1 Navigieren im Katalog** 

Der Katalog ist der zentrale Marktplatz und Einstiegspunkt für alle Dienste und Softwarelösungen in der IBM Cloud. Er dient dazu, Ressourcen zu entdecken, auszuwählen und bereitzustellen (Provisioning).

**Der Inhalt unterteilt sich in vier Hauptbereiche:**

**Services:** Von IBM verwaltete Dienste (Managed Services) wie Datenbanken, Storage oder Compute-Ressourcen

**Software:** Installierbare Komponenten wie Container-Images, Helm-Charts oder Operatoren (z. B. für OpenShift), sowohl von IBM als auch von zertifizierten Drittanbietern

**Deployable Architectures:** Vorgefertigte Infrastruktur-Templates (IaC), um komplexe Umgebungen sicher und compliant aufzusetzen

**Professional Services:** Beratungs- und Implementierungsdienstleistungen. Hier finden Sie Expertenunterstützung von IBM oder Partnern für spezifische Vorhaben wie Migrationen, Architektur-Design oder Modernisierungsprojekte


**Zusätzlich:**

**Private Catalog:** Unternehmen können private Kataloge erstellen. Diese dienen dazu, eigene Softwarelösungen oder genehmigte Versionen von Public-Services intern für Teams bereitzustellen und deren Zugriff zentral zu steuern

&nbsp;

Um zum Katalog zu gelangen, gehen Sie wie folgt vor:

**1.** Klicken Sie in der oberen Leiste auf Catalog

**2.** Durchsuchen Sie das Angebot von über 250 Produkten über die Suchleiste oder nutzen Sie die verschiedenen Filtermöglichkeiten

<img src="{{ site.baseurl }}/screenshots/catalog1.png" alt="catalog1" width="1500">

&nbsp;


## **4.2 Provisionieren von Ressourcen aus dem Katalog**

Sobald Sie den gewünschten Service im Katalog gefunden haben, führen Sie die folgenden Schritte zur Bereitstellung aus:

**Service auswählen:** Suchen Sie nach dem Namen der Ressource und klicken Sie auf die entsprechende Kachel. Sie gelangen nun auf die Konfigurationsseite des Services.

**Informationen einholen:** Bevor Sie die Ressource erstellen, können Sie sich über die Tabs im oberen Bereich informieren:

**About:** Hier finden Sie eine Übersicht der Funktionen, verfügbare Pläne und Preismodelle.

**Docs:** Dieser Link führt Sie direkt zur offiziellen technischen Dokumentation, um Details zur Einrichtung und Nutzung zu erfahren.

**Konfiguration & Preis prüfen:** Wählen Sie Ihre gewünschte Region und den Preisplan aus. Achten Sie dabei auf die rechte Seitenleiste. Dort wird Ihnen dynamisch eine Kostenschätzung (Cost Summary) angezeigt. Je nach Service und Plan kann der Preis in verschiedenen Intervallen ausgewiesen sein (z. B. Hourly für kurzfristige Nutzung oder Monthly für langfristige Kalkulationen).

**Erstellen:** Sobald Sie alle Einstellungen vorgenommen haben und mit dem angezeigten Preis einverstanden sind, schließen Sie den Vorgang mit einem Klick auf den Button ``Create`` ab. Die Ressource wird nun provisioniert.

&nbsp;

<img src="{{ site.baseurl }}/screenshots/catalog2.png" alt="catalog2" width="1500">

&nbsp;

## **4.3 Managen / löschen von Ressourcen**


Um einen Überblick über provisionierte Ressourcen/Services zu erhalten, navigieren Sie wie folgt:

**1.** Klicken Sie oben links auf das ``Hamburger-Menü (Navigationsmenü)``

**2.** Wählen Sie den Punkt ``Resource list`` aus

In der nun angezeigten Übersicht haben Sie diverse Möglichkeiten, Ihre Ressourcen effizient zu organisieren:

- Sie können die Liste gezielt **nach Namen oder Ressourcengruppen filtern**, um spezifische Dienste schneller zu finden. 

- Zudem haben Sie die **Möglichkeit, Tags zu bearbeiten oder Ressourcen direkt aus der Liste heraus zu löschen**. 

- Ein Klick auf den Namen einer Ressource öffnet deren individuelles Dashboard. Dort gelangen Sie in das detaillierte Menü, um die Instanz weiter zu **konfigurieren, zu bearbeiten oder sie endgültig zu entfernen**.

&nbsp;

<img src="{{ site.baseurl }}/screenshots/catalog4_.png" alt="catalog2" width="1500">

<img src="{{ site.baseurl }}/screenshots/catalog3.png" alt="catalog2" width="1500">

&nbsp;

# 5. Billing and Usage 
---
&nbsp;

## **5.1 Billing and Usage Overview**

Der zentrale Einstiegspunkt in das Kostenmanagement ist die Overview-Seite. Sie bietet eine hochgerechnete Zusammenfassung des aktuellen finanziellen Status Ihres Accounts, ohne sofort in komplexe Datentabellen einzutauchen.

**Wichtige Kennzahlen auf einen Blick, hier erhalten Sie sofortige Auskunft über:**

**Usage summary:** 

Zeigt die Kosten der vergangenen Monate, die geschätzten Gesamtkosten für den laufenden Monat bis zum jetzigen Zeitpunkt und eine Kostenvorhersage für den kommenden Monat

**Recent Invoices:** 

Eine Auflistung der Rechnungen der letzten Monate inklusive Betrag und Zahlungsstatus

**Billing Period:** 

Gibt das Start- und Enddatum des aktuellen Abrechnungszyklus an.

**Commitments & Subscriptions:** 

Eine Übersicht über vertragliche Mindestabnahmen, Abonnements oder verfügbares Guthaben

**Spending notifications:** 

Zeigt den Status Ihrer konfigurierten Warnmeldungen an (z. B. ob Budgetgrenzen fast erreicht sind).

&nbsp;

Navigation zu Billing and Usage:

**1.** Klicken Sie in der oberen Leiste auf ``Manage``

**2.** Wählen Sie ``Billing and usage``

**3.** Sie landen standardmäßig direkt auf dem Reiter ``Overview``

<img src="{{ site.baseurl }}/screenshots/billingandusage1.png" alt="billingandusage1" width="1500">

&nbsp;

## **5.2 Usage** 

Der Bereich Usage ist Ihr primäres Werkzeug, um die monatliche Rechnung zu validieren. Er ermöglicht es Ihnen, Kosten präzise auf Ressourcengruppen herunterzubrechen und bis zur einzelnen technischen Metrik nachzuvollziehen.

**Navigation:** Wählen Sie im linken Menü unter ``Billing and usage`` den Punkt ``Usage``

<img src="{{ site.baseurl }}/screenshots/billingandusage2.png" alt="billingandusage2" width="1500">

&nbsp;


**Der Analyse-Workflow (Drill-down):**

Gehen Sie wie folgt vor, um die Kostenentstehung im Detail zu prüfen:

**Zeitraum und Gruppierung wählen:** 

Wählen Sie oben rechts den gewünschten Monat. Ändern Sie anschließend die Ansicht bei "Group by" auf die gewünschte Resource Group

**Ergebnis:** 

Sie sehen sofort, welche Kosten die gewählte Ressourcengruppe in diesem Monat verursacht hat

<img src="{{ site.baseurl }}/screenshots/billingandusage3.png" alt="billingandusage3" width="1500">

&nbsp;


**Usage nach Service, Plan und Region prüfen:** 

Klicken Sie auf ``View plans``, um die Usage eines Services einzusehen 

(Sie können auch direkt in der ``Usage`` Startansicht einen Service wählen und auf ``View plans`` gehen)

**Ergebnis:** 

Sie sehen auf einen Blick den genutzten Plan (z. B. Standard oder Enterprise) und die Region (z. B. Frankfurt), in der die Kosten angefallen sind. Sie können auch hier den Filter wieder auf einen bestimmten Monat und Resourcengruppe legen

<img src="{{ site.baseurl }}/screenshots/billingandusage4.png" alt="billingandusage4" width="1500">

<img src="{{ site.baseurl }}/screenshots/billingandusage5.png" alt="billingandusage5" width="1500">

&nbsp;


**Verbrauchseinheiten analysieren:** 

Klicken Sie bei einem Service auf ``View details``

**Ergebnis:** 

Hier sehen Sie die gesamte Aufschlüsselung der Abrechnungsmetriken für diesen Service. Sie erkennen genau, was berechnet wurde, z. B.:

GIGABYTE_HOURS (Wie viel Speicher wurde wie lange belegt?)

MILLION_API_CALLS (Wie oft wurde der Service angesprochen?)

IP_HOURS (Kosten für reservierte IPs).

<img src="{{ site.baseurl }}/screenshots/billingandusage6_.png" alt="billingandusage6" width="1500">

<img src="{{ site.baseurl }}/screenshots/billingandusage7.png" alt="billingandusage7" width="1500">

&nbsp;



**Tiefenanalyse auf Instanz-Ebene:** 

Um genau zu wissen, welche konkrete Instanz(Resourcengruppe) für welche Kosten verantwortlich ist und wie genau die Kosten aufgeschlüsstelt werden, klicken Sie auf ``View instance details``

**Ergebnis:** 

Sie bohren noch eine Ebene tiefer. Jetzt sehen Sie jede einzelne Instanz(Resourcengruppe) und deren individuellen Beitrag zu den Gesamtkosten.

**Zusammenfassung:**

Im Bereich Usage bewegen Sie sich vom "Großen ins Kleine": Von der Ressourcengruppe über den Service-Plan hin zu den technischen Metriken und schließlich zur einzelnen Instanz.

<img src="{{ site.baseurl }}/screenshots/billingandusage8.png" alt="billingandusage8" width="1500">

<img src="{{ site.baseurl }}/screenshots/billingandusage9.png" alt="billingandusage9" width="1500">

&nbsp;

**Tipp:** Sie können sich die Ausgaben aller Ebenen als CSV ausgeben lassen indem Sie auf ``Export CSV`` im rechten oberen Feld klicken.

&nbsp;

## **5.3 Cost Analysis**

Die Cost Analysis dient dazu, Ihre Ausgaben strategisch zu untersuchen. Sie bietet Ihnen leistungsstarke Werkzeuge, um nicht nur Gesamtsummen zu sehen, sondern die Kostentreiber durch präzise Filterung zu isolieren und visuell aufzubereiten.

**Navigation:** 

Wählen Sie im linken Menü unter Billing and usage den Punkt Cost analysis

**Funktionen und Filter:**

Um die Kostenanalyse genau auf Ihre Fragestellung zuzuschneiden, bietet die Seitenleiste eine Vielzahl an Filtern. Sie können die Anzeige unter anderem nach folgenden Kategorien einschränken:

- ``Region``

- ``Service``

- ``Plan``

- ``Instance & Instance ID``

- ``Resource group``

- ``Category``

- ``Tags``

...und weiteren spezifischen Kriterien

**Time frame:**

Über das Dropdown-Menü Time frame bestimmen Sie den Betrachtungszeitraum (z. B. 3 months, 6 months), um Entwicklungen über einen längeren Zeitraum zu vergleichen

**Group by:** 

Ganz oben können Sie über Group by festlegen, wie die Daten im Diagramm zusammengefasst werden sollen (z. B. Kosten gruppiert nach Ressourcengruppe oder Service), um Trends sofort visuell zu erfassen.

<img src="{{ site.baseurl }}/screenshots/costanalysis.png" alt="costanalysis" width="1500">

&nbsp;

**Unterschied zu Usage:** 

Der entscheidende Unterschied liegt im Zeitbezug und der Visualisierung. 

Während der Bereich Usage Ihnen eine statische, tabellarische Abrechnung für einen einzelnen Monat liefert (Fokus: Rechnungsprüfung), visualisiert die Cost Analysis die Entwicklung über mehrere Monate hinweg (Fokus: Trenderkennung). Sie nutzen **Usage**, um exakt zu sehen, **"was" berechnet wurde**, und **Cost Analysis**, um zu verstehen, **"wie" sich die Kosten entwickeln**.


&nbsp;

## **5.4 Spending Notifications**

Damit Sie nicht täglich aktiv das Dashboard überprüfen müssen, bietet IBM Cloud Spending Notifications. Dies sind automatische Warnmeldungen, die Sie per E-Mail informieren, sobald Ihre Ausgaben einen definierten Schwellenwert erreichen.

**So erstellen Sie eine Benachrichtigung:**

**1.** Navigieren Sie zu ``Manage ``> ``Billing and usage`` 

**2.** Wählen Sie im linken Menü den Punkt ``Spending notifications``

**3.** Klicken Sie auf den Button ``Create``

<img src="{{ site.baseurl }}/screenshots/spending_notifications1.png" alt="spending_notifications1" width="1500">

&nbsp;


**Konfiguration der Warnung:**

**Service:** 

Entscheiden Sie, für welchen Service die Benarichtigung gelten soll


**Recipients**: Geben Sie die E-Mail-Adressen der Personen an, die benachrichtigt werden sollen (z. B. der Account Owner oder der Projektleiter).


**Threshold:**

Legen Sie einen Geldbetrag fest (z. B. 500 USD). Sie können dann einstellen, bei wie viel Prozent dieses Betrags gewarnt werden soll (z. B. Benachrichtigung bei 80%, 90% und 100% des Budgets).


Bestätigen Sie die Einrichtung abschließend mit einem Klick auf ``Create``


<img src="{{ site.baseurl }}/screenshots/spending_notifications2.png" alt="spending_notifications2" width="1500">

&nbsp;

# 6. Enterprise Accounts 
---
&nbsp;

## **6.1 Enterprise Account Basics**

Ein Enterprise Account ist eine **administrative Hierarchie**, die es großen Organisationen ermöglicht, mehrere IBM Cloud Accounts unter einem zentralen Dach zusammenzufassen. Dies vereinfacht die Verwaltung, Abrechnung und Governance erheblich.

<img src="{{ site.baseurl }}/screenshots/EnterpriseAccountArch.png" alt="EnterpriseBasics1" width="1200">

&nbsp;

**Die Vorteile und Funktionen gliedern sich in drei Hauptbereiche:**

- **Zentralisierte Abrechnung & Kostenmanagement**

    Der Enterprise Account fungiert als zentrale Zahlstelle für alle untergeordneten Accounts.

   **Konsolidierte Rechnung:** 
   
   Anstatt vieler Einzelrechnungen erhalten Sie eine einzige, konsolidierte Rechnung für das gesamte Unternehmen.

    **Credit Pooling:** 
    
    Subscription Credits (Guthaben) werden auf Enterprise-Ebene in einem gemeinsamen Pool gesammelt. Alle Accounts in der Hierarchie bedienen sich aus diesem Pool, um ihre "Entitlements" zu decken. Das verhindert, dass Guthaben in einem Account verfällt, während ein anderer Account extra zahlen muss.

    **Downstream visibility:**
    
    Obwohl die Rechnung zentral bezahlt wird, bietet das System volle Transparenz über den Verbrauch der einzelnen Accounts. Das Unternehmen kann so genau ermitteln, welche Abteilung oder welches Projekt wie viele Kosten verursacht hat, und diese intern weiterverrechnen.

    <img src="{{ site.baseurl }}/screenshots/EnterpriseAccountCreditPool.png" alt="EnterpriseBasicsCreditPool" width="1200">

    &nbsp;

- **Flexible Account-Hierarchie**

    Sie können die Struktur Ihres Unternehmens in der Cloud exakt abbilden.

    **Account-Integration:** 
    
    Sie haben die Flexibilität, jederzeit völlig neue Accounts zu erstellen oder bereits bestehende Accounts nachträglich in die Enterprise-Hierarchie zu importieren.

    **Ressourcennutzung:** 
    
    Wichtig zu verstehen ist, dass die eigentlichen Ressourcen (Server, Datenbanken) weiterhin auf Account-Ebene konsumiert und betrieben werden. 
    ***Der Enterprise-Account dient lediglich der Verwaltung.***

    **Einheitlicher Support:** 
    
    Das Support-Level (z. B. Premium oder Advanced) wird zentral festgelegt und gilt automatisch für jeden Account innerhalb der Hierarchie.

    <img src="{{ site.baseurl }}/screenshots/EnterpriseAccountRessources2.png" alt="EnterpriseBasicsRessources2" width="1200">

    &nbsp;

    <img src="{{ site.baseurl }}/screenshots/EnterpriseAccountRessources.png" alt="EnterpriseBasicsRessources" width="1200">

    &nbsp;

- **Governance und Sicherheit**

    Der Enterprise Account bietet eine zentrale Steuerungsebene für Richtlinien.

    **Zentrale Policies:** 
    
    Sie können Governance-Regeln und Zugriffsrichtlinien (IAM) zentral definieren und nach unten vererben. Dies stellt sicher, dass Sicherheitsstandards unternehmensweit eingehalten werden, ohne jeden Account einzeln konfigurieren zu müssen.

    <img src="{{ site.baseurl }}/screenshots/EnterpriseAccountGovernance.png" alt="EnterpriseBasicsGovernance" width="1200">

    
&nbsp;

## **6.2 Enterprise Account Beispielarchitekturen**

&nbsp;

- **Automobilhersteller**
&nbsp;


<img src="{{ site.baseurl }}/screenshots/EnterpriseAccountCarco_.png" alt="EnterpriseAccountCarco" width="1200">


&nbsp;

- **Business Partner mit Endkunden**

&nbsp;

<img src="{{ site.baseurl }}/screenshots/EnterpriseAccountBP_.png" alt="EnterpriseAccountBP" width="1000">

&nbsp;

# 7. Zusätzliche Informationen
---
&nbsp;

## **7.1 Support Center** 

Das Support Center ist Ihre zentrale Anlaufstelle für alle technischen Anfragen, Problemmeldungen und Hilfestellungen rund um die IBM Cloud Platform und ihre Services.

**Navigation:** 

Klicken Sie in der oberen Navigationsleiste auf ``Help`` und dann den Menüpunkt ``Support center``

**Die wichtigsten Funktionen:**

- **Case Management (Tickets):** 

    Hier können Sie neue Support-Fälle ("Cases") erstellen, wenn Sie auf technische Probleme stoßen. Die Bearbeitungszeit hängt dabei von dem Scheweregrad und Ihrem Support Plan ab 

- **FAQs & Dokumentation:**

    Bevor Sie ein Ticket eröffnen, können Sie die integrierte Suche nutzen, um in der Wissensdatenbank nach bekannten Lösungen und Best Practices zu recherchieren.


<img src="{{ site.baseurl }}/screenshots/SupportCenter.png" alt="SupportCenter" width="1250">

&nbsp;

## **7.2 Wichtigkeit von Notifications** 

In einer dynamischen Cloud-Umgebung ist das regelmäßige Prüfen der Benachrichtigungen ***(Glocken-Symbol oben rechts)*** keine optionale Aufgabe, sondern eine betriebsnotwendige Pflicht.

Das Ignorieren dieser Meldungen kann gravierende Folgen für die Stabilität Ihrer Anwendungen haben. 

**IBM Cloud nutzt diesen Kanal für kritische Informationen:**

**Deprecations (Abkündigungen):**

Cloud-Services und Runtimes entwickeln sich ständig weiter. Wenn eine bestimmte Datenbank-Version oder Software-Komponente ihr "End of Life" erreicht, werden Sie hier im Voraus gewarnt. Übersehen Sie diese Warnung, kann es passieren, dass Ihre Anwendung von einem Tag auf den anderen nicht mehr funktioniert oder nicht mehr bereitgestellt werden kann.

**Geplante Wartungsarbeiten:**

Sie erhalten Informationen über anstehende Updates an der physischen Infrastruktur oder den Services. Dies gibt Ihnen die Zeit, Hochverfügbarkeits-Mechanismen zu prüfen oder Wartungsfenster einzuplanen.

**Required Actions (Handlungsbedarf):** 

Oft erfordern Sicherheitsupdates eine aktive Handlung Ihrerseits (z. B. "Starten Sie den Cluster neu, um den Sicherheitspatch anzuwenden").

**Empfehlung:**

Prüfen Sie das Notification Center regelmäßig auf Meldungen der Kategorien High oder Critical, um ungeplante Ausfälle ("Silent Failures") zu vermeiden.

**Zusätzlich:**

- **Cloud Status**: 
    
    Über das Support Center > ``View cloud status`` erreichen Sie das zentrale Dashboard zur Überwachung der gesamten IBM Cloud Plattform. 
    
    Hier prüfen Sie nicht nur die aktuelle Verfügbarkeit aller Services (Overview), sondern erhalten auch Einblick in **geplante Wartungsarbeiten** (Planned maintenance), **kritische Sicherheitswarnungen** (Security bulletins), **Ursachenberichte zu vergangenen Störungen** (Incident reports), sowie **Release Notes** und **Announcements**

<img src="{{ site.baseurl }}/screenshots/Notifications.png" alt="Notifications" width="1500">

&nbsp;

## **7.3 Kostenschätzungen** 

Der Cost Estimator ist ein integriertes Planungswerkzeug, mit dem Sie die monatlichen Kosten für Ihre geplante Infrastruktur prognostizieren können, bevor Sie Ressourcen bereitstellen. Er eignet sich ideal, um Budgets zu planen oder Genehmigungen einzuholen.

**So nutzen Sie das Tool:**

**Im Katalog:**

Wenn Sie einen Service konfigurieren, sehen Sie in der rechten Seitenleiste die aktuelle Preisschätzung. Anstatt direkt auf Create zu klicken, wählen Sie den Button ``Add to estimate``. Dies fügt die Konfiguration Ihrem vorläufigen Warenkorb hinzu.

**Schätzung überprüfen:** 

Klicken Sie in der oberen Kopfzeile der Konsole auf das Taschenrechner-Symbol (Cost estimator). Hier sehen Sie die gesammelte Liste aller hinzugefügten Services.

&nbsp;

**Funktionen in der Übersicht:**

**Anpassung:** 

Sie können Mengen (z. B. Anzahl der Server oder GB Speicher) nachträglich ändern, um verschiedene Szenarien durchzuspielen.

**Währung:**

Stellen Sie die Anzeige auf Ihre lokale Währung um.

**Export:** 

Über den Button Download CSV/XLSX oder Print/PDF können Sie einen offiziellen Kostenvoranschlag generieren, um diesen beispielsweise an die Finanzabteilung zur Freigabe weiterzuleiten.

<img src="{{ site.baseurl }}/screenshots/CostEstimator.png" alt="CostEstimator" width="1500">

&nbsp;

## **7.3 Dokumentationen**

Die [offizielle Dokumentation](https://cloud.ibm.com/docs) ist Ihre wichtigste Wissensquelle. Sie bietet technische Referenzen, die für den sicheren Betrieb unerlässlich sind.

**Wie Sie zur Dokumentation gelangen:**

Sie haben zwei Wege, um auf die Inhalte zuzugreifen:

**Global:**

Klicken Sie in der oberen Kopfzeile der Konsole auf den Eintrag ``Docs`` unter dem ``? Symbol``. Dies führt Sie zur zentralen Startseite mit einer Suche über alle Dienste.

**Kontextbezogen:**

 Wenn Sie sich gerade in der Konfiguration eines spezifischen Services (z. B. COS) befinden, klicken Sie im linken oder oberen Menü auf den Reiter ``Docs``. Dies bringt Sie direkt zu den spezifischen Anleitungen für genau diesen Dienst.

&nbsp;

**Warum Sie die Docs nutzen sollten:**

**Schritt-für-Schritt-Tutorials:** 

Anstatt durch "Trial and Error" Zeit zu verlieren, finden Sie hier geprüfte Anleitungen ("Getting Started"), um Ressourcen korrekt und nach Best Practices aufzusetzen.

**API & CLI Referenzen:**

Für Entwickler und Automatisierung sind hier alle Befehle, Endpunkte und SDKs dokumentiert, die Sie benötigen, um die Cloud programmatisch zu steuern.

**Troubleshooting:** 

Bevor Sie ein Support-Ticket eröffnen, finden Sie im Bereich "Troubleshooting" oft schnelle Lösungen für gängige Fehlermeldungen und Konfigurationsprobleme.

<img src="{{ site.baseurl }}/screenshots/Docs.png" alt="Docs1" width="1500">

<img src="{{ site.baseurl }}/screenshots/Docs2.png" alt="Docs2" width="1500">

&nbsp;

# 8. Best practices
---

| Typ | Beschreibung |
| :--- | :--- |
| Cluster-Prod | OpenShift |  
| Datenbank-V1 | PostgreSQL |  
| Archiv-Speicher | COS |  

