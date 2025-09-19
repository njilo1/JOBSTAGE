class Candidature {
  final String id;
  final String candidatId;
  final String offreId;
  final String cvPath;
  final String lettreMotivationPath;
  final DateTime dateCandidature;
  final String statut; // 'envoyee', 'vue', 'preselectionnee', 'rejetee', 'acceptee'
  final String messageRecruteur;
  final DateTime? dateVue;
  final DateTime? dateReponse;
  final double scoreMatching;
  final Map<String, dynamic> metadonnees;

  Candidature({
    required this.id,
    required this.candidatId,
    required this.offreId,
    required this.cvPath,
    required this.lettreMotivationPath,
    required this.dateCandidature,
    this.statut = 'envoyee',
    this.messageRecruteur = '',
    this.dateVue,
    this.dateReponse,
    this.scoreMatching = 0.0,
    this.metadonnees = const {},
  });

  factory Candidature.fromJson(Map<String, dynamic> json) {
    return Candidature(
      id: json['id'],
      candidatId: json['candidat_id'],
      offreId: json['offre_id'],
      cvPath: json['cv_path'],
      lettreMotivationPath: json['lettre_motivation_path'],
      dateCandidature: DateTime.parse(json['date_candidature']),
      statut: json['statut'] ?? 'envoyee',
      messageRecruteur: json['message_recruteur'] ?? '',
      dateVue: json['date_vue'] != null ? DateTime.parse(json['date_vue']) : null,
      dateReponse: json['date_reponse'] != null ? DateTime.parse(json['date_reponse']) : null,
      scoreMatching: (json['score_matching'] ?? 0.0).toDouble(),
      metadonnees: Map<String, dynamic>.from(json['metadonnees'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'candidat_id': candidatId,
      'offre_id': offreId,
      'cv_path': cvPath,
      'lettre_motivation_path': lettreMotivationPath,
      'date_candidature': dateCandidature.toIso8601String(),
      'statut': statut,
      'message_recruteur': messageRecruteur,
      'date_vue': dateVue?.toIso8601String(),
      'date_reponse': dateReponse?.toIso8601String(),
      'score_matching': scoreMatching,
      'metadonnees': metadonnees,
    };
  }

  bool get isNouvelle => statut == 'envoyee';
  bool get isVue => statut == 'vue';
  bool get isPreselectionnee => statut == 'preselectionnee';
  bool get isRejetee => statut == 'rejetee';
  bool get isAcceptee => statut == 'acceptee';

  String get statutAffichage {
    switch (statut) {
      case 'envoyee':
        return 'Nouvelle';
      case 'vue':
        return 'Vue';
      case 'preselectionnee':
        return 'Présélectionnée';
      case 'rejetee':
        return 'Rejetée';
      case 'acceptee':
        return 'Acceptée';
      default:
        return 'Inconnu';
    }
  }

  Candidature copyWith({
    String? id,
    String? candidatId,
    String? offreId,
    String? cvPath,
    String? lettreMotivationPath,
    DateTime? dateCandidature,
    String? statut,
    String? messageRecruteur,
    DateTime? dateVue,
    DateTime? dateReponse,
    double? scoreMatching,
    Map<String, dynamic>? metadonnees,
  }) {
    return Candidature(
      id: id ?? this.id,
      candidatId: candidatId ?? this.candidatId,
      offreId: offreId ?? this.offreId,
      cvPath: cvPath ?? this.cvPath,
      lettreMotivationPath: lettreMotivationPath ?? this.lettreMotivationPath,
      dateCandidature: dateCandidature ?? this.dateCandidature,
      statut: statut ?? this.statut,
      messageRecruteur: messageRecruteur ?? this.messageRecruteur,
      dateVue: dateVue ?? this.dateVue,
      dateReponse: dateReponse ?? this.dateReponse,
      scoreMatching: scoreMatching ?? this.scoreMatching,
      metadonnees: metadonnees ?? this.metadonnees,
    );
  }
}
