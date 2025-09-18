import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobPreferencesScreen extends StatefulWidget {
  const JobPreferencesScreen({super.key});

  @override
  State<JobPreferencesScreen> createState() => _JobPreferencesScreenState();
}

class _JobPreferencesScreenState extends State<JobPreferencesScreen> {
  // États des préférences
  String selectedJobType = 'Temps plein';
  String selectedExperienceLevel = 'Intermédiaire (3-5 ans)';
  String selectedSalaryRange = '200 000 - 400 000 FCFA';
  String selectedWorkLocation = 'Yaoundé';
  bool remoteWork = false;

  // Contrôleur pour le champ personnalisé
  final TextEditingController _customJobTypeController =
      TextEditingController();
  bool _showCustomJobType = false;

  // Liste des villes du Cameroun
  final List<String> cameroonCities = [
    'Yaoundé',
    'Douala',
    'Bamenda',
    'Bafoussam',
    'Garoua',
    'Maroua',
    'Ngaoundéré',
    'Bertoua',
    'Ebolowa',
    'Kribi',
    'Buea',
    'Limbe',
    'Dschang',
    'Foumban',
    'Kumba',
    'Nkongsamba',
    'Mbouda',
    'Edéa',
    'Tiko',
    'Loum',
    'Manjo',
    'Mbalmayo',
    'Mbanga',
    'Bafang',
    'Foumbot',
    'Melong',
    'Bandjoun',
    'Baham',
    'Bangangté',
    'Kékem',
    'Nkambe',
    'Wum',
    'Fundong',
    'Sangmélima',
    'Yokadouma',
    'Abong-Mbang',
    'Akonolinga',
    'Nanga-Eboko',
    'Meiganga',
    'Batouri',
    'Kumbo',
    'Ndop',
    'Muyuka',
    'Mutengene',
    'Fontem',
    'Mamfe',
    'Mundemba',
    'Mora',
    'Mokolo',
    'Kousséri',
    'Guider',
    'Tibati',
    'Banyo',
    'Tignere',
    'Kontcha',
    'Poli',
    'Tcholliré',
  ];

  @override
  void dispose() {
    _customJobTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xFF007bff),
        title: Text(
          'Préférences d\'emploi',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre de section
              Text(
                'Définissez vos critères',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Personnalisez votre recherche d\'emploi idéale',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              // Type d'emploi avec icône
              _buildPreferenceCard(
                icon: Icons.work_outline,
                iconColor: const Color(0xFF007bff),
                title: 'Type d\'emploi',
                subtitle: 'Sélectionnez votre type de contrat préféré',
                child: Column(
                  children: [
                    _buildCompactDropdown(
                      selectedJobType,
                      [
                        'Temps plein',
                        'Temps partiel',
                        'Freelance',
                        'Stage',
                        'Contrat',
                        'Autre',
                      ],
                      (value) {
                        setState(() {
                          selectedJobType = value!;
                          _showCustomJobType = value == 'Autre';
                        });
                      },
                    ),
                    if (_showCustomJobType) ...[
                      const SizedBox(height: 8),
                      TextField(
                        controller: _customJobTypeController,
                        style: GoogleFonts.roboto(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Précisez le type d\'emploi',
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey[400],
                            fontSize: 13,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF007bff),
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Niveau d'expérience avec icône
              _buildPreferenceCard(
                icon: Icons.trending_up,
                iconColor: const Color(0xFF28a745),
                title: 'Expérience',
                subtitle: 'Votre niveau professionnel',
                child: _buildCompactDropdown(
                  selectedExperienceLevel,
                  [
                    'Débutant (0-1 an)',
                    'Junior (1-3 ans)',
                    'Intermédiaire (3-5 ans)',
                    'Senior (5+ ans)',
                  ],
                  (value) => setState(() => selectedExperienceLevel = value!),
                ),
              ),
              const SizedBox(height: 16),

              // Salaire avec icône
              _buildPreferenceCard(
                icon: Icons.attach_money,
                iconColor: const Color(0xFF17a2b8),
                title: 'Salaire souhaité',
                subtitle: 'Fourchette en FCFA',
                child: _buildCompactDropdown(
                  selectedSalaryRange,
                  [
                    '100 000 - 200 000 FCFA',
                    '200 000 - 400 000 FCFA',
                    '400 000 - 600 000 FCFA',
                    '600 000 - 1 000 000 FCFA',
                    'Plus de 1 000 000 FCFA',
                  ],
                  (value) => setState(() => selectedSalaryRange = value!),
                ),
              ),
              const SizedBox(height: 16),

              // Localisation avec icône
              _buildPreferenceCard(
                icon: Icons.location_on_outlined,
                iconColor: const Color(0xFFfd7e14),
                title: 'Localisation',
                subtitle: 'Ville de travail préférée',
                child: _buildCompactDropdown(
                  selectedWorkLocation,
                  cameroonCities,
                  (value) => setState(() => selectedWorkLocation = value!),
                ),
              ),
              const SizedBox(height: 16),

              // Travail à distance avec icône
              _buildPreferenceCard(
                icon: Icons.home_work_outlined,
                iconColor: const Color(0xFF007bff),
                title: 'Télétravail',
                subtitle: 'Ouvert au travail à distance',
                child: Transform.scale(
                  scale: 0.9,
                  child: Switch(
                    value: remoteWork,
                    onChanged: (value) => setState(() => remoteWork = value),
                    activeThumbColor: const Color(0xFF007bff),
                    activeTrackColor: const Color(
                      0xFF007bff,
                    ).withValues(alpha: 0.3),
                    inactiveThumbColor: Colors.grey[400],
                    inactiveTrackColor: Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bouton de sauvegarde
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Sauvegarder les préférences
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Préférences sauvegardées !'),
                        backgroundColor: const Color(0xFF28a745),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007bff),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sauvegarder les préférences',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: const Color(0xFF1a1a1a),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildCompactDropdown(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  item,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1a1a1a),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF007bff),
            size: 24,
          ),
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return Text(
                item,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007bff),
                ),
              );
            }).toList();
          },
          menuMaxHeight: 300,
          dropdownColor: Colors.white,
          elevation: 8,
        ),
      ),
    );
  }
}
