# 📐 Mesures de la Causalité — Évaluation du Programme PSAM par Trois Méthodes d'Identification

> Master 1 Économie Appliquée · Université Paris Cité  
> Auteur : Ryan Jordan TCHOKOUAHA TCHAHA · Année académique 2025–2026  
> Source des données : `evaluation.dta` (IRDES) · Logiciel : R Studio

---

## 📌 Objectif

Cette étude mobilise **trois méthodes quasi-expérimentales et expérimentales** pour identifier l'effet causal du programme PSAM sur le reste à charge des ménages défavorisés ruraux. Elle répond aux limites des approches naïves (avant/après, traités/non-traités) en construisant des contrefactuels valides via l'expérimentation aléatoire, les variables instrumentales, les différences-en-différences.

---

## 🔬 Méthodes mobilisées & résultats

| Méthode | Design | Estimateur | Résultat (ΔATT) | Généralisable ? |
|:---|:---|:---:|:---:|:---:|
| **RCT** — Expérimentation aléatoire | Villages pilotes (traitement) vs villages témoins (contrôle), assignation aléatoire | ATT | **−10,14 $** | ✅ Oui (> 9 $) |
| **Variables Instrumentales (IV/DMC)** | Promotion aléatoire comme instrument de participation | LATE | **−9,74 $** | ✅ Oui (> 9 $) |
| **Doubles Différences (DiD)** | Bénéficiaires vs non-bénéficiaires × avant/après | ATT | **−8,16 $** | ❌ Non (< 9 $) |


---

## 🧠 Points méthodologiques clés

**Validité du contrefactuel (RCT)** — Les 100 villages témoins présentent des caractéristiques moyennes non significativement différentes des villages pilotes (tests de Student et Khi-deux). Les seules différences marginales portent sur l'éducation du chef de famille et la distance à l'hôpital, ce qui confirme la qualité de la randomisation.

**Instrument valide (IV)** — La variable `promotion_locality` est non corrélée aux dépenses de santé (Corr(Z,u)=0) mais fortement corrélée à la participation au PSAM (49 % vs 8 % de souscription selon le statut de promotion). Le test de Fisher rejette l'hypothèse d'instrument faible (p < 2e-16). L'estimateur IV capture le **LATE** (Local Average Treatment Effect) : effet sur les *compliers*, soit les individus ayant souscrit grâce à la promotion.

**Hypothèse de tendances parallèles (DiD)** — Les tendances d'évolution des dépenses divergent significativement entre les deux groupes après le programme, ce qui constitue le signal causal exploité par la méthode. L'hypothèse de tendances parallèles en l'absence du traitement ne peut être testée directement.


---

## 💡 Enseignement central

> Les méthodes les plus robustes (RCT et IV) convergent vers une réduction causale du reste à charge **supérieure au seuil de 9 $** fixé par le gouvernement, justifiant la généralisation du programme. Les méthodes plus exposées au biais de sélection (DiD) produisent des estimations inférieures à ce seuil, soulignant l'importance du choix de la stratégie d'identification.

---

## 🛠️ Outils & Méthodes

`R Studio` · `ivreg (package AER)` ·  · `DMC (2SLS)` · `Test de Fisher` · `Test de Student` · `Khi-deux`

`RCT` · `Variables Instrumentales` · `Doubles Différences` · · `LATE` · `ATT` · `Cadre de Rubin`

---

## 👤 Auteur


---

<div align="center">

*"Turning data into decisions."*

</div>
