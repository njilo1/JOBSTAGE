import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with TickerProviderStateMixin {
  String selectedTab = 'Offres';
  String selectedFilter = 'Offres'; // Nouveau: pour le filtre des cartes
  final List<String> tabs = ['Offres', 'Formations', 'Entreprises'];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> favoriteOffers = [
    {
      'title': 'Développeur Flutter Junior',
      'company': 'TechCorp Cameroun',
      'location': 'Yaoundé',
      'type': 'CDI',
      'time': 'Il y a 2h',
      'match': '92%',
      'salary': '400,000 - 600,000 FCFA',
      'isJob': true,
      'addedToFavorites': '13 Sep 2024',
    },
    {
      'title': 'Stage Data Science',
      'company': 'Analytics Pro',
      'location': 'Douala',
      'type': 'Stage 4 mois',
      'time': 'Il y a 1 jour',
      'match': '85%',
      'salary': '100,000 FCFA',
      'isJob': false,
      'addedToFavorites': '11 Sep 2024',
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Creative Agency',
      'location': 'Yaoundé',
      'type': 'CDI',
      'time': 'Il y a 2 jours',
      'match': '91%',
      'salary': '450,000 - 700,000 FCFA',
      'isJob': true,
      'addedToFavorites': '10 Sep 2024',
    },
  ];

  final List<Map<String, dynamic>> favoriteTrainings = [
    {
      'title': 'Formation Flutter Avancé',
      'provider': 'TechAcademy Cameroun',
      'duration': '3 mois',
      'price': '150,000 FCFA',
      'rating': 4.8,
      'category': 'Développement',
      'level': 'Avancé',
      'addedToFavorites': '12 Sep 2024',
    },
    {
      'title': 'UI/UX Design Fundamentals',
      'provider': 'Design Institute',
      'duration': '2 mois',
      'price': '120,000 FCFA',
      'rating': 4.6,
      'category': 'Design',
      'level': 'Débutant',
      'addedToFavorites': '09 Sep 2024',
    },
  ];

  final List<Map<String, dynamic>> favoriteCompanies = [
    {
      'name': 'TechCorp Cameroun',
      'industry': 'Technologie',
      'location': 'Yaoundé',
      'employees': '50-100',
      'openPositions': 5,
      'rating': 4.7,
      'description': 'Entreprise leader dans le développement d\'applications mobiles au Cameroun',
      'addedToFavorites': '14 Sep 2024',
    },
    {
      'name': 'Innovation Hub',
      'industry': 'Marketing Digital',
      'location': 'Douala',
      'employees': '20-50',
      'openPositions': 3,
      'rating': 4.5,
      'description': 'Agence spécialisée dans le marketing digital et la communication',
      'addedToFavorites': '11 Sep 2024',
    },
    {
      'name': 'Data Solutions',
      'industry': 'Data Science',
      'location': 'Yaoundé',
      'employees': '30-70',
      'openPositions': 2,
      'rating': 4.8,
      'description': 'Entreprise spécialisée dans l\'analyse de données et l\'intelligence artificielle',
      'addedToFavorites': '08 Sep 2024',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppBar(
        backgroundColor: AppColors.blueDark,
        foregroundColor: Colors.white,
        title: Text(
          'Mes Favoris',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showClearAllDialog,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Vider tous les favoris',
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab selector
          Container(
            color: AppColors.blueDark,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = selectedTab == tab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tab;
                          selectedFilter = tab; // Synchroniser le filtre avec l'onglet
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: Center(
                          child: Text(
                            tab,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? AppColors.blueDark : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Statistics
          _buildStatistics(),
          // Content based on selected tab
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildAnimatedStatCard(
              'Offres',
              favoriteOffers.length.toString(),
              AppColors.blueDark,
              Icons.work,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildAnimatedStatCard(
              'Formations',
              favoriteTrainings.length.toString(),
              AppColors.formationIconColor,
              Icons.school,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildAnimatedStatCard(
              'Entreprises',
              favoriteCompanies.length.toString(),
              AppColors.orangeDark,
              Icons.business,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatCard(String title, String value, Color color, IconData icon) {
    final isSelected = selectedFilter == title;
    
    return GestureDetector(
      onTap: () {
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
        setState(() {
          selectedFilter = title;
          selectedTab = title; // Synchroniser avec l'onglet
        });
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? 0.95 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected ? Border.all(color: color, width: 2) : null,
                boxShadow: [
                  BoxShadow(
                    color: isSelected 
                        ? color.withOpacity(0.3)
                        : Colors.black.withValues(alpha: 0.08),
                    blurRadius: isSelected ? 12 : 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    icon, 
                    color: isSelected ? color : color.withOpacity(0.7), 
                    size: isSelected ? 28 : 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: GoogleFonts.roboto(
                      fontSize: isSelected ? 22 : 20,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? color : color.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? color : AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    if (selectedFilter == 'Offres') {
      return _buildOffersList();
    } else if (selectedFilter == 'Formations') {
      return _buildTrainingsList();
    } else {
      return _buildCompaniesList();
    }
  }

  Widget _buildOffersList() {
    if (favoriteOffers.isEmpty) {
      return _buildEmptyState('Aucune offre favorite', 'Ajoutez des offres à vos favoris pour les retrouver ici');
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: favoriteOffers.length,
      itemBuilder: (context, index) {
        final offer = favoriteOffers[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildOfferCard(offer, index),
        );
      },
    );
  }

  Widget _buildTrainingsList() {
    if (favoriteTrainings.isEmpty) {
      return _buildEmptyState('Aucune formation favorite', 'Ajoutez des formations à vos favoris pour les retrouver ici');
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: favoriteTrainings.length,
      itemBuilder: (context, index) {
        final training = favoriteTrainings[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildTrainingCard(training, index),
        );
      },
    );
  }

  Widget _buildCompaniesList() {
    if (favoriteCompanies.isEmpty) {
      return _buildEmptyState('Aucune entreprise favorite', 'Ajoutez des entreprises à vos favoris pour les retrouver ici');
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: favoriteCompanies.length,
      itemBuilder: (context, index) {
        final company = favoriteCompanies[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildCompanyCard(company, index),
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer, int index) {
    final borderColor = offer['isJob'] ? AppColors.greenDark : AppColors.blueDark;
    
    return Dismissible(
      key: Key('offer_$index'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          favoriteOffers.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Offre supprimée des favoris'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () {
                setState(() {
                  favoriteOffers.insert(index, offer);
                });
              },
            ),
          ),
        );
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      child: GestureDetector(
        onTap: () => _showOfferDetails(offer),
        child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 5,
            ),
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['title'],
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer['company'],
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.bookmark,
                  color: AppColors.favorisIconColor,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Ajouté le ${offer['addedToFavorites']}',
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: AppColors.secondaryText,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildDetailChip(Icons.pin_drop, offer['location'], AppColors.orangeDark),
                const SizedBox(width: 15),
                _buildDetailChip(Icons.description, offer['type'], AppColors.blueDark),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildTrainingCard(Map<String, dynamic> training, int index) {
    return Dismissible(
      key: Key('training_$index'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          favoriteTrainings.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Formation supprimée des favoris'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () {
                setState(() {
                  favoriteTrainings.insert(index, training);
                });
              },
            ),
          ),
        );
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      child: GestureDetector(
        onTap: () => _showTrainingDetails(training),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border(
              left: BorderSide(
                color: AppColors.formationIconColor,
                width: 5,
              ),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          training['title'],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          training['provider'],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.bookmark,
                    color: AppColors.favorisIconColor,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Ajouté le ${training['addedToFavorites']}',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${training['rating']}',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Text(
                    training['price'],
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greenDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company, int index) {
    return Dismissible(
      key: Key('company_$index'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          favoriteCompanies.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Entreprise supprimée des favoris'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () {
                setState(() {
                  favoriteCompanies.insert(index, company);
                });
              },
            ),
          ),
        );
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      child: GestureDetector(
        onTap: () => _showCompanyDetails(company),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border(
              left: BorderSide(
                color: AppColors.orangeDark,
                width: 5,
              ),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company['name'],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          company['industry'],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.bookmark,
                    color: AppColors.favorisIconColor,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                company['description'],
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                'Ajouté le ${company['addedToFavorites']}',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildDetailChip(Icons.location_on, company['location'], AppColors.orangeDark),
                  const SizedBox(width: 15),
                  _buildDetailChip(Icons.work, '${company['openPositions']} postes', AppColors.blueDark),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 16,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  void _showOfferDetails(Map<String, dynamic> offer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['title'],
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        offer['company'],
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDetailSection('Salaire', offer['salary']),
                      _buildLocationSection('Localisation', offer['location']),
                      _buildDetailSection('Type de contrat', offer['type']),
                      _buildDetailSection('Match', offer['match']),
                      _buildDetailSection('Publié', offer['time']),
                      _buildDetailSection('Ajouté aux favoris', offer['addedToFavorites']),
                      _buildDetailSection('Description', 
                        'Nous recherchons un professionnel passionné pour rejoindre notre équipe dynamique. Une excellente opportunité de développement professionnel vous attend.'
                      ),
                      _buildDetailSection('Compétences requises', 
                        '• Flutter et Dart\n• Firebase\n• API REST\n• Git\n• Travail en équipe'
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showApplicationDialog(offer);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blueDark,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Postuler maintenant',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(String title, String location) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Text(
                  location,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _openGoogleMaps(location),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.blueDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.blueDark.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.blueDark,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Maps',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openGoogleMaps(String location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ouverture de Google Maps pour "$location" - Fonctionnalité à venir',
          style: GoogleFonts.roboto(),
        ),
        backgroundColor: AppColors.blueDark,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  void _showApplicationDialog(Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Candidature envoyée !',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        content: Text(
          'Votre candidature pour le poste "${offer['title']}" chez ${offer['company']} a été envoyée avec succès.',
          style: GoogleFonts.roboto(
            color: AppColors.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.roboto(
                color: AppColors.blueDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTrainingDetails(Map<String, dynamic> training) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        training['title'],
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        training['provider'],
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDetailSection('Prix', training['price']),
                      _buildDetailSection('Durée', training['duration']),
                      _buildDetailSection('Niveau', training['level']),
                      _buildDetailSection('Catégorie', training['category']),
                      _buildDetailSection('Note', '${training['rating']}/5 ⭐'),
                      _buildLocationSection('Localisation', 'Yaoundé, Cameroun'),
                      _buildDetailSection('Ajouté aux favoris', training['addedToFavorites']),
                      _buildDetailSection('Description', 
                        'Formation complète et professionnelle pour maîtriser les compétences demandées. Cette formation vous permettra d\'acquérir une expertise solide dans le domaine.'
                      ),
                      _buildDetailSection('Programme', 
                        '• Module 1: Introduction et bases\n• Module 2: Concepts avancés\n• Module 3: Projets pratiques\n• Module 4: Certification finale'
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showEnrollmentDialog(training);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.formationIconColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'S\'inscrire maintenant',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCompanyDetails(Map<String, dynamic> company) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company['name'],
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        company['industry'],
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildLocationSection('Localisation', company['location']),
                      _buildDetailSection('Taille de l\'entreprise', company['employees']),
                      _buildDetailSection('Postes ouverts', '${company['openPositions']} postes disponibles'),
                      _buildDetailSection('Note', '${company['rating']}/5 ⭐'),
                      _buildDetailSection('Ajouté aux favoris', company['addedToFavorites']),
                      _buildDetailSection('Description', company['description']),
                      _buildDetailSection('À propos', 
                        'Entreprise dynamique et innovante offrant des opportunités de carrière exceptionnelles. Nous valorisons la créativité, l\'excellence et le travail d\'équipe.'
                      ),
                      _buildDetailSection('Avantages', 
                        '• Environnement de travail moderne\n• Formation continue\n• Équipe jeune et motivée\n• Possibilités d\'évolution'
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showFollowDialog(company);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangeDark,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Suivre l\'entreprise',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEnrollmentDialog(Map<String, dynamic> training) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Inscription confirmée !',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        content: Text(
          'Votre inscription à la formation "${training['title']}" chez ${training['provider']} a été confirmée.',
          style: GoogleFonts.roboto(
            color: AppColors.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.roboto(
                color: AppColors.formationIconColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFollowDialog(Map<String, dynamic> company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Entreprise suivie !',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        content: Text(
          'Vous suivez maintenant ${company['name']}. Vous recevrez des notifications pour les nouvelles offres.',
          style: GoogleFonts.roboto(
            color: AppColors.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.roboto(
                color: AppColors.orangeDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Vider tous les favoris',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer tous vos favoris ? Cette action est irréversible.',
          style: GoogleFonts.roboto(
            color: AppColors.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: GoogleFonts.roboto(
                color: AppColors.secondaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                favoriteOffers.clear();
                favoriteTrainings.clear();
                favoriteCompanies.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tous les favoris ont été supprimés'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text(
              'Vider tout',
              style: GoogleFonts.roboto(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
