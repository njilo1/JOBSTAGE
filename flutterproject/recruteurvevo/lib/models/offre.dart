class Offre {
  final String id;
  final String entrepriseId;
  final String titre;
  final String description;
  final String secteurActivite;
  final List<String> competencesRequises;
  final String localisation;
  final String typeContrat; // 'CDI', 'CDD', 'Stage', 'Freelance'
  final String typeStage; // 'Stage court', 'Stage long', 'PFE'
  final int dureeMois;
  final double salaireMin;
  final double salaireMax;
  final String niveauEtudes; // 'Bac', 'Bac+2', 'Bac+3', 'Bac+5', 'Doctorat'
  final int experienceRequise; // en années
  final DateTime datePublication;
  final DateTime dateExpiration;
  final String statut; // 'active', 'expiree', 'suspendue', 'supprimee'
  final int nombreCandidats;
  final int nombreCandidatures;
  final List<String> avantages;
  final String processusRecrutement;
  final String contactEmail;
  final String contactTelephone;
  
  // Propriétés supplémentaires pour la compatibilité
  final String entreprise;
  final String lieu;
  final String salaire;
  final String niveauExperience;
  bool isActive;

  Offre({
    required this.id,
    required this.entrepriseId,
    required this.titre,
    required this.description,
    required this.secteurActivite,
    required this.competencesRequises,
    required this.localisation,
    required this.typeContrat,
    this.typeStage = '',
    this.dureeMois = 0,
    this.salaireMin = 0.0,
    this.salaireMax = 0.0,
    required this.niveauEtudes,
    this.experienceRequise = 0,
    required this.datePublication,
    required this.dateExpiration,
    this.statut = 'active',
    this.nombreCandidats = 0,
    this.nombreCandidatures = 0,
    this.avantages = const [],
    this.processusRecrutement = '',
    required this.contactEmail,
    required this.contactTelephone,
    this.entreprise = '',
    this.lieu = '',
    this.salaire = '',
    this.niveauExperience = '',
    this.isActive = true,
  });

  factory Offre.fromJson(Map<String, dynamic> json) {
    return Offre(
      id: json['id'],
      entrepriseId: json['entreprise_id'],
      titre: json['titre'],
      description: json['description'],
      secteurActivite: json['secteur_activite'],
      competencesRequises: List<String>.from(json['competences_requises'] ?? []),
      localisation: json['localisation'],
      typeContrat: json['type_contrat'],
      typeStage: json['type_stage'] ?? '',
      dureeMois: json['duree_mois'] ?? 0,
      salaireMin: (json['salaire_min'] ?? 0.0).toDouble(),
      salaireMax: (json['salaire_max'] ?? 0.0).toDouble(),
      niveauEtudes: json['niveau_etudes'],
      experienceRequise: json['experience_requise'] ?? 0,
      datePublication: DateTime.parse(json['date_publication']),
      dateExpiration: DateTime.parse(json['date_expiration']),
      statut: json['statut'] ?? 'active',
      nombreCandidats: json['nombre_candidats'] ?? 0,
      nombreCandidatures: json['nombre_candidatures'] ?? 0,
      avantages: List<String>.from(json['avantages'] ?? []),
      processusRecrutement: json['processus_recrutement'] ?? '',
      contactEmail: json['contact_email'],
      contactTelephone: json['contact_telephone'],
      entreprise: json['entreprise'] ?? '',
      lieu: json['lieu'] ?? json['localisation'] ?? '',
      salaire: json['salaire'] ?? '',
      niveauExperience: json['niveau_experience'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entreprise_id': entrepriseId,
      'titre': titre,
      'description': description,
      'secteur_activite': secteurActivite,
      'competences_requises': competencesRequises,
      'localisation': localisation,
      'type_contrat': typeContrat,
      'type_stage': typeStage,
      'duree_mois': dureeMois,
      'salaire_min': salaireMin,
      'salaire_max': salaireMax,
      'niveau_etudes': niveauEtudes,
      'experience_requise': experienceRequise,
      'date_publication': datePublication.toIso8601String(),
      'date_expiration': dateExpiration.toIso8601String(),
      'statut': statut,
      'nombre_candidats': nombreCandidats,
      'nombre_candidatures': nombreCandidatures,
      'avantages': avantages,
      'processus_recrutement': processusRecrutement,
      'contact_email': contactEmail,
      'contact_telephone': contactTelephone,
      'entreprise': entreprise,
      'lieu': lieu,
      'salaire': salaire,
      'niveau_experience': niveauExperience,
      'isActive': isActive,
    };
  }

  bool get isExpired => DateTime.now().isAfter(dateExpiration);
  
  String get dureeAffichage {
    if (typeContrat == 'Stage') {
      return '$dureeMois mois';
    }
    return typeContrat;
  }

  String get salaireAffichage {
    if (salaireMin == 0 && salaireMax == 0) {
      return 'Non spécifié';
    }
    if (salaireMin == salaireMax) {
      return '${salaireMin.toStringAsFixed(0)} FCFA';
    }
    return '${salaireMin.toStringAsFixed(0)} - ${salaireMax.toStringAsFixed(0)} FCFA';
  }

  Offre copyWith({
    String? id,
    String? entrepriseId,
    String? titre,
    String? description,
    String? secteurActivite,
    List<String>? competencesRequises,
    String? localisation,
    String? typeContrat,
    String? typeStage,
    int? dureeMois,
    double? salaireMin,
    double? salaireMax,
    String? niveauEtudes,
    int? experienceRequise,
    DateTime? datePublication,
    DateTime? dateExpiration,
    String? statut,
    int? nombreCandidats,
    int? nombreCandidatures,
    List<String>? avantages,
    String? processusRecrutement,
    String? contactEmail,
    String? contactTelephone,
    String? entreprise,
    String? lieu,
    String? salaire,
    String? niveauExperience,
    bool? isActive,
  }) {
    return Offre(
      id: id ?? this.id,
      entrepriseId: entrepriseId ?? this.entrepriseId,
      titre: titre ?? this.titre,
      description: description ?? this.description,
      secteurActivite: secteurActivite ?? this.secteurActivite,
      competencesRequises: competencesRequises ?? this.competencesRequises,
      localisation: localisation ?? this.localisation,
      typeContrat: typeContrat ?? this.typeContrat,
      typeStage: typeStage ?? this.typeStage,
      dureeMois: dureeMois ?? this.dureeMois,
      salaireMin: salaireMin ?? this.salaireMin,
      salaireMax: salaireMax ?? this.salaireMax,
      niveauEtudes: niveauEtudes ?? this.niveauEtudes,
      experienceRequise: experienceRequise ?? this.experienceRequise,
      datePublication: datePublication ?? this.datePublication,
      dateExpiration: dateExpiration ?? this.dateExpiration,
      statut: statut ?? this.statut,
      nombreCandidats: nombreCandidats ?? this.nombreCandidats,
      nombreCandidatures: nombreCandidatures ?? this.nombreCandidatures,
      avantages: avantages ?? this.avantages,
      processusRecrutement: processusRecrutement ?? this.processusRecrutement,
      contactEmail: contactEmail ?? this.contactEmail,
      contactTelephone: contactTelephone ?? this.contactTelephone,
      entreprise: entreprise ?? this.entreprise,
      lieu: lieu ?? this.lieu,
      salaire: salaire ?? this.salaire,
      niveauExperience: niveauExperience ?? this.niveauExperience,
      isActive: isActive ?? this.isActive,
    );
  }
}
