class UserModel {
  UserModel({
    required this.name,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.nationality,
    required this.role,
    required this.pictureUrl
  });

  final String name;
  final String lastName;
  final String email;
  final String gender;
  final String birthDate;
  final String nationality;
  final String role;
  final String pictureUrl;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'nationality': nationality,
      'role' : role,
      'pictureUrl' : pictureUrl
    };
  }
}
