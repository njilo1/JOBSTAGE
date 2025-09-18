import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'dashboard_screen.dart';
import 'sign_up_candidat.dart' as candidat;

class JobstageLoginScreen extends StatefulWidget {
  const JobstageLoginScreen({super.key});

  @override
  _JobstageLoginScreenState createState() => _JobstageLoginScreenState();
}

class _JobstageLoginScreenState extends State<JobstageLoginScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _keepSignedIn = false;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  Future<void> _login() async {
    if (_emailOrPhoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showErrorDialog('Veuillez remplir tous les champs');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _authService.login(
        email: _emailOrPhoneController.text.trim(),
        password: _passwordController.text,
      );

      if (result['success']) {
        // Connexion réussie
        if (mounted) {
          _showSuccessDialog('Connexion réussie !');
          // Naviguer vers le dashboard approprié selon le type d'utilisateur
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      } else {
        _showErrorDialog(result['message'] ?? 'Erreur de connexion');
      }
    } catch (e) {
      _showErrorDialog('Erreur: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Succès'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la taille de l'écran
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Column(
            children: [
              // Header with logo - adapté pour mobile
              SizedBox(
                height: screenHeight * 0.25, // 25% de la hauteur d'écran
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.05),
                    child: Image.asset(
                      'assets/images/jobstage_logo.png',
                      width: screenWidth * 0.7, // 70% de la largeur d'écran
                      height: screenHeight * 0.15, // 15% de la hauteur d'écran
                      fit: BoxFit.contain,
                      colorBlendMode: BlendMode.dstOver,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback si l'image n'existe pas
                        return Text(
                          'Jobstage',
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.08, // 8% de la largeur d'écran
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Main content - adapté pour mobile
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                ), // 6% de la largeur
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02), // 2% de la hauteur
                    // Title
                    Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07, // 7% de la largeur
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF303F9F),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01), // 1% de la hauteur
                    // Subtitle
                    Center(
                      child: Text(
                        'Connectez vous a votre compte',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // 3.5% de la largeur
                          color: Color(0xFF757575),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03), // 3% de la hauteur
                    // Email field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFE0E0E0)),
                      ),
                      child: TextField(
                        controller: _emailOrPhoneController,
                        decoration: InputDecoration(
                          hintText: 'Email ou Téléphone',
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: screenWidth * 0.035, // 3.5% de la largeur
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05, // 5% de la largeur
                            vertical: screenHeight * 0.02, // 2% de la hauteur
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.015,
                    ), // 1.5% de la hauteur
                    // Password field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFE0E0E0)),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: screenWidth * 0.035, // 3.5% de la largeur
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05, // 5% de la largeur
                            vertical: screenHeight * 0.02, // 2% de la hauteur
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF757575),
                              size: screenWidth * 0.05, // 5% de la largeur
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.015,
                    ), // 1.5% de la hauteur
                    // Keep signed in and forgot password row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: _keepSignedIn,
                                onChanged: (value) {
                                  setState(() {
                                    _keepSignedIn = value ?? false;
                                  });
                                },
                                activeColor: Color(0xFF2196F3),
                              ),
                              Flexible(
                                child: Text(
                                  'Keep me signed in',
                                  style: TextStyle(
                                    color: Color(0xFF757575),
                                    fontSize:
                                        screenWidth *
                                        0.035, // 3.5% de la largeur
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: Text(
                            'FORGOT?',
                            style: TextStyle(
                              color: Color(0xFF2196F3),
                              fontSize: screenWidth * 0.03, // 3% de la largeur
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02), // 2% de la hauteur
                    // Sign in button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06, // 6% de la hauteur
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2196F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      screenWidth * 0.04, // 4% de la largeur
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02), // 2% de la hauteur
                    // Separator
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xFFE0E0E0),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                          ),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Color(0xFFE0E0E0),
                              fontSize:
                                  screenWidth * 0.035, // 3.5% de la largeur
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFFE0E0E0),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: screenHeight * 0.015,
                    ), // 1.5% de la hauteur
                    // Google button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06, // 6% de la hauteur
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Google sign in
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Color(0xFFE0E0E0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Google
                            Image.asset(
                              'assets/images/google_logo.png',
                              width: screenWidth * 0.05, // 5% de la largeur
                              height: screenWidth * 0.05, // 5% de la largeur
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback si l'image n'existe pas
                                return Container(
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF4285F4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'G',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth *
                                            0.03, // 3% de la largeur
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ), // 3% de la largeur
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize:
                                    screenWidth * 0.04, // 4% de la largeur
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.015,
                    ), // 1.5% de la hauteur
                    // Facebook button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06, // 6% de la hauteur
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Facebook sign in
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Color(0xFFE0E0E0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Facebook
                            Image.asset(
                              'assets/images/facebook_logo.png',
                              width: screenWidth * 0.05, // 5% de la largeur
                              height: screenWidth * 0.05, // 5% de la largeur
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback si l'image n'existe pas
                                return Container(
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1877F2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'f',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth *
                                            0.03, // 3% de la largeur
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ), // 3% de la largeur
                            Text(
                              'Continue with Facebook',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize:
                                    screenWidth * 0.04, // 4% de la largeur
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02), // 2% de la hauteur
                    // Footer
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontSize:
                                  screenWidth * 0.035, // 3.5% de la largeur
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const candidat.JobstageSignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Create account',
                              style: TextStyle(
                                color: Color(0xFF2196F3),
                                fontSize:
                                    screenWidth * 0.035, // 3.5% de la largeur
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01), // 1% de la hauteur
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(home: JobstageLoginScreen(), debugShowCheckedModeBanner: false),
  );
}
