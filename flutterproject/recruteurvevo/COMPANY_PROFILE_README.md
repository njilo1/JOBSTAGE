# Page de Profil Entreprise

## Description
Cette page permet aux entreprises de gérer leur profil complet avec toutes les informations nécessaires pour le recrutement.

## Fonctionnalités

### 1. Header Vert avec Informations Principales
- **Couleur verte** pour respecter l'ambiance de l'application
- Affichage du **nom de l'entreprise**
- **Numéro du service client**
- **Adresse de l'entreprise**
- Bouton **crayon** pour modifier le profil (icône edit)

### 2. Import de Photo/Logo
- Possibilité d'importer une photo/logo de l'entreprise
- Icône crayon sur l'avatar pour indiquer la possibilité de modification
- Utilisation du package `image_picker` pour la sélection d'images

### 3. Sélection Multiple des Villes du Cameroun
- Liste complète des villes du Cameroun
- Possibilité de sélectionner **plusieurs villes** pour les entreprises avec plusieurs filiales
- Interface de sélection avec checkboxes
- Affichage des villes sélectionnées sous forme de chips avec possibilité de suppression

### 4. Champ Google Maps
- Champ dédié pour la **position sur Google Maps**
- Permet de coller le lien Google Maps de l'entreprise
- Facilite la localisation géographique

### 5. Informations Complètes de l'Entreprise
- Nom de l'entreprise
- Email
- Téléphone
- Numéro service client
- Adresse
- Secteur d'activité
- Site web
- Description détaillée

## Structure du Code

### Modèle Entreprise Mis à Jour
```dart
class Entreprise {
  // ... autres propriétés
  final List<String> localisations; // Support de plusieurs villes
  final String positionGoogleMaps; // Position Google Maps
  final String numeroServiceClient; // Numéro service client
  // ...
}
```

### Page de Profil Entreprise
- **Fichier**: `lib/pages/companies/company_profile_page.dart`
- **Navigation**: Accessible via Paramètres > Profil Entreprise
- **Design**: Header vert avec SliverAppBar, formulaire complet

## Utilisation

1. Accéder à la page via **Paramètres** > **Profil Entreprise**
2. Cliquer sur l'icône crayon pour modifier la photo/logo
3. Remplir les informations de l'entreprise
4. Sélectionner les villes d'implantation via le bouton "Ajouter des villes"
5. Ajouter le lien Google Maps de l'entreprise
6. Sauvegarder les modifications

## Dépendances Ajoutées
- `image_picker: ^1.0.7` - Pour l'import d'images

## Interface Utilisateur

### Header
- Couleur verte avec dégradé
- Informations principales de l'entreprise
- Bouton d'édition

### Formulaire
- Champs de saisie avec validation
- Sélection multiple des villes
- Champ Google Maps
- Boutons d'action (Annuler/Sauvegarder)

### Sélection des Villes
- Dialog avec liste complète des villes du Cameroun
- Checkboxes pour sélection multiple
- Affichage des villes sélectionnées en chips

## Notes Techniques
- Utilisation de `SliverAppBar` pour un header flexible
- Gestion d'état avec `StatefulWidget`
- Validation des formulaires
- Interface responsive et moderne
