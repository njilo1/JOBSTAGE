import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/offre.dart';
import '../../services/data_service.dart';

class CreateOfferPage extends StatefulWidget {
  final dynamic offreToEdit;
  
  const CreateOfferPage({super.key, this.offreToEdit});

  @override
  State<CreateOfferPage> createState() => _CreateOfferPageState();
}

class _CreateOfferPageState extends State<CreateOfferPage> {
  final _formKey = GlobalKey<FormState>();
  final _dataService = DataService();
  
  final _titreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _salaireController = TextEditingController();
  final _competencesController = TextEditingController();
  
  String _selectedTypeContrat = 'CDI';
  String _selectedNiveauExperience = 'Débutant';
  List<String> _selectedVilles = [];
  List<String> _competencesRequises = [];
  bool _isActive = true;

  // Liste des villes du Cameroun
  final List<String> _villesCameroun = [
    'Douala', 'Yaoundé', 'Bafoussam', 'Bamenda', 'Garoua', 'Maroua', 'Ngaoundéré',
    'Bertoua', 'Ebolowa', 'Kumba', 'Limbe', 'Buea', 'Dschang', 'Foumban',
    'Kribi', 'Edea', 'Mbalmayo', 'Sangmélima', 'Nkongsamba', 'Foumbot',
    'Mbouda', 'Bangangté', 'Mfou', 'Obala', 'Mokolo', 'Kousseri', 'Wum',
    'Fundong', 'Kumbo', 'Nkambe', 'Tiko', 'Muyuka', 'Idenau', 'Mamfe',
    'Akwaya', 'Eyumodjock', 'Tombel', 'Loum', 'Penja', 'Pouma', 'Bonabéri',
    'Bonapriso', 'Akwa', 'Deido', 'New Bell', 'Bali', 'Bamendouka', 'Bamunka',
    'Bamessing', 'Bamunka', 'Bamunka', 'Bamunka', 'Bamunka', 'Bamunka'
  ];

