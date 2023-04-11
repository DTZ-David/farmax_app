class Cliente {
  final String identificacion;
  final String nombre;
  final String apellido;
  final String foto;

  Cliente(
      {required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.foto});

  factory Cliente.crear(Map<String, dynamic> jsonMap) {
    return Cliente(
      identificacion: jsonMap['identificacion'] ?? '',
      nombre: jsonMap['nombre'] ?? '',
      apellido: jsonMap['apellido'] ?? '',
      foto: jsonMap['foto'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'identificacion': identificacion,
        'nombre': nombre,
        'apellido': apellido,
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
