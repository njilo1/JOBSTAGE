import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard_screen.dart';
import 'company_detail_screen.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  String selectedFilter = 'Toutes';
  final List<String> filters = [
    'Toutes',
    'Technologie',
    'Finance',
    'Santé',
    'Éducation',
    'Commerce',
  ];
  final TextEditingController searchController = TextEditingController();

  // Données des entreprises
  final List<Map<String, dynamic>> companies = [
    {
      'name': 'TechCorp Cameroun',
      'industry': 'Technologie',
      'location': 'Yaoundé',
      'employees': '50-200',
      'description': 'Leader en solutions technologiques au Cameroun',
      'logo': 'assets/images/techcorp_logo.png',
      'rating': 4.5,
      'followers': 1250,
      'isFollowing': false,
      'offersCount': 4,
      'lastActivity': 'Il y a 2h',
    },
    {
      'name': 'StartupX',
      'industry': 'Technologie',
      'location': 'Douala',
      'employees': '10-50',
      'description': 'Innovation et développement d\'applications mobiles',
      'logo': 'assets/images/startupx_logo.png',
      'rating': 4.2,
      'followers': 890,
      'isFollowing': true,
      'offersCount': 4,
      'lastActivity': 'Il y a 1 jour',
    },
    {
      'name': 'BigCorp',
      'industry': 'Finance',
      'location': 'Yaoundé',
      'employees': '200+',
      'description': 'Services financiers et bancaires',
      'logo': 'assets/images/bigcorp_logo.png',
      'rating': 4.7,
      'followers': 2100,
      'isFollowing': false,
      'offersCount': 4,
      'lastActivity': 'Il y a 3h',
    },
    {
      'name': 'WebAgency',
      'industry': 'Technologie',
      'location': 'Bamenda',
      'employees': '20-100',
      'description': 'Agence web et marketing digital',
      'logo': 'assets/images/webagency_logo.png',
      'rating': 4.0,
      'followers': 650,
      'isFollowing': false,
      'offersCount': 4,
      'lastActivity': 'Il y a 5h',
    },
    {
      'name': 'Innovation Hub',
      'industry': 'Éducation',
      'location': 'Douala',
      'employees': '50-200',
      'description': 'Centre de formation et d\'innovation',
      'logo': 'assets/images/innovation_logo.png',
      'rating': 4.3,
      'followers': 980,
      'isFollowing': true,
      'offersCount': 4,
      'lastActivity': 'Il y a 1h',
    },
    {
      'name': 'Data Solutions',
      'industry': 'Technologie',
      'location': 'Yaoundé',
      'employees': '30-100',
      'description': 'Solutions de données et analytics',
      'logo': 'assets/images/data_logo.png',
      'rating': 4.1,
      'followers': 750,
      'isFollowing': false,
      'offersCount': 4,
      'lastActivity': 'Il y a 4h',
    },
  ];

  List<Map<String, dynamic>> get filteredCompanies {
    List<Map<String, dynamic>> filtered = companies;

    // Filtre par industrie
    if (selectedFilter != 'Toutes') {
      filtered = filtered
          .where((company) => company['industry'] == selectedFilter)
          .toList();
    }

    // Filtre par recherche
    if (searchController.text.isNotEmpty) {
      filtered = filtered
          .where(
            (company) =>
                company['name'].toLowerCase().contains(
                  searchController.text.toLowerCase(),
                ) ||
                company['description'].toLowerCase().contains(
                  searchController.text.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppBar(
        backgroundColor: AppColors.blueDark,
        foregroundColor: Colors.white,
        title: Text(
          'Entreprises',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Container(
            color: AppColors.blueDark,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Rechercher une entreprise...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.blueDark,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 16),
                // Filtres
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      final filter = filters[index];
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? null
                                  : Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                            ),
                            child: Text(
                              filter,
                              style: GoogleFonts.roboto(
                                color: isSelected
                                    ? AppColors.blueDark
                                    : Colors.white,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Liste des entreprises
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                final company = filteredCompanies[index];
                return _buildCompanyCard(company);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompanyDetailScreen(company: company),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // Logo de l'entreprise
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.blueDark.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.business,
                        color: AppColors.blueDark,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Informations de l'entreprise
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            company['industry'],
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: AppColors.blueDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: AppColors.secondaryText,
                                  ),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      company['location'],
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                        color: AppColors.secondaryText,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.people,
                                    size: 14,
                                    color: AppColors.secondaryText,
                                  ),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      company['employees'],
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                        color: AppColors.secondaryText,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Bouton suivre
                    GestureDetector(
                      onTap: () => _toggleFollow(company),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: company['isFollowing']
                              ? AppColors.blueDark
                              : AppColors.blueDark.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: company['isFollowing']
                              ? null
                              : Border.all(color: AppColors.blueDark),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              company['isFollowing'] ? Icons.check : Icons.add,
                              size: 14,
                              color: company['isFollowing']
                                  ? Colors.white
                                  : AppColors.blueDark,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              company['isFollowing'] ? 'Suivi' : 'Suivre',
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: company['isFollowing']
                                    ? Colors.white
                                    : AppColors.blueDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  company['description'],
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                // Statistiques
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildStatItem(
                      Icons.people,
                      '${company['followers']}',
                      AppColors.blueDark,
                    ),
                    _buildStatItem(
                      Icons.work,
                      '${company['offersCount']}',
                      AppColors.greenDark,
                    ),
                    const Spacer(),
                    Text(
                      company['lastActivity'],
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _toggleFollow(Map<String, dynamic> company) {
    setState(() {
      company['isFollowing'] = !company['isFollowing'];
      if (company['isFollowing']) {
        company['followers']++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Vous suivez maintenant ${company['name']}',
              style: GoogleFonts.roboto(),
            ),
            backgroundColor: AppColors.greenDark,
          ),
        );
      } else {
        company['followers']--;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Vous ne suivez plus ${company['name']}',
              style: GoogleFonts.roboto(),
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    });
  }
}