  @override
  void initState() {
    super.initState();
    // Initialiser le formulaire après que les contrôleurs soient prêts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeForm();
    });
  }

  void _initializeForm() {
    if (widget.offreToEdit != null) {
      setState(() {
        _titreController.text = widget.offreToEdit.titre;
        _descriptionController.text = widget.offreToEdit.description;
        _entrepriseController.text = widget.offreToEdit.entreprise;
        _salaireController.text = widget.offreToEdit.salaire;
        _selectedTypeContrat = widget.offreToEdit.typeContrat;
        _selectedNiveauExperience = widget.offreToEdit.niveauExperience;
        _isActive = widget.offreToEdit.isActive;
        
        // Initialiser les villes sélectionnées
        if (widget.offreToEdit.lieu.isNotEmpty) {
          _selectedVilles = widget.offreToEdit.lieu.split(', ').where((ville) => ville.isNotEmpty).toList();
        }
        
        // Initialiser les compétences requises
        if (widget.offreToEdit.competencesRequises != null) {
          _competencesRequises = List<String>.from(widget.offreToEdit.competencesRequises);
        }
      });
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    _descriptionController.dispose();
    _entrepriseController.dispose();
    _salaireController.dispose();
    _competencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.customColors['surface_bg'],
      appBar: AppBar(
        title: Text(widget.offreToEdit != null ? 'Modifier l\'offre' : 'Créer une offre'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Informations générales'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _titreController,
                label: 'Titre du poste',
                hint: 'Ex: Développeur Flutter Senior',
                validator: (value) => value?.isEmpty == true ? 'Le titre est requis' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Décrivez le poste et les responsabilités...',
                maxLines: 4,
                validator: (value) => value?.isEmpty == true ? 'La description est requise' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _entrepriseController,
                label: 'Entreprise',
                hint: 'Nom de l\'entreprise',
                validator: (value) => value?.isEmpty == true ? 'Le nom de l\'entreprise est requis' : null,
              ),
              const SizedBox(height: 16),
              _buildVillesSelection(),
              const SizedBox(height: 24),
              _buildSectionTitle('Détails du poste'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _salaireController,
                label: 'Salaire',
                hint: 'Ex: 500 000 - 800 000 FCFA',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Type de contrat',
                value: _selectedTypeContrat,
                items: ['CDI', 'CDD', 'Stage', 'Freelance', 'Temps partiel'],
                onChanged: (value) => setState(() => _selectedTypeContrat = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Niveau d\'expérience',
                value: _selectedNiveauExperience,
                items: ['Sans expérience', 'Débutant', 'Intermédiaire', 'Expérimenté', 'Senior', 'Expert'],
                onChanged: (value) => setState(() => _selectedNiveauExperience = value!),
              ),
              const SizedBox(height: 16),
              _buildCompetencesSection(),
              const SizedBox(height: 24),
              _buildSectionTitle('Paramètres'),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Offre active'),
                subtitle: const Text('L\'offre sera visible par les candidats'),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
                activeColor: AppTheme.primaryColor,
              ),
              const SizedBox(height: 32),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTheme.headlineSmall.copyWith(
        color: AppTheme.customColors['primary_text'],
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.customColors['primary_text'],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'] ?? Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.customColors['border'] ?? Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.customColors['border'] ?? Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVillesSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Villes',
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.customColors['primary_text'],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.customColors['border'] ?? Colors.grey,
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: _showVillesDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedVilles.isEmpty 
                              ? 'Sélectionner les villes' 
                              : '${_selectedVilles.length} ville(s) sélectionnée(s)',
                          style: TextStyle(
                            color: _selectedVilles.isEmpty 
                                ? AppTheme.customColors['secondary_text'] 
                                : AppTheme.customColors['primary_text'],
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              if (_selectedVilles.isNotEmpty) ...[
                const Divider(height: 1),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedVilles.map((ville) {
                      return Chip(
                        label: Text(ville),
                        onDeleted: () {
                          setState(() {
                            _selectedVilles.remove(ville);
                          });
                        },
                        deleteIcon: const Icon(Icons.close, size: 18),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.3),
            ),
          ),
          child: InkWell(
            onTap: _openMaps,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Position sur la carte',
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        Text(
                          'Cliquez pour positionner l\'offre sur Google Maps',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.customColors['secondary_text'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompetencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compétences requises',
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.customColors['primary_text'],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _competencesController,
                decoration: InputDecoration(
                  hintText: 'Ajouter une compétence',
                  hintStyle: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.customColors['secondary_text'] ?? Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppTheme.customColors['border'] ?? Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppTheme.customColors['border'] ?? Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (value) => _addCompetence(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addCompetence,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        if (_competencesRequises.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _competencesRequises.map((competence) {
              return Chip(
                label: Text(competence),
                onDeleted: () {
                  setState(() {
                    _competencesRequises.remove(competence);
                  });
                },
                deleteIcon: const Icon(Icons.close, size: 18),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.customColors['primary_text'],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.customColors['border'] ?? Colors.grey,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _submitOffer,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          widget.offreToEdit != null ? 'Modifier l\'offre' : 'Publier l\'offre',
          style: AppTheme.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showVillesDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Sélectionner les villes'),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: ListView.builder(
                itemCount: _villesCameroun.length,
                itemBuilder: (context, index) {
                  final ville = _villesCameroun[index];
                  final isSelected = _selectedVilles.contains(ville);
                  
                  return CheckboxListTile(
                    title: Text(ville),
                    value: isSelected,
                    onChanged: (value) {
                      setDialogState(() {
                        if (value == true) {
                          _selectedVilles.add(ville);
                        } else {
                          _selectedVilles.remove(ville);
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
              TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: const Text('Valider'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addCompetence() {
    final competence = _competencesController.text.trim();
    if (competence.isNotEmpty && !_competencesRequises.contains(competence)) {
      setState(() {
        _competencesRequises.add(competence);
        _competencesController.clear();
      });
    }
  }

  void _openMaps() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Position sur la carte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.map,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Fonctionnalité de géolocalisation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Cette fonctionnalité permettra de positionner l\'offre sur Google Maps pour faciliter l\'itinérance des candidats.',
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Position enregistrée (simulation)'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Enregistrer la position'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _submitOffer() {
    if (_formKey.currentState!.validate()) {
      if (_selectedVilles.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner au moins une ville'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (widget.offreToEdit != null) {
        // Mode édition - créer un nouvel objet Offre avec les modifications
        final offreModifiee = widget.offreToEdit.copyWith(
          titre: _titreController.text,
          description: _descriptionController.text,
          entreprise: _entrepriseController.text,
          salaire: _salaireController.text,
          typeContrat: _selectedTypeContrat,
          niveauExperience: _selectedNiveauExperience,
          isActive: _isActive,
          lieu: _selectedVilles.join(', '),
          localisation: _selectedVilles.join(', '),
          competencesRequises: _competencesRequises,
          statut: _isActive ? 'active' : 'suspendue',
        );

        // Mettre à jour l'offre dans le service de données
        _dataService.modifierOffre(offreModifiee);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Offre modifiée avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Mode création - créer une nouvelle offre
        final nouvelleOffre = Offre(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          titre: _titreController.text,
          description: _descriptionController.text,
          secteurActivite: 'Technologie',
          competencesRequises: _competencesRequises,
          localisation: _selectedVilles.join(', '),
          typeContrat: _selectedTypeContrat,
          niveauEtudes: 'Bac+3',
          experienceRequise: 0,
          datePublication: DateTime.now(),
          dateExpiration: DateTime.now().add(const Duration(days: 30)),
          statut: _isActive ? 'active' : 'suspendue',
          contactEmail: _dataService.entreprises.first.email,
          contactTelephone: _dataService.entreprises.first.telephone,
          entreprise: _entrepriseController.text,
          lieu: _selectedVilles.join(', '),
          salaire: _salaireController.text,
          niveauExperience: _selectedNiveauExperience,
          entrepriseId: _dataService.entreprises.first.id,
        );

        // Ajouter l'offre au service de données
        _dataService.addOffre(nouvelleOffre);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Offre créée avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // Retourner à la page précédente
      Navigator.of(context).pop();
    }
  }
}