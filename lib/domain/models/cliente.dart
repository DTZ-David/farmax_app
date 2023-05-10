class Cliente {
  final String tipoId;
  final String identificacion;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;
  final String email;
  final String foto;

  Cliente(
      {required this.tipoId,
      required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.direccion,
      required this.telefono,
      required this.email,
      required this.foto});

  factory Cliente.crear(Map<String, dynamic> jsonMap) {
    return Cliente(
      tipoId: jsonMap['tipoId'] ?? '',
      identificacion: jsonMap['identificacion'] ?? '',
      nombre: jsonMap['nombre'] ?? '',
      apellido: jsonMap['apellido'] ?? '',
      direccion: jsonMap['direccion'] ?? '',
      email: jsonMap['email'] ?? '',
      telefono: jsonMap['telefono'] ?? '',
      foto: jsonMap['foto'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'tipoId': tipoId,
        'identificacion': identificacion,
        'nombre': nombre,
        'apellido': apellido,
        'direccion': direccion,
        'email': email,
        'telefono': telefono,
        'foto': foto,
      };
}

Map<String, dynamic> cli2 = {
  "identificacion": "9909",
  "nombre": "Hector",
  "apellido": "David",
  "foto": "https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg"
};

List<Cliente> listaClientes = [Cliente.crear(cli2)];
