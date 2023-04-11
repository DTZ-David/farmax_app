class User {
  final String email;
  final String password;
  final String rol;
  final String id;

  User(
      {required this.email,
      required this.password,
      required this.rol,
      required this.id});

  factory User.desdeJson(Map<String, dynamic> json) {
    return User(
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        rol: json['rol'] ?? '',
        id: json['id'] ?? '');
  }
  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'rol': rol, 'id': id};
}

Map<String, dynamic> user1 = {
  'email': "estefani",
  'password': "password",
  'rol': "Asesor",
  'id': "123"
};
Map<String, dynamic> user2 = {
  'email': "hector",
  'password': "password",
  'rol': "Cliente",
  'id': "9909"
};

List<User> listadoUsuarios = [User.desdeJson(user1), User.desdeJson(user2)];
