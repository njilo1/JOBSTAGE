import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';
import '../../widgets/candidate_card.dart';
import '../../models/candidat.dart';
import 'candidate_details_page.dart';

class CandidatesListPage extends StatefulWidget {
  final int? initialTabIndex;
  
  const CandidatesListPage({super.key, this.initialTabIndex});

  @override
  State<CandidatesListPage> createState() => _CandidatesListPageState();
}

class _CandidatesListPageState extends State<CandidatesListPage> with TickerProviderStateMixin {
  final DataService _dataService = DataService();
  List<Candidat> _candidats = [];
  List<Candidat> _filteredCandidats = [];
  List<Candidat> _highMatchCandidats = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedFilter = 'Tous';
  late TabController _tabController;

  final List<String> _filters = [
    'Tous',
    'Disponibles',
    'En poste',
    'Débutant',
    'Expérimenté',
    'Senior',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, 
      vsync: this,
      initialIndex: widget.initialTabIndex ?? 0,
    );
    _loadCandidats();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadCandidats() {
    setState(() {
      _isLoading = true;
    });
    
    // Simuler un chargement
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _candidats = _dataService.candidats;
        _filteredCandidats = _candidats;
        _highMatchCandidats = _candidats.where((candidat) {
          final matchScore = _calculateMatchScore(candidat);
          return matchScore > 90;
        }).toList();
        _isLoading = false;
      });
    });
  }

  // Méthode pour calculer le score de match (simulation)
  int _calculateMatchScore(Candidat candidat) {
    int baseScore = 60;
    
    // Bonus pour l'expérience (basé sur le nombre d'expériences)
    if (candidat.experiences.length >= 3) baseScore += 20;
    else if (candidat.experiences.length >= 2) baseScore += 15;
    else if (candidat.experiences.length >= 1) baseScore += 10;
    
    // Bonus pour les compétences
    if (candidat.competences.length >= 5) baseScore += 15;
    else if (candidat.competences.length >= 3) baseScore += 10;
    else if (candidat.competences.length >= 1) baseScore += 5;
    
    // Bonus pour le niveau d'études
    if (candidat.niveauEtude == 'Bac+5') baseScore += 10;
    else if (candidat.niveauEtude == 'Bac+3') baseScore += 5;
    
    // Bonus aléatoire pour la simulation
    baseScore += (candidat.nomComplet.hashCode % 20);
    
    return baseScore.clamp(0, 100);
  }

  void _filterCandidats() {
    setState(() {
      _filteredCandidats = _candidats.where((candidat) {
        final matchesSearch = candidat.nomComplet.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                             candidat.domaineEtude.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                             candidat.localisation.toLowerCase().contains(_searchQuery.toLowerCase());
        
        if (!matchesSearch) return false;
        
        if (_selectedFilter == 'Tous') return true;
        if (_selectedFilter == 'Disponibles') return candidat.isActif;
        if (_selectedFilter == 'En poste') return !candidat.isActif;
        if (_selectedFilter == 'Débutant') return candidat.niveauEtude == 'Bac+3';
        if (_selectedFilter == 'Expérimenté') return candidat.niveauEtude == 'Bac+5';
        if (_selectedFilter == 'Senior') return candidat.niveauEtude == 'Doctorat';
        
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.customColors['surface_bg']!,
      appBar: AppBar(
        title: const Text('Candidats'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Tous les candidats'),
            Tab(text: 'Matches élevés'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _loadCandidats,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Onglet 1: Tous les candidats
          Column(
            children: [
              _buildSearchBar(),
              _buildFilterChips(),
              Expanded(
                child: _isLoading ? _buildLoadingState() : _buildCandidatsList(),
              ),
            ],
          ),
          // Onglet 2: Matches élevés
          _isLoading ? _buildLoadingState() : _buildHighMatchCandidatsList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          _searchQuery = value;
          _filterCandidats();
        },
        decoration: InputDecoration(
          hintText: 'Rechercher un candidat...',
          hintStyle: AppTheme.bodyMedium.copyWith(
            color: AppTheme.customColors['secondary_text'],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.customColors['secondary_text'],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppTheme.customColors['divider_color']!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppTheme.customColors['divider_color']!,
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
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
                _filterCandidats();
              },
              selectedColor: AppTheme.primaryColor.withOpacity(0.2),
              checkmarkColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.primaryColor : AppTheme.customColors['secondary_text'],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildCandidatsList() {
    if (_filteredCandidats.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredCandidats.length,
      itemBuilder: (context, index) {
        final candidat = _filteredCandidats[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CandidateCard(
            candidat: candidat,
            onTap: () => _navigateToCandidateDetails(candidat),
          ),
        );
      },
    );
  }

  Widget _buildHighMatchCandidatsList() {
    if (_highMatchCandidats.isEmpty) {
      return _buildHighMatchEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _highMatchCandidats.length,
      itemBuilder: (context, index) {
        final candidat = _highMatchCandidats[index];
        final matchScore = _calculateMatchScore(candidat);
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                candidat.nomComplet.substring(0, 2).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              candidat.nomComplet,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${candidat.domaineEtude} • ${candidat.experiences.length} expérience${candidat.experiences.length > 1 ? 's' : ''}'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${matchScore}% match',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToCandidateDetails(candidat),
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
            Icons.people_outline,
            size: 80,
            color: AppTheme.customColors['secondary_text'],
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty || _selectedFilter != 'Tous'
                ? 'Aucun candidat trouvé'
                : 'Aucun candidat disponible',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty || _selectedFilter != 'Tous'
                ? 'Essayez de modifier vos critères de recherche'
                : 'Les candidats apparaîtront ici une fois inscrits',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isNotEmpty || _selectedFilter != 'Tous') ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedFilter = 'Tous';
                });
                _filterCandidats();
              },
              child: const Text('Réinitialiser les filtres'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHighMatchEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_outline,
            size: 80,
            color: AppTheme.customColors['secondary_text'],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun match élevé',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aucun candidat avec un match de plus de 90% pour le moment.\nLes candidats avec des scores élevés apparaîtront ici.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.customColors['secondary_text'],
            ),
            textAlign: TextAlign.center,
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

}