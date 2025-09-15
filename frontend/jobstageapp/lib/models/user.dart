class User {
  final int id;
  final String username;
  final String email;
  final String userType;
  final bool isVerified;
  final DateTime dateJoined;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.userType,
    required this.isVerified,
    required this.dateJoined,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      userType: json['user_type'],
      isVerified: json['is_verified'],
      dateJoined: DateTime.parse(json['date_joined']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'user_type': userType,
      'is_verified': isVerified,
      'date_joined': dateJoined.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, userType: $userType)';
  }
}

