class User {
  final int id;
  final String username;
  final String email;
  final String role;
  final String password;

  User({required this.id, required this.username, required this.email, required this.role, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'password': password,
    };
  }
}