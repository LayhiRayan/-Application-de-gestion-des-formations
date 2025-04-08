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
| **Hibernate**              | Framework ORM utilisé pour automatiser la gestion de la persistance des objets Java vers la base de données MySQL. |
| **AJAX (Asynchronous JavaScript and XML)** | Utilisé pour rendre les interactions dynamiques, notamment pour permettre une **inscription instantanée sans rechargement** de la page. |
| **Chart.js**               | Librairie JavaScript permettant d’afficher des **statistiques graphiques** (ex : nombre d’inscrits par formation) de manière interactive. |




## 📄 Classes principales

- `User` : représente un utilisateur générique avec les attributs suivants :
  - `id` : identifiant unique
  - `nom` : nom de l'utilisateur
  - `email` : adresse email
  - `motDePasse` : mot de passe

- `Apprenant` (hérite de `User`) : représente un utilisateur inscrit à une ou plusieurs formations.
  - `idApprenant` : identifiant spécifique de l'apprenant (optionnel si héritage pur)

- `Formateur` : représente un utilisateur qui anime une ou plusieurs formations.
  - `idFormateur` : identifiant du formateur
  - `specialite` : domaine de spécialisation

- `Formation` (hérite de `User`) : désigne une formation disponible sur la plateforme.
  - `id` : identifiant unique
  - `titre` : titre de la formation
  - `description` : description de la formation
  - `duree` : durée en heures ou jours
  - Relation : animée par un seul `Formateur`, et suivie par plusieurs `Apprenants`

- `Inscription` : représente la participation d’un `Apprenant` à une `Formation`.
  - `dateInscription` : date à laquelle l’inscription a été faite
  - Associations : liée à un `Apprenant` et une `Formation`

## 📐 Diagramme de classes

Le diagramme de classes ci-dessous représente la structure principale de l'application, ainsi que les relations entre les différentes entités du système.
![Application de Gestion des Formations DC](https://github.com/user-attachments/assets/41c6ae7d-d082-471a-b474-3780674a5c18)




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

📌 Ce projet met en œuvre un **système complet de gestion des formations** avec une expérience utilisateur fluide et une visualisation graphique en temps réel.
