import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  // Détection automatique de l'environnement
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Pour l'émulateur Android, utiliser 10.0.2.2
      // Pour le téléphone physique, utiliser l'IP de la machine
      return 'http://192.168.100.61:8000/api';
    } else {
      // Pour le web et autres plateformes, utiliser localhost
      return 'http://localhost:8000/api';
    }
  }

  // URL de test hardcodée pour débogage
  static String get testBaseUrl => 'http://192.168.100.61:8000/api';

  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _token;
  User? _currentUser;

  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _token != null && _currentUser != null;

  // Initialize auth service with stored data
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(tokenKey);
    final userData = prefs.getString(userKey);

    if (userData != null) {
      try {
        _currentUser = User.fromJson(jsonDecode(userData));
      } catch (e) {
        print('Error parsing stored user data: $e');
        await logout();
      }
    }
  }

  // Register a new user
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirm,
    required String userType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirm': passwordConfirm,
          'user_type': userType,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Registration successful
        _token = data['token'];
        _currentUser = User.fromJson(data['user']);

        // Store token and user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, _token!);
        await prefs.setString(userKey, jsonEncode(data['user']));

        return {
          'success': true,
          'message': data['message'],
          'user': _currentUser,
        };
      } else {
        // Registration failed
        return {
          'success': false,
          'message': data['message'] ?? 'Erreur lors de l\'inscription',
          'errors': data,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion: ${e.toString()}',
      };
    }
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginUrl = '$testBaseUrl/auth/login/';
      print('Tentative de connexion avec: $email');
      print('URL de connexion: $loginUrl');
      print('Base URL: $testBaseUrl');

      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}),
      );

      print('Réponse du serveur: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Login successful
        _token = data['token'];
        _currentUser = User.fromJson(data['user']);

        // Store token and user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, _token!);
        await prefs.setString(userKey, jsonEncode(data['user']));

        return {
          'success': true,
          'message': data['message'],
          'user': _currentUser,
        };
      } else {
        // Login failed
        return {
          'success': false,
          'message': data['message'] ?? 'Identifiants invalides',
          'errors': data,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion: ${e.toString()}',
      };
    }
  }

  // Logout user
  Future<void> logout() async {
    if (_token != null) {
      try {
        await http.post(
          Uri.parse('$baseUrl/auth/logout/'),
          headers: {
            'Authorization': 'Token $_token',
            'Content-Type': 'application/json',
          },
        );
      } catch (e) {
        print('Error during logout: $e');
      }
    }

    // Clear local data
    _token = null;
    _currentUser = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userKey);
  }

  // Get user profile
  Future<Map<String, dynamic>> getProfile() async {
    if (_token == null) {
      return {'success': false, 'message': 'Non connecté'};
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profile/'),
        headers: {
          'Authorization': 'Token $_token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _currentUser = User.fromJson(data);
        return {'success': true, 'user': _currentUser};
      } else {
        return {
          'success': false,
          'message': 'Erreur lors de la récupération du profil',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion: ${e.toString()}',
      };
    }
  }

  // Change password
  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    if (_token == null) {
      return {'success': false, 'message': 'Non connecté'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/change-password/'),
        headers: {
          'Authorization': 'Token $_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirm': newPasswordConfirm,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': data['message']};
      } else {
        return {
          'success': false,
          'message':
              data['message'] ?? 'Erreur lors du changement de mot de passe',
          'errors': data,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion: ${e.toString()}',
      };
    }
  }
}
