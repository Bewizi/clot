class AppUser {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String? gender;
  final int? age;
  final bool? isProfileComplete;

  AppUser({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.gender,
    this.age,
    this.isProfileComplete = false,
  });

  // Add copyWith method for easy updates
  AppUser copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? gender,
    int? age,
    bool? isProfileComplete,
  }) {
    return AppUser(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'gender': gender,
      'age': age,
      'isProfileComplete': isProfileComplete,
    };
  }

  // Create from Firestore document
  factory AppUser.fromMap(Map<String, dynamic> map, String id) {
    return AppUser(
      id: id,
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'],
      age: map['age'],
      isProfileComplete: map['isProfileComplete'] ?? false,
    );
  }
}
