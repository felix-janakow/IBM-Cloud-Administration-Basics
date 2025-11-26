---
layout: default
---

# 1. Erste Schritte

---

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

1. Navigieren Sie in der oberen Leiste zu ``Manage`` und wählen Sie den Unterpunkt ``Account``
2. Klicken Sie in der Seitenleiste auf ``Account Settings``


<img src="{{ site.baseurl }}/screenshots/Settins1-2.png" alt="AccSettings" width="1500">

<img src="{{ site.baseurl }}/screenshots/Settings2-2.png" alt="AccSettings" width="1500">


# 2 Arbeiten mit Ressorucengruppen
---

## 2.1 Ressourcengruppen erklärt 

Ressourcengruppen sind **logische Container**, die zusammengehörige Cloud-Ressourcen (VMs, Datenbanken etc.) organisieren. Sie dienen als zentrale Ankerpunkte, um **IAM-Zugriffsrichtlinien auf die gesamte Gruppe anzuwenden** und so die Berechtigungsverwaltung zu vereinfachen. Zudem ermöglichen sie eine **klare Kostenverfolgung (Billing)** und die **einfache, isolierte Verwaltung** des gesamten Lebenszyklus der enthaltenen Ressourcen.