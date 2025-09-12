# Guide d'utilisation des assets pour Jobstage

## 📁 Structure des dossiers

```
assets/
├── images/
│   ├── 20250909_235800_0000.png  # Logo principal de Jobstage ✅
│   └── README.md                 # Instructions pour les images
└── icons/
    ├── icandidat.jpeg            # Icône pour les candidats ✅
    ├── ientreprise.jpeg          # Icône pour les recruteurs ✅
    └── README.md                 # Instructions pour les icônes
```

## 🖼️ Images requises

### Logo principal (`assets/images/20250909_235800_0000.png`) ✅
- **Dimensions du conteneur** : 180x85 pixels (ratio 2:1) - Conteneur compact
- **Taille effective du logo** : 200x95 pixels (80% de l'espace disponible)
- **Couleur du conteneur** : Dégradé #F5F5F5 → #E8E8E8 (gris clair élégant)
- **Effets visuels** : 
  - ✨ Ombres multiples (principale, intérieure, colorée)
  - 🎨 Dégradé subtil pour l'effet premium
  - 🔄 Animation de zoom au chargement
  - 📐 Coins arrondis (16px) pour un look moderne
- **Format** : PNG avec transparence
- **Description** : Logo officiel de Jobstage
- **Fallback** : Si l'image n'existe pas, un placeholder violet avec "LOGO" s'affiche

### Icône Candidat (`assets/icons/icandidat.jpeg`) ✅
- **Dimensions** : 64x64 pixels
- **Format** : JPEG
- **Description** : Icône représentant un candidat
- **Fallback** : Icône Material Design `Icons.person`

### Icône Recruteur (`assets/icons/ientreprise.jpeg`) ✅
- **Dimensions** : 64x64 pixels
- **Format** : JPEG
- **Description** : Icône représentant un recruteur/entreprise
- **Fallback** : Icône Material Design `Icons.business`

## 🔗 Fonctionnalités ajoutées

### 1. Gestion intelligente des images
- L'application charge automatiquement les images personnalisées
- Si une image n'existe pas, elle utilise un fallback approprié
- Support des formats PNG et JPG

### 2. Lien CENADI fonctionnel
- Le lien "À propos de CENADI" ouvre maintenant le site officiel
- URL : https://cenadi-douala.cm
- Fallback : Si l'URL ne peut pas être ouverte, affiche une boîte de dialogue d'information

### 3. Interface responsive
- Le logo s'adapte à différentes tailles d'écran
- Les icônes sont optimisées pour les appareils mobiles
- Animations fluides préservées

## 🚀 Comment ajouter vos images

1. **Préparez vos images** selon les spécifications ci-dessus
2. **Renommez-les** selon les noms requis
3. **Placez-les** dans les dossiers appropriés
4. **Relancez l'application** avec `flutter run`

## 🛠️ Personnalisation avancée

### Pour utiliser des images SVG
1. Ajoutez `flutter_svg: ^2.0.10+1` dans `pubspec.yaml`
2. Renommez vos fichiers en `.svg`
3. L'application les chargera automatiquement

### Pour changer l'URL CENADI
Modifiez la constante `url` dans la méthode `_openCenadiWebsite()` :
```dart
const url = 'https://votre-nouvelle-url.com';
```

## 📱 Test sur différents appareils

L'application a été testée et fonctionne sur :
- ✅ Android (téléphone physique)
- ✅ Linux (bureau)
- ✅ Web (Chrome)
- ✅ Tests unitaires

## 🎨 Couleurs utilisées

- **Bleu principal** : #2196F3
- **Vert principal** : #4CAF50
- **Fond** : #F8F6F0 (beige clair)
- **Texte principal** : #2C3E50 (gris foncé)
- **Texte secondaire** : #7F8C8D (gris moyen)

## 🔧 Dépannage

### L'image ne s'affiche pas
- Vérifiez que le fichier existe dans le bon dossier
- Vérifiez l'orthographe du nom de fichier
- Vérifiez que `flutter pub get` a été exécuté

### Le lien CENADI ne fonctionne pas
- Vérifiez votre connexion internet
- L'URL peut être temporairement indisponible
- Une boîte de dialogue d'information s'affichera en fallback

### L'application ne se compile pas
- Exécutez `flutter clean && flutter pub get`
- Vérifiez que toutes les dépendances sont installées
- Consultez les logs d'erreur avec `flutter run --verbose`
