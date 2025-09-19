# Guide de Dépannage - JOBSTAGE Recruteur

## 🚨 Problèmes Courants et Solutions

### 1. Erreur MainActivity ClassNotFoundException

**Symptôme :**
```
java.lang.ClassNotFoundException: Didn't find class "com.example.recruteurvevo.MainActivity"
```

**Solution :**
1. Vérifiez que le package name dans `android/app/src/main/AndroidManifest.xml` correspond au package dans `MainActivity.kt`
2. Nettoyez le cache : `flutter clean`
3. Réinstallez les dépendances : `flutter pub get`
4. Relancez l'application : `flutter run`

### 2. Erreurs de Compilation Gradle

**Symptôme :**
```
BUILD FAILED in Xm Xs
Execution failed for task ':app:stripDebugDebugSymbols'
```

**Solution :**
1. Nettoyez le projet : `flutter clean`
2. Supprimez le dossier `build/` : `rm -rf build/`
3. Relancez : `flutter pub get && flutter run`

### 3. Problèmes de Dépendances

**Symptôme :**
```
version solving failed
```

**Solution :**
1. Vérifiez les versions dans `pubspec.yaml`
2. Mettez à jour : `flutter pub upgrade`
3. Ou forcez la résolution : `flutter pub deps`

### 4. Erreurs de Cache

**Symptôme :**
```
Could not close incremental caches
```

**Solution :**
1. Nettoyez tout : `flutter clean`
2. Supprimez `.dart_tool/` : `rm -rf .dart_tool/`
3. Redémarrez l'IDE
4. Relancez : `flutter pub get`

## 🔧 Commandes de Dépannage

### Nettoyage Complet
```bash
flutter clean
rm -rf build/
rm -rf .dart_tool/
flutter pub get
```

### Vérification de l'Environnement
```bash
flutter doctor -v
flutter devices
flutter analyze
```

### Test de l'Application
```bash
./test_app.sh
```

## 📱 Problèmes Spécifiques Android

### 1. Appareil Non Détecté
```bash
# Vérifiez les appareils connectés
flutter devices

# Activez le débogage USB sur l'appareil
# Vérifiez les pilotes ADB
adb devices
```

### 2. Problèmes de Signature
```bash
# Générez une nouvelle clé de signature
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 3. Problèmes de Permissions
Vérifiez `android/app/src/main/AndroidManifest.xml` pour les permissions nécessaires.

## 🐛 Débogage

### Logs Détaillés
```bash
flutter run --verbose
```

### Mode Debug
```bash
flutter run --debug
```

### Mode Release
```bash
flutter run --release
```

## 📋 Checklist de Vérification

- [ ] Flutter installé et configuré (`flutter doctor`)
- [ ] Appareil connecté et reconnu (`flutter devices`)
- [ ] Dépendances installées (`flutter pub get`)
- [ ] Code analysé sans erreurs (`flutter analyze`)
- [ ] Application compilée (`flutter build apk`)
- [ ] Application lancée (`flutter run`)

## 🆘 Support

Si les problèmes persistent :

1. Vérifiez la version de Flutter : `flutter --version`
2. Mettez à jour Flutter : `flutter upgrade`
3. Consultez la documentation Flutter officielle
4. Vérifiez les issues GitHub du projet

## 📝 Notes Importantes

- Toujours nettoyer le cache après des changements majeurs
- Vérifier la compatibilité des versions de dépendances
- Tester sur un appareil physique quand possible
- Garder Flutter et les dépendances à jour
