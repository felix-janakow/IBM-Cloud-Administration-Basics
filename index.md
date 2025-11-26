---
layout: default
---

# 1. Erste Schritte
---
&nbsp;

## **1.1 Login im IBM Cloud Portal**

Der erste Schritt zur Arbeit mit der IBM Cloud ist die Anmeldung im IBM Cloud Portal

1. Öffnen Sie die Login-Seite: [IBM Cloud Login](cloud.ibm.com/login)
2. Geben Sie ihre Zugangsdaten (Benutzername und Passwort) ein
3. Bestätigen Sie die Anmeldung, um Zugriff auf das IBM Cloud Dashboard zu erhalten

<img src="{{ site.baseurl }}/screenshots/IBMCloud_Login.png" alt="IBM Cloud Login" width="550">


## **1.2 Multi-Faktor-Authentisierung (MFA) aktivieren**

Nach der Anmeldung im IBM Cloud Account sollte der nächste Schritt die Aktivierung der Multi-Faktor-Authentifizierung (MFA) sein.

**Warum MFA?** 

Ein ausschließlich passwortgeschütztes Konto erfüllt heutzutage nicht mehr die gängigen Sicherheitsanforderungen. MFA ist in vielen Bereichen wie Banking oder sozialen Netzwerken bereits Standard und wird auch in der IBM Cloud **als Best Practice empfohlen**.

**Um MFA zu aktivieren befolgen Sie folgende Schritte:**

1. Navigieren Sie in der oberen Leiste zu ``Manage`` und wählen Sie den Unterpunkt ``Access (IAM)``
2. In der linken Seitenleiste klicken Sie auf ``Settings``
3. Unter ``Settings`` wechseln Sie zu ``Authentication``

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

1. Navigieren Sie in der oberen Leiste zu ``Manage`` und 
2. Wählen Sie den Unterpunkt ``Account``
2. Klicken Sie in der Seitenleiste auf ``Account Settings``

&nbsp;

<img src="{{ site.baseurl }}/screenshots/Settins1-2.png" alt="AccSettings" width="1500">

<img src="{{ site.baseurl }}/screenshots/Settings2-2_.png" alt="AccSettings" width="1500">

&nbsp;

# 2 Arbeiten mit Ressorucengruppen
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

1. Navigieren Sie in der oberen Leiste zu ``Manage`` und 
2. Wählen Sie den Unterpunkt ``Account``
3. Klicken Sie auf der linken Leiste auf ``Account resources``
4. Navigieren Sie in den Unterpunkt ``Resource groups``
5. Auf der rechten Seite können Sie nun auf ``Create +`` klicken

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

1. Klicken Sie in der oberen Navigationsleiste auf ``Manage``

2. Wählen Sie im Dropdown-Menü den Punkt ``Acess (IAM)``

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

1. Navigieren Sie in der oberen Leiste der IBM Cloud Konsole zum Menüpunkt ``Manage``

2. Wählen Sie im Dropdown-Menü den Eintrag ``Access (IAM)`` aus

3. Orientieren Sie sich in der linken Seitenleiste am Bereich ``Manage Access``

4. Klicken Sie dort auf den Unterpunkt ``Access groups``

5. Starten Sie die Erstellung einer neuen Gruppe durch Klick auf den blauen Button ``Create +``

6. Geben Sie der Gruppe einen eindeutigen Namen (z. B. Platform-Admins) und eine kurze Beschreibung. Bestätigen Sie anschließend mit ``Create``

7. Sie befinden sich nun in der Übersicht der neuen Gruppe. Klicken Sie oben in der Reiter-Leiste auf ``Access``

8. Klicken Sie auf den blauen Button ``Assign access +``, um den Prozess der Rechtevergabe zu starten.

9. Wählen Sie im ersten Schritt unter "Service" die Option ``All Account Management Services`` aus (dies steuert Zugriff auf Billing, User-Invites etc.)

10. Scrollen Sie zu "Roles and actions" und setzen Sie das Häkchen bei der ``Rolle Administrator``

11. Klicken Sie unten auf den Button ``Add``, um diese Regel vorzumerken

12. Legen Sie nun direkt die zweite Policy an: Wählen Sie diesmal als Service die Option ``All Identity and Access enabled services aus`` (dies ermöglicht Zugriff auf alle Ressourcen-Instanzen)

13. Wählen Sie unter "Roles and actions" auch hier erneut die Rolle ``Administrator`` aus

14. Fügen Sie diese zweite Regel ebenfalls mit einem Klick auf ``Add`` hinzu

15. Auf der rechten Seite sehen Sie nun im Bereich Summary eine Zusammenfassung der vorgemerkten Richtlinien. Überprüfen Sie die Auswahl und schließen Sie den Vorgang mit einem Klick auf ``Assign`` endgültig ab

&nbsp;

<img src="{{ site.baseurl }}/screenshots/admin_agrp1.png" alt="IAM_overview" width="1500">

<img src="{{ site.baseurl }}/screenshots/admin_agrp2.png" alt="IAM_overview" width="1500">

<img src="{{ site.baseurl }}/screenshots/admin_agrp3.png" alt="IAM_overview" width="1500">

<img src="{{ site.baseurl }}/screenshots/admin_agrp4.png" alt="IAM_overview" width="1500">

&nbsp;


## **3.4 User einladen (Admins)** 

Um neuen Mitarbeitern oder Usern Zugriff auf Ihr IBM Cloud Konto zu gewähren, müssen diese explizit eingeladen werden.

Befolgen Sie dazu folgende Schritte:

1. Navigieren Sie in der oberen Leiste zu ```Manage```

2. Klicken Sie auf ```Access (IAM)```

3. Wählen Sie in der linken Leiste  ``Manage identities`` 

4. Wählen Sie den Punkt ``Users`` aus

5. Klicken Sie nun auf den blauen Button ``Invite users +``

6. Wählen Sie zwischen ``Access groups`` und ``Access policy``

8. Wählen Sie Ihre Platform Admin ``Access group`` aus

9. Klicken Sie zuletzt auf ``Invite`` um die User einzuladen

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

<img src="{{ site.baseurl }}/screenshots/platform:service_excalidraw.png" alt="platform/service" width="1500">

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

1. Gehen Sie in der oberen Leiste auf ``Manage``

2. Wählen Sie den Eintrag ``Access (IAM)``

3. Klicken Sie in der linken Seitenleiste auf ``Roles``

4. Starten Sie den Prozess mit einem Klick auf ``Create +``

Im anschließenden Menü definieren Sie die Eigenschaften der Rolle. Vergeben Sie zunächst einen aussagekräftigen Namen und eine Beschreibung. Wählen Sie danach den Ziel-Service aus und fügen Sie die gewünschten Berechtigungen (Actions) granular hinzu. Sobald Sie alle Aktionen ausgewählt haben, bestätigen Sie die Erstellung abschließend über den Button Create.

&nbsp;

<img src="{{ site.baseurl }}/screenshots/custom_roles_1.png" alt="platform/service" width="1500">

<img src="{{ site.baseurl }}/screenshots/custom_roles_2.png" alt="platform/service" width="1500">

&nbsp;

## **Context based restrictions (CBR)**