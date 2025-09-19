import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedCategory = 'Support technique';
  String _selectedPriority = 'Normal';

  final List<String> _categories = [
    'Support technique',
    'Question générale',
    'Signalement de bug',
    'Demande de fonctionnalité',
    'Problème de facturation',
    'Autre',
  ];

  final List<String> _priorities = [
    'Faible',
    'Normal',
    'Élevé',
    'Urgent',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.customColors['surface_bg']!,
      appBar: AppBar(
        title: const Text('Nous contacter'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildContactHeader(),
          const SizedBox(height: 24),
          _buildContactForm(),
          const SizedBox(height: 24),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildContactHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.contact_support,
            size: 60,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Contactez notre équipe',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nous sommes là pour vous aider. Envoyez-nous votre message et nous vous répondrons dans les plus brefs délais.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulaire de contact',
              style: AppTheme.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              label: 'Nom complet',
              icon: Icons.person,
              validator: (value) => value?.isEmpty == true ? 'Le nom est requis' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty == true) return 'L\'email est requis';
                if (!value!.contains('@')) return 'Email invalide';
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              value: _selectedCategory,
              label: 'Catégorie',
              icon: Icons.category,
              items: _categories,
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              value: _selectedPriority,
              label: 'Priorité',
              icon: Icons.flag,
              items: _priorities,
              onChanged: (value) => setState(() => _selectedPriority = value!),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _subjectController,
              label: 'Sujet',
              icon: Icons.subject,
              validator: (value) => value?.isEmpty == true ? 'Le sujet est requis' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              icon: Icons.message,
              maxLines: 5,
              validator: (value) => value?.isEmpty == true ? 'Le message est requis' : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Envoyer le message'),
              ),
            ),
          ],
        ),
      ),
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
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Autres moyens de contact',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: 'support@recruteurvevo.cm',
            description: 'Réponse sous 24h',
            onTap: () => _showSnackBar('Ouverture de l\'application email'),
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.phone,
            title: 'Téléphone',
            subtitle: '+237 6XX XX XX XX',
            description: 'Lun-Ven 8h-18h',
            onTap: () => _showSnackBar('Ouverture de l\'application téléphone'),
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.chat,
            title: 'Chat en direct',
            subtitle: 'Disponible maintenant',
            description: 'Support instantané',
            onTap: () => _showSnackBar('Connexion au chat en direct'),
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.location_on,
            title: 'Adresse',
            subtitle: 'Yaoundé, Cameroun',
            description: 'Bastos, Yaoundé',
            onTap: () => _showSnackBar('Ouverture de l\'application de cartes'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          Text(
            description,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSnackBar('Message envoyé avec succès ! Nous vous répondrons bientôt.');
      // Ici on pourrait envoyer le message
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}

