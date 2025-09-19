# JOBSTAGE - Application Recruteur

Application Flutter pour les recruteurs de la plateforme JOBSTAGE, permettant de gérer les offres d'emploi, les candidats et le processus de recrutement.

## 🚀 Fonctionnalités

### Dashboard Principal
- Vue d'ensemble des statistiques (offres actives, candidats, candidatures)
- Actions rapides (publier offre, voir candidats, matches, favoris)
- Offres actives récentes
- Candidats recommandés avec score de matching

### Gestion des Offres
- **Liste des offres** : Affichage de toutes les offres avec filtres (actives, expirées)
- **Création d'offre** : Formulaire complet pour créer une nouvelle offre
- **Détails d'offre** : Vue détaillée avec candidatures associées
- **Modification/Suppression** : Actions sur les offres existantes

### Gestion des Candidats
- **Liste des candidats** : Tous les candidats avec recherche et filtres
- **Profil candidat** : Informations détaillées, compétences, expérience
- **Matches intelligents** : Candidats recommandés basés sur l'IA
- **Contact direct** : Email et téléphone des candidats

### Système de Notifications
- Notifications en temps réel
- Filtres par type et statut
- Marquer comme lues
- Actions contextuelles

### Paramètres
- Profil de l'entreprise
- Préférences de notifications
- Gestion du compte
- Support et aide

## 🏗️ Architecture

### Modèles de Données
- `Entreprise` : Informations de l'entreprise recruteur
- `Offre` : Offres d'emploi publiées
- `Candidat` : Profils des candidats
- `Candidature` : Candidatures aux offres
- `NotificationModel` : Notifications système

### Services
- `DataService` : Gestion des données en mémoire (simulation)

### Pages Principales
- `RecruiterDashboard` : Dashboard principal
- `OffersListPage` : Liste des offres
- `CreateOfferPage` : Création d'offre
- `OfferDetailsPage` : Détails d'offre
- `CandidatesListPage` : Liste des candidats
- `CandidateDetailsPage` : Profil candidat
- `MatchesPage` : Candidats matches
- `NotificationsPage` : Centre de notifications
- `SettingsPage` : Paramètres

### Widgets Personnalisés
- `StatsCard` : Carte de statistiques
- `QuickActionCard` : Actions rapides
- `OfferCard` : Carte d'offre
- `CandidateCard` : Carte candidat
- `CustomAppBar` : Barre d'application personnalisée

## 🎨 Design

### Material Design 3
- Thème cohérent avec Material Design 3
- Couleurs personnalisées pour JOBSTAGE
- Typographie Google Fonts (Roboto)
- Composants modernes et accessibles

### Couleurs
- Primaire : Vert (#4CAF50)
- Secondaire : Vert foncé (#2E7D32)
- Accent : Bleu (#1E88E5)
- Surface : Gris clair (#F5F5F5)

## 📱 Navigation

### Navigation Principale
- **Accueil** : Dashboard avec vue d'ensemble
- **Mes offres** : Gestion des offres d'emploi
- **Candidats** : Liste et gestion des candidats
- **Matches** : Candidats recommandés par l'IA
- **Paramètres** : Configuration et préférences

### Navigation Secondaire
- Navigation contextuelle entre les pages
- Retour et actions dans les AppBars
- Modales et dialogues pour les actions

## 🔧 Installation et Exécution

### Prérequis
- Flutter SDK 3.9.2+
- Dart 3.0+
- Android Studio / VS Code
- Émulateur ou appareil physique

### Installation
```bash
# Cloner le projet
git clone [url-du-repo]

# Aller dans le dossier
cd recruteurvevo

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

### Dépendances Principales
- `flutter` : SDK Flutter
- `material_color_utilities` : Utilitaires Material Design 3
- `provider` : Gestion d'état
- `go_router` : Navigation avancée
- `google_fonts` : Polices Google
- `intl` : Internationalisation
- `material_symbols_icons` : Icônes Material Symbols

## 📊 Données de Démonstration

L'application utilise des données simulées en mémoire pour la démonstration :

### Entreprise
- **TechCorp Cameroun** : Entreprise technologique vérifiée CENADI

### Offres
- **Développeur Flutter Senior** : CDI à Yaoundé
- **Stage Marketing Digital** : Stage 6 mois à Douala

### Candidats
- **Marie Kouam** : Développeur Flutter (96% match)
- **Jean Mbarga** : Développeur Mobile (92% match)
- **Claire Ndam** : Stagiaire Marketing (89% match)

## 🚀 Fonctionnalités Futures

### Phase 2
- Intégration API réelle
- Authentification utilisateur
- Base de données persistante
- Notifications push

### Phase 3
- Système de matching IA avancé
- Chat intégré
- Vidéoconférence
- Rapports et analytics

## 📝 Notes de Développement

### Structure du Code
```
lib/
├── main.dart
├── models/           # Modèles de données
├── services/         # Services et logique métier
├── theme/           # Thème et styles
├── widgets/         # Widgets réutilisables
├── pages/           # Pages de l'application
│   ├── offers/      # Pages des offres
│   ├── candidates/  # Pages des candidats
│   ├── notifications/ # Pages des notifications
│   └── settings/    # Pages des paramètres
└── navigation/      # Navigation principale
```

### Bonnes Pratiques
- Code modulaire et réutilisable
- Séparation des responsabilités
- Gestion d'état centralisée
- Interface utilisateur cohérente
- Accessibilité et performance

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Commit les changements (`git commit -m 'Ajouter nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 📞 Support

Pour toute question ou problème :
- Email : support@jobstage.cm
- Téléphone : +237 6XX XX XX XX
- Site web : www.jobstage.cm

---

**JOBSTAGE** - Connecter les talents aux opportunités 🚀