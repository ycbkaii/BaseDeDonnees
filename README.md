# Guide de création de base de données pour la SAE 204

Ce document explique le processus de création d'une base de données pour la SAE 204 à l'aide du script SQL fourni.

## Introduction

Le script SQL fourni permet de créer les tables nécessaires pour la SAE 204, avec des clés primaires et des clés étrangères pour établir les relations entre les tables.

## Instructions

1. **Création du schéma 'parcoursup'**

   Le script commence par la création du schéma 'parcoursup'. Si le schéma existe déjà, il sera supprimé.

   ```sql
   DROP SCHEMA IF EXISTS parcoursup CASCADE;
   CREATE SCHEMA parcoursup;
   SET SCHEMA 'parcoursup';
   ```

2. **Création des tables principales**

   Ensuite, les tables principales de la base de données sont créées, notamment les tables `_region`, `_departement`, `_commune`, `_formation`, `_etablissement`, `_academie`, `_filiere`, `_rang_dernier_appele_selon_regroupement`, `_regroupement`, `_session`, `_admissions_generalites`, `_admission_selon_type_neo_bac`, `_type_bac`, `_effectif_selon_mention`, et `_mention_bac`.

   Vous pouvez personnaliser les noms des tables et des colonnes selon vos besoins, mais assurez-vous que les contraintes de clés primaires et étrangères sont correctement définies.


## Conclusion

Ce guide explique la création d'une base de données pour la SAE 204 en utilisant le script SQL fourni. Assurez-vous d'exécuter le script dans l'ordre spécifié pour créer correctement les tables et leurs relations. Vous pouvez également personnaliser les noms de tables et de colonnes en fonction de vos besoins spécifiques.
