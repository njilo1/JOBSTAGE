import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'Comment créer une offre d\'emploi ?',
      answer: 'Pour créer une offre d\'emploi, allez dans l\'onglet "Offres" et cliquez sur le bouton "+" en bas à droite. Remplissez tous les champs requis et publiez votre offre.',
    ),
    FAQItem(
      question: 'Comment rechercher des candidats ?',
      answer: 'Utilisez la barre de recherche dans l\'onglet "Candidats" pour filtrer par nom, compétences ou localisation. Vous pouvez aussi utiliser les filtres disponibles.',
    ),
    FAQItem(
      question: 'Comment contacter un candidat ?',
      answer: 'Cliquez sur le profil d\'un candidat pour voir ses détails, puis utilisez les options de contact (téléphone, email, SMS) disponibles.',
    ),
    FAQItem(
      question: 'Comment modifier mon profil ?',
      answer: 'Allez dans "Paramètres" > "Compte" > "Profil" pour modifier vos informations d\'entreprise.',
    ),
    FAQItem(
      question: 'Comment désactiver une offre ?',
      answer: 'Dans la liste des offres, cliquez sur le menu (3 points) d\'une offre et sélectionnez "Désactiver". L\'offre deviendra grise et ne sera plus visible.',
    ),
    FAQItem(
      question: 'Comment réactiver une offre ?',
      answer: 'Cliquez sur le menu d\'une offre désactivée et sélectionnez "Activer" pour la rendre à nouveau visible.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFAQs = _faqItems.where((item) =>
        item.question.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item.answer.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      backgroundColor: AppTheme.customColors['surface_bg']!,
      appBar: AppBar(
        title: const Text('Centre d\'aide'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _searchQuery.isEmpty ? _buildMainContent() : _buildSearchResults(filteredFAQs),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Rechercher dans l\'aide...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHelpHeader(),
        const SizedBox(height: 24),
        _buildQuickActions(),
        const SizedBox(height: 24),
        _buildFAQSection(),
        const SizedBox(height: 24),
        _buildContactSection(),
      ],
    );
  }

  Widget _buildHelpHeader() {
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
            Icons.help_outline,
            size: 60,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Comment pouvons-nous vous aider ?',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Trouvez des réponses à vos questions ou contactez notre équipe de support',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
            'Actions rapides',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildQuickActionTile(
            icon: Icons.video_library,
            title: 'Tutoriels vidéo',
            subtitle: 'Apprenez à utiliser l\'application',
            onTap: () => _showSnackBar('Ouverture des tutoriels vidéo'),
          ),
          const Divider(),
          _buildQuickActionTile(
            icon: Icons.book,
            title: 'Guide d\'utilisation',
            subtitle: 'Documentation complète',
            onTap: () => _showSnackBar('Ouverture du guide d\'utilisation'),
          ),
          const Divider(),
          _buildQuickActionTile(
            icon: Icons.chat,
            title: 'Chat en direct',
            subtitle: 'Parlez avec notre support',
            onTap: () => _showSnackBar('Connexion au chat en direct'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildFAQSection() {
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
            'Questions fréquentes',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ..._faqItems.take(3).map((item) => _buildFAQItem(item)),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => setState(() => _searchQuery = ''),
            child: const Text('Voir toutes les questions'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<FAQItem> results) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Résultats de recherche (${results.length})',
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...results.map((item) => _buildFAQItem(item)),
      ],
    );
  }

  Widget _buildFAQItem(FAQItem item) {
    return ExpansionTile(
      title: Text(
        item.question,
        style: AppTheme.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            item.answer,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
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
            'Besoin d\'aide supplémentaire ?',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: 'support@recruteurvevo.cm',
            onTap: () => _showSnackBar('Ouverture de l\'application email'),
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.phone,
            title: 'Téléphone',
            subtitle: '+237 6XX XX XX XX',
            onTap: () => _showSnackBar('Ouverture de l\'application téléphone'),
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.chat,
            title: 'Chat en direct',
            subtitle: 'Disponible 24h/24',
            onTap: () => _showSnackBar('Connexion au chat en direct'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

