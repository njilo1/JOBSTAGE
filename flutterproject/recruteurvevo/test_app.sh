#!/bin/bash

echo "🚀 Test de l'application JOBSTAGE Recruteur"
echo "============================================="

echo "📱 Vérification des appareils connectés..."
flutter devices

echo ""
echo "🔧 Nettoyage du cache..."
flutter clean

echo ""
echo "📦 Installation des dépendances..."
flutter pub get

echo ""
echo "🔍 Analyse du code..."
flutter analyze --no-fatal-infos

echo ""
echo "🏗️ Construction de l'application..."
flutter build apk --debug

echo ""
echo "✅ Test terminé !"
echo "Pour lancer l'application : flutter run"
