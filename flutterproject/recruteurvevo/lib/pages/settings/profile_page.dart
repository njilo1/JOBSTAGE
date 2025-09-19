import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DataService _dataService = DataService();
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _adresseController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _secteurController = TextEditingController();
  final _siteWebController = TextEditingController();
  final _numeroServiceClientController = TextEditingController();
  final _positionGoogleMapsController = TextEditingController();

  List<String> _selectedCities = [];
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isEditing = false;

  // Liste des villes du Cameroun
  final List<String> _citiesOfCameroon = [
    'Douala', 'Yaoundé', 'Garoua', 'Bamenda', 'Maroua', 'Nkongsamba', 'Bafoussam',
    'Ngaoundéré', 'Bertoua', 'Loum', 'Kumba', 'Edéa', 'Kribi', 'Foumban',
    'Mbouda', 'Dschang', 'Limbé', 'Ebolowa', 'Kousséri', 'Guider', 'Meiganga',
    'Yagoua', 'Mokolo', 'Bafia', 'Wum', 'Bafang', 'Tiko', 'Mbalmayo', 'Buea',
    'Sangmélima', 'Foumbot', 'Bangangté', 'Tibati', 'Mvengue', 'Bogo', 'Yokadouma',
    'Abong-Mbang', 'Batouri', 'Rey Bouba', 'Mora', 'Kribi', 'Nkambé', 'Fundong',
    'Fontem', 'Mbandjock', 'Minta', 'Tignère', 'Akonolinga', 'Bélabo', 'Touboro',
    'Nanga-Eboko', 'Mundemba', 'Bétaré-Oya', 'Poli', 'Guibé', 'Mamfé', 'Obala',
    'Mfou', 'Nkoteng', 'Bikok', 'Ntui', 'Mengong', 'Ndelele', 'Bipindi', 'Lolodorf',
    'Akono', 'Ngambé', 'Ndom', 'Yabassi', 'Nkondjock', 'Bipindi', 'Lolodorf',
    'Akono', 'Ngambé', 'Ndom', 'Yabassi', 'Nkondjock', 'Bipindi', 'Lolodorf'
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    final entreprise = _dataService.entreprises.first;
    _nomController.text = entreprise.nom;
    _emailController.text = entreprise.email;
    _telephoneController.text = entreprise.telephone;
    _adresseController.text = entreprise.adresse;
    _descriptionController.text = entreprise.description;
    _secteurController.text = entreprise.secteurActivite;
    _siteWebController.text = entreprise.siteWeb;
    _numeroServiceClientController.text = entreprise.numeroServiceClient;
    _positionGoogleMapsController.text = entreprise.positionGoogleMaps;
    _selectedCities = List.from(entreprise.localisations);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _adresseController.dispose();
    _descriptionController.dispose();
    _secteurController.dispose();
    _siteWebController.dispose();
    _numeroServiceClientController.dispose();
    _positionGoogleMapsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Mon Profil'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: _toggleEditMode,
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            tooltip: _isEditing ? 'Sauvegarder' : 'Modifier',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildSimpleHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPersonalInfoSection(),
                    const SizedBox(height: 16),
                    _buildAboutSection(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode supprimée - remplacée par _buildHeader()
  Widget _buildSliverAppBar_DEPRECATED() {
    return SliverAppBar(
      expandedHeight: 300, // Hauteur encore plus grande pour éliminer l'overflow
      floating: false,
      pinned: true,
      backgroundColor: Colors.green, // Vert comme les autres pages
      foregroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: const Text(
        'Mon Profil',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _pickImage,
          icon: const Icon(Icons.edit, color: Colors.white),
          tooltip: 'Modifier le profil',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.green,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 30), // Padding encore plus généreux
              child: Column(
                mainAxisSize: MainAxisSize.min, // Évite l'expansion excessive
                children: [
                  // Avatar avec possibilité de modification
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55, // Avatar encore plus grand
                          backgroundColor: Colors.yellow,
                          backgroundImage: _selectedImage != null 
                              ? FileImage(_selectedImage!) 
                              : null,
                          child: _selectedImage == null
                              ? Text(
                                  _nomController.text.isNotEmpty 
                                      ? _nomController.text.substring(0, 2).toUpperCase()
                                      : 'TC',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32, // Texte encore plus grand
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.green,
                              size: 24, // Icône encore plus grande
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24), // Espacement encore plus généreux
                  // Nom de l'entreprise
                  Text(
                    _nomController.text.isNotEmpty ? _nomController.text : 'Nom de l\'entreprise',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24, // Police encore plus grande
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12), // Espacement encore plus généreux
                  // Secteur d'activité
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _secteurController.text.isNotEmpty ? _secteurController.text : 'Secteur d\'activité',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Informations de contact
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoChip(
                        icon: Icons.phone,
                        text: _numeroServiceClientController.text.isNotEmpty 
                            ? _numeroServiceClientController.text 
                            : 'Téléphone',
                      ),
                      const SizedBox(width: 16),
                      _buildInfoChip(
                        icon: Icons.email,
                        text: _emailController.text.isNotEmpty 
                            ? _emailController.text 
                            : 'Email',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleHeader() {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
           // Avatar avec possibilité de modification
           GestureDetector(
             onTap: _isEditing ? _pickImage : null,
             child: Stack(
               children: [
                 CircleAvatar(
                   radius: 40,
                   backgroundColor: Colors.yellow,
                   backgroundImage: _selectedImage != null 
                       ? FileImage(_selectedImage!) 
                       : null,
                   child: _selectedImage == null
                       ? Text(
                           _nomController.text.isNotEmpty 
                               ? _nomController.text.substring(0, 2).toUpperCase()
                               : 'TC',
                           style: const TextStyle(
                             color: Colors.white,
                             fontSize: 24,
                             fontWeight: FontWeight.bold,
                           ),
                         )
                       : null,
                 ),
                 if (_isEditing)
                   Positioned(
                     bottom: 0,
                     right: 0,
                     child: Container(
                       padding: const EdgeInsets.all(4),
                       decoration: const BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                       ),
                       child: const Icon(
                         Icons.camera_alt,
                         color: Colors.green,
                         size: 16,
                       ),
                     ),
                   ),
               ],
             ),
           ),
          const SizedBox(height: 12),
          // Nom de l'entreprise
          Text(
            _nomController.text.isNotEmpty ? _nomController.text : 'Nom de l\'entreprise',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Secteur d'activité
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              _secteurController.text.isNotEmpty ? _secteurController.text : 'Secteur d\'activité',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informations personnelles',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Nom de l\'entreprise',
            controller: _nomController,
            icon: Icons.business,
            validator: (value) => value?.isEmpty == true ? 'Le nom est requis' : null,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Email',
            controller: _emailController,
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty == true) return 'L\'email est requis';
              if (!value!.contains('@')) return 'Email invalide';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Téléphone',
            controller: _telephoneController,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) => value?.isEmpty == true ? 'Le téléphone est requis' : null,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Localisation',
            controller: _adresseController,
            icon: Icons.location_on,
            validator: (value) => value?.isEmpty == true ? 'L\'adresse est requise' : null,
            hasDropdown: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'À propos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Bio',
            controller: _descriptionController,
            icon: Icons.description,
            maxLines: 3,
            validator: (value) => value?.isEmpty == true ? 'La description est requise' : null,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Secteur d\'activité',
            controller: _secteurController,
            icon: Icons.work,
            validator: (value) => value?.isEmpty == true ? 'Le secteur est requis' : null,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Site web',
            controller: _siteWebController,
            icon: Icons.web,
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Numéro service client',
            controller: _numeroServiceClientController,
            icon: Icons.support_agent,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          _buildCitiesSelection(),
          const SizedBox(height: 20),
          _buildGoogleMapsField(),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
    bool hasDropdown = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: _isEditing ? const Color(0xFFF5F5F5) : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            enabled: _isEditing,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
              suffixIcon: hasDropdown 
                  ? const Icon(Icons.keyboard_arrow_down, color: Colors.grey)
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintText: _isEditing ? 'Saisissez $label' : 'Non renseigné',
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }

  Widget _buildCitiesSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Villes d\'implantation (Cameroun)',
          style: AppTheme.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedCities.map((city) {
                  return Chip(
                    label: Text(city),
                    deleteIcon: _isEditing ? const Icon(Icons.close, size: 18) : null,
                    onDeleted: _isEditing ? () {
                      setState(() {
                        _selectedCities.remove(city);
                      });
                    } : null,
                    backgroundColor: Colors.green.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.green),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              if (_isEditing)
                ElevatedButton.icon(
                  onPressed: _showCitySelectionDialog,
                  icon: const Icon(Icons.add_location),
                  label: const Text('Ajouter des villes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleMapsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Position sur Google Maps',
          style: AppTheme.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _positionGoogleMapsController,
          decoration: InputDecoration(
            hintText: 'Collez le lien Google Maps de votre entreprise',
            prefixIcon: const Icon(Icons.map, color: Colors.green),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12), // Padding encore plus réduit
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetForm,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 10), // Padding réduit
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Annuler'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10), // Padding réduit
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Sauvegarder'),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text('Prendre une photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromSource(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choisir depuis la galerie'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromSource(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text('Annuler'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la sélection de l\'image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCitySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Sélectionner des villes'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: ListView.builder(
              itemCount: _citiesOfCameroon.length,
              itemBuilder: (context, index) {
                final city = _citiesOfCameroon[index];
                final isSelected = _selectedCities.contains(city);
                return CheckboxListTile(
                  title: Text(city),
                  value: isSelected,
                  onChanged: (bool? value) {
                    setDialogState(() {
                      if (value == true) {
                        _selectedCities.add(city);
                      } else {
                        _selectedCities.remove(city);
                      }
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEditMode() {
    if (_isEditing) {
      // Mode sauvegarde
      if (_formKey.currentState!.validate()) {
        _saveProfile();
        setState(() {
          _isEditing = false;
        });
      }
    } else {
      // Mode édition
      setState(() {
        _isEditing = true;
      });
    }
  }

  void _resetForm() {
    _loadProfileData();
    setState(() {
      _selectedImage = null;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Ici on pourrait sauvegarder les données
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil mis à jour avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

