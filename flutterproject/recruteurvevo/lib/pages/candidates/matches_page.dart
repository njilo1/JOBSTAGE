import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';
import '../../models/candidat.dart';
import 'candidate_details_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final DataService _dataService = DataService();
  List<Candidat> _matches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  void _loadMatches() {
    setState(() {
      _isLoading = true;
    });
    
    // Simuler un chargement et récupérer les candidats matches
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _matches = _dataService.candidats.where((candidat) => 
          candidat.isActif && candidat.niveauEtude == 'Bac+5'
        ).toList();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.customColors['surface_bg'],
      appBar: AppBar(
        title: const Text('Candidats Matches'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _loadMatches,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingState() : _buildMatchesList(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildMatchesList() {
    if (_matches.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _matches.length,
      itemBuilder: (context, index) {
        final candidat = _matches[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () => _navigateToCandidateDetails(candidat),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                          child: Text(
                            candidat.nomComplet.split(' ').map((name) => name[0]).join(''),
                            style: AppTheme.titleMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                candidat.nomComplet,
                                style: AppTheme.titleMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                candidat.domaineEtude,
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.customColors['secondary_text'],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _contactCandidate(candidat),
                              icon: const Icon(Icons.phone),
                              color: AppTheme.primaryColor,
                              iconSize: 20,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _viewCandidateCV(candidat),
                              icon: const Icon(Icons.description),
                              color: AppTheme.customColors['secondary_text'],
                              iconSize: 20,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppTheme.customColors['secondary_text'],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            candidat.localisation,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.customColors['secondary_text'],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Match parfait',
                            style: AppTheme.labelSmall.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
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
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.psychology_outlined,
            size: 80,
            color: AppTheme.customColors['secondary_text'],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun match trouvé',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Les candidats qui correspondent parfaitement à vos offres apparaîtront ici',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadMatches,
            icon: const Icon(Icons.refresh),
            label: const Text('Actualiser'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCandidateDetails(Candidat candidat) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CandidateDetailsPage(candidat: candidat),
      ),
    );
  }

  void _contactCandidate(Candidat candidat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contacter ${candidat.nomComplet}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Téléphone'),
              subtitle: Text(candidat.telephone),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ouverture de l\'application téléphone')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(candidat.email),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ouverture de l\'application email')),
                );
              },
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

  void _viewCandidateCV(Candidat candidat) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ouverture du CV de ${candidat.nomComplet}'),
        action: SnackBarAction(
          label: 'Télécharger',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Téléchargement du CV...')),
            );
          },
        ),
      ),
    );
  }
}