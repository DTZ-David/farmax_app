class User {
  final String email;
  final String rol;
  final String id;

  User({required this.email, required this.rol, required this.id});

  factory User.desdeJson(Map<String, dynamic> json) {
    return User(
        email: json['email'] ?? '',
        rol: json['rol'] ?? '',
        id: json['id'] ?? '');
  }
  Map<String, dynamic> toJson() => {'email': email, 'rol': rol, 'id': id};
}
