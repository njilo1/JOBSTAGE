import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard_screen.dart';
import '../utils/offer_status.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  // Système de filtres multiples
  Set<String> selectedFilters = {'Tous'};
  final List<String> filters = [
    'Tous',
    'Emplois',
    'Stages',
    'CDI',
    'CDD',
    'Stage 6 mois',
    'Stage académique',
    'Stage libre',
    'Yaoundé',
    'Douala',
    'Bafoussam',
    'Récent',
    'Match élevé',
    'Freelance',
    'Temps partiel',
    'Télétravail',
  ];

  final List<Map<String, dynamic>> allOffers = [
    {
      'title': 'Développeur Flutter Senior',
      'company': 'TechCorp Cameroun',
      'location': 'Yaoundé',
      'type': 'CDI',
      'time': 'Il y a 1h',
      'match': '96%',
      'salary': '800,000 - 1,200,000 FCFA',
      'isJob': true,
      'isFavorite': false,
      'status': 'En cours',
    },
    {
      'title': 'Développeur Flutter Junior',
      'company': 'TechCorp Cameroun',
      'location': 'Yaoundé',
      'type': 'CDI',
      'time': 'Il y a 2h',
      'match': '92%',
      'salary': '400,000 - 600,000 FCFA',
      'isJob': true,
      'isFavorite': true,
      'status': 'En pause',
    },
    {
      'title': 'Stage Marketing Digital',
      'company': 'Innovation Hub',
      'location': 'Douala',
      'type': 'Stage 6 mois',
      'time': 'Il y a 5h',
      'match': '87%',
      'salary': '150,000 FCFA',
      'isJob': false,
      'isFavorite': false,
      'status': 'Expirée',
    },
    {
      'title': 'Développeur Web Full-Stack',
      'company': 'Digital Solutions',
      'location': 'Yaoundé',
      'type': 'CDD 2 ans',
      'time': 'Il y a 8h',
      'match': '89%',
      'salary': '500,000 - 800,000 FCFA',
      'isJob': true,
      'isFavorite': false,
      'status': 'En cours',
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
      'isFavorite': true,
      'status': 'En pause',
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
      'isFavorite': false,
      'status': 'Expirée',
    },
    {
      'title': 'Développeur Web Freelance',
      'company': 'Tech Solutions',
      'location': 'Télétravail',
      'type': 'Freelance',
      'time': 'Il y a 3 jours',
      'match': '88%',
      'salary': '300,000 - 500,000 FCFA',
      'isJob': true,
      'isFavorite': false,
      'status': 'En cours',
    },
    {
      'title': 'Assistant Marketing',
      'company': 'Marketing Pro',
      'location': 'Bafoussam',
      'type': 'CDD 12 mois',
      'time': 'Il y a 4 jours',
      'match': '85%',
      'salary': '350,000 - 450,000 FCFA',
      'isJob': true,
      'isFavorite': false,
      'status': 'En pause',
    },
    {
      'title': 'Stage Développement Mobile',
      'company': 'MobileCorp',
      'location': 'Douala',
      'type': 'Stage 6 mois',
      'time': 'Il y a 5 jours',
      'match': '82%',
      'salary': '150,000 FCFA',
      'isJob': false,
      'isFavorite': false,
      'status': 'Expirée',
    },
    {
      'title': 'Consultant IT',
      'company': 'IT Consulting',
      'location': 'Yaoundé',
      'type': 'Temps partiel',
      'time': 'Il y a 1 semaine',
      'match': '90%',
      'salary': '200,000 - 300,000 FCFA',
      'isJob': true,
      'isFavorite': false,
      'status': 'En cours',
    },
    {
      'title': 'Stage Académique en Informatique',
      'company': 'Université de Yaoundé I',
      'location': 'Yaoundé',
      'type': 'Stage académique 3 mois',
      'time': 'Il y a 2 jours',
      'match': '85%',
      'salary': '50,000 FCFA',
      'isJob': false,
      'isFavorite': false,
    },
    {
      'title': 'Stage Libre Développement Web',
      'company': 'StartupCorp',
      'location': 'Douala',
      'type': 'Stage libre 4 mois',
      'time': 'Il y a 3 jours',
      'match': '88%',
      'salary': '100,000 FCFA',
      'isJob': false,
      'isFavorite': false,
    },
    {
      'title': 'Stage Académique Marketing',
      'company': 'École Supérieure de Commerce',
      'location': 'Bafoussam',
      'type': 'Stage académique 2 mois',
      'time': 'Il y a 4 jours',
      'match': '82%',
      'salary': '40,000 FCFA',
      'isJob': false,
      'isFavorite': false,
    },
    {
      'title': 'Stage Libre Data Analysis',
      'company': 'DataTech Solutions',
      'location': 'Yaoundé',
      'type': 'Stage libre 6 mois',
      'time': 'Il y a 5 jours',
      'match': '87%',
      'salary': '120,000 FCFA',
      'isJob': false,
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> get filteredOffers {
    if (selectedFilters.isEmpty || selectedFilters.contains('Tous')) {
      return allOffers;
    }

    List<Map<String, dynamic>> filtered = List.from(allOffers);

    // Filtrer par type d'offre
    if (selectedFilters.contains('Emplois')) {
      filtered = filtered.where((offer) => offer['isJob']).toList();
    }
    if (selectedFilters.contains('Stages')) {
      filtered = filtered.where((offer) => !offer['isJob']).toList();
    }

    // Filtrer par type de contrat
    Set<String> contractFilters = selectedFilters.intersection({
      'CDI',
      'CDD',
      'Stage 6 mois',
      'Stage académique',
      'Stage libre',
      'Freelance',
      'Temps partiel',
    });
    if (contractFilters.isNotEmpty) {
      filtered = filtered.where((offer) {
        return contractFilters.any((filter) {
          String offerType = offer['type'].toString();
          switch (filter) {
            case 'Stage 6 mois':
              return offerType.contains('Stage 6');
            case 'Stage académique':
              return offerType.contains('Stage académique');
            case 'Stage libre':
              return offerType.contains('Stage libre');
            case 'CDI':
              return offerType.contains('CDI');
            case 'CDD':
              return offerType.contains('CDD');
            case 'Freelance':
              return offerType.contains('Freelance');
            case 'Temps partiel':
              return offerType.contains('Temps partiel');
            default:
              return offerType.contains(filter);
          }
        });
      }).toList();
    }

    // Filtrer par localisation
    Set<String> locationFilters = selectedFilters.intersection({
      'Yaoundé',
      'Douala',
      'Bafoussam',
      'Télétravail',
    });
    if (locationFilters.isNotEmpty) {
      filtered = filtered.where((offer) {
        return locationFilters.contains(offer['location']);
      }).toList();
    }

    // Trier si nécessaire
    if (selectedFilters.contains('Récent')) {
      filtered.sort((a, b) => a['time'].compareTo(b['time']));
    }
    if (selectedFilters.contains('Match élevé')) {
      filtered.sort(
        (a, b) => int.parse(
          b['match'].replaceAll('%', ''),
        ).compareTo(int.parse(a['match'].replaceAll('%', ''))),
      );
    }

    return filtered;
  }

  void toggleFavorite(int index) {
    setState(() {
      allOffers[index]['isFavorite'] = !allOffers[index]['isFavorite'];
    });
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (filter == 'Tous') {
        selectedFilters.clear();
        selectedFilters.add('Tous');
      } else {
        selectedFilters.remove(
          'Tous',
        ); // Retirer "Tous" si on sélectionne autre chose
        if (selectedFilters.contains(filter)) {
          selectedFilters.remove(filter);
        } else {
          selectedFilters.add(filter);
        }
      }
    });
  }

  void _clearAllFilters() {
    setState(() {
      selectedFilters.clear();
      selectedFilters.add('Tous');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppBar(
        backgroundColor: AppColors.blueDark,
        foregroundColor: Colors.white,
        title: Text(
          'Offres d\'Emploi et Stages',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and filters
          Container(
            color: AppColors.blueDark,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Rechercher une offre...',
                      hintStyle: GoogleFonts.roboto(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.secondaryText,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Filter chips avec sélection multiple
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bouton pour effacer tous les filtres
                    if (selectedFilters.isNotEmpty &&
                        !selectedFilters.contains('Tous'))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextButton.icon(
                          onPressed: _clearAllFilters,
                          icon: const Icon(
                            Icons.clear_all,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: Text(
                            'Effacer tous les filtres',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                        ),
                      ),

                    // Liste horizontale des filtres
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        itemBuilder: (context, index) {
                          final filter = filters[index];
                          final isSelected = selectedFilters.contains(filter);
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FilterChip(
                              label: Text(
                                filter,
                                style: GoogleFonts.roboto(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.blueDark,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) => _toggleFilter(filter),
                              backgroundColor: AppColors.blueLight,
                              selectedColor: AppColors.blueDark,
                              checkmarkColor: Colors.white,
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.blueDark
                                    : AppColors.blueLight,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Results count
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  '${filteredOffers.length} offre(s) trouvée(s)',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
          // Offers list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredOffers.length,
              itemBuilder: (context, index) {
                final offer = filteredOffers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _buildOfferCard(offer, index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer, int index) {
    final borderColor = offer['isJob']
        ? AppColors.greenDark
        : AppColors.blueDark;

    return GestureDetector(
      onTap: () {
        // Navigate to offer details
        _showOfferDetails(offer);
      },
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
          border: Border(left: BorderSide(color: borderColor, width: 5)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (offer['status'] != null) ...[
                        const SizedBox(height: 6),
                        _buildStatusBadge(offer['status']),
                      ],
                      const SizedBox(height: 4),
                      Text(
                        offer['company'],
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        offer['salary'],
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greenDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => toggleFavorite(index),
                      child: Icon(
                        offer['isFavorite']
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: offer['isFavorite']
                            ? AppColors.favorisIconColor
                            : AppColors.secondaryText,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        offer['match'],
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDetailChip(
                    Icons.pin_drop,
                    offer['location'],
                    AppColors.orangeDark,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildDetailChip(
                    Icons.description,
                    offer['type'],
                    AppColors.blueDark,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildDetailChip(
                    Icons.schedule,
                    offer['time'],
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color iconColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
            overflow: TextOverflow.ellipsis,
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
                      _buildDetailSection(
                        'Description',
                        'Nous recherchons un développeur passionné pour rejoindre notre équipe dynamique. Vous travaillerez sur des projets innovants et aurez l\'opportunité de développer vos compétences dans un environnement stimulant.',
                      ),
                      _buildDetailSection(
                        'Compétences requises',
                        '• Flutter et Dart\n• Firebase\n• API REST\n• Git\n• Travail en équipe',
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
                      color: AppColors.blueDark.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.blueDark.withValues(alpha: 0.3),
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
    // TODO: Implémenter l'ouverture de Google Maps avec la localisation
    // Cette méthode sera connectée au backend plus tard pour :
    // 1. Obtenir la position actuelle du candidat
    // 2. Obtenir les coordonnées précises de l'entreprise
    // 3. Ouvrir Google Maps avec les deux positions pour calculer l'itinéraire

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
          style: GoogleFonts.roboto(color: AppColors.secondaryText),
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

  Widget _buildStatusBadge(String status) {
    OfferStatus offerStatus;
    switch (status.toLowerCase()) {
      case 'en cours':
      case 'active':
        offerStatus = OfferStatus.active;
        break;
      case 'en pause':
      case 'paused':
        offerStatus = OfferStatus.paused;
        break;
      case 'expirée':
      case 'expired':
        offerStatus = OfferStatus.expired;
        break;
      default:
        offerStatus = OfferStatus.active;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: OfferStatusHelper.getStatusBackgroundColor(offerStatus),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: OfferStatusHelper.getStatusColor(offerStatus),
          width: 1,
        ),
      ),
      child: Text(
        OfferStatusHelper.getStatusText(offerStatus),
        style: GoogleFonts.roboto(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: OfferStatusHelper.getStatusColor(offerStatus),
        ),
      ),
    );
  }
}
