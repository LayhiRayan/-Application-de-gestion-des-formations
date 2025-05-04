# 🎓 Application de Gestion des Formations

## 📌 Contexte

Dans un monde en constante évolution, l’apprentissage continu est devenu essentiel. De nombreuses entreprises et institutions proposent des formations pour aider les individus à acquérir de nouvelles compétences. Cependant, gérer efficacement ces formations, les inscriptions des utilisateurs, et le suivi statistique reste un défi, notamment en termes de simplicité, d’interactivité et d’ergonomie.

## ❗ Problématique

Les plateformes actuelles de gestion de formations présentent souvent :
- Des interfaces peu intuitives,
- Un manque d’interactivité lors de l'inscription (rechargement de la page),
- L'absence de visualisation claire des données de participation.

**➡️ Comment développer une application web moderne, interactive et efficace permettant de gérer les formations, les inscriptions et les statistiques d’usage ?**

## 🎯 Objectifs de l'application

### Objectif général
Développer une application web de gestion des formations avec une interface dynamique, une inscription fluide sans rechargement de page, et une visualisation graphique des statistiques.

### Objectifs spécifiques
- Gérer les **formations** (titre, description, durée).
- Permettre aux utilisateurs de **s’inscrire dynamiquement** à une formation via AJAX.
- Afficher à chaque utilisateur **ses inscriptions**.
- Afficher les **statistiques de participation** avec des graphiques générés par Chart.js.
- Implémenter une architecture MVC claire avec **JSP/Servlets**.
- Gérer les données via une base **MySQL**.

## 🛠️ Technologies et outils utilisés

| Outil / Technologie        | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| **Java Web (JSP / Servlet)** | Technologie principale côté serveur pour gérer la logique métier et l’interface web de l’application, selon l’architecture MVC. |
| **MySQL**                  | Système de gestion de base de données relationnelle utilisé pour stocker les données des formations, utilisateurs, formateurs et inscriptions. |
| **JDBC**                   | API Java pour la communication directe avec la base de données (utilisé dans les DAO). |
| **Hibernate**              | Framework ORM utilisé pour automatiser la gestion de la persistance des objets Java vers la base de données MySQL. |
| **AJAX (Asynchronous JavaScript and XML)** | Utilisé pour rendre les interactions dynamiques, notamment pour permettre une **inscription instantanée sans rechargement** de la page. |
| **Chart.js**               | Librairie JavaScript permettant d’afficher des **statistiques graphiques** (ex : nombre d’inscrits par formation) de manière interactive. |





## 📐 Diagramme de classes

Le diagramme de classes ci-dessous représente la structure principale de l'application, ainsi que les relations entre les différentes entités du système.


![image](https://github.com/user-attachments/assets/53b76a6f-e94f-4dea-bee1-dab151d108d9)

##  🗺️ Modèle conceptuel de la base généré :

![image](https://github.com/user-attachments/assets/8d679616-11d2-4ffa-95a2-39c020cf8779)




##  🧪 Execution des tests dans la console :
*1.Création des tables dans la base de données :*

![Capture](https://github.com/user-attachments/assets/e1f35e25-134c-404d-b179-4a0e98913ab3)


*2.Insertion des données dans les tables :*

![Capture](https://github.com/user-attachments/assets/3bc79bf4-565e-4eeb-a9a5-672d815fd26f)
![Capture2](https://github.com/user-attachments/assets/23aa0502-8174-44ad-990c-2d833074cc7c)
![Capture3](https://github.com/user-attachments/assets/9e7782c0-a2a1-47b5-b1cd-fa4678ec38b5)
![Capture4](https://github.com/user-attachments/assets/b11dca51-a818-47c0-b8c7-c26fd4ed44bb)
![Capture5](https://github.com/user-attachments/assets/a30fbc0d-753a-4960-875c-32199922258f)







*3.suppression:(Supprimer une formation)*

![Capture1](https://github.com/user-attachments/assets/289a5e80-4e22-40ce-922f-f7d635bf16b1)
![Capture2](https://github.com/user-attachments/assets/5f07cbd3-ba16-4b55-ac2d-1784ced2e2ad)
![Capture3](https://github.com/user-attachments/assets/b009c6cf-3837-419c-9ed1-e47e22a11290)
![Capture4](https://github.com/user-attachments/assets/2f084dbc-4144-49ab-b0aa-f6befbe27185)
![Capture5](https://github.com/user-attachments/assets/37d3eb66-f219-4281-99a2-2b30dd6b37ef)

*4.Filtrage apprenant :(Recherche d’apprenants par nom)*

![Capture](https://github.com/user-attachments/assets/a5bd5769-1045-4ab7-8d43-622383557610)
![Capture1](https://github.com/user-attachments/assets/fab72876-964e-4576-b17f-7622287070ca)
![Capture2](https://github.com/user-attachments/assets/ede8982d-1267-40db-ab7b-1c01698957f9)
![Capture3](https://github.com/user-attachments/assets/fbda3540-fcbb-447f-aede-86bb706dd8f2)




## 🧩Architecture :
![image](https://github.com/user-attachments/assets/f962d522-eec8-4277-ac8b-c80c04faaf54)


## 📃 Pages principales

1. 📋 **Liste des formations disponibles**
2. 📌 **Détails d'une formation + inscription (AJAX)**
3. 🧾 **Mes inscriptions**
4. 📊 **Statistiques d’inscription** (graphiques Chart.js)

## 📆 Planning (Méthodologie Agile - Sprints)

| Sprint       | Durée   | Contenu                                                                 |
|--------------|---------|-------------------------------------------------------------------------|
| **Sprint 1** | 2 jours | Création des entités `Formation`, `User`, `Formateur`, `Inscription` + génération de la base via Hibernate |
| **Sprint 2** | 2 jours | Développement de la **couche DAO** (accès aux données avec JDBC)       |
| **Sprint 3** | 8 jours | Création des pages JSP + Servlets pour l’affichage et l’interaction    |
| **Sprint 4** | 6 jours | Intégration de **l’AJAX pour inscription dynamique** + **Chart.js pour les statistiques** |

---
## 🎥 Demo


https://github.com/user-attachments/assets/fd8bc1f2-735d-4dfd-a676-df3623f19dd6



