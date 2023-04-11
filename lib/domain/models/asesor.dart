class Asesor {
  final String identificacion;
  final String nombre;
  final String apellido;
  final List<String> horario;
  final String foto;

  Asesor(
      {required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.horario,
      required this.foto});

  factory Asesor.crear(Map<String, dynamic> data) {
    return Asesor(
      identificacion: data['identificacion'] ?? '',
      nombre: data['nombre'] ?? '',
      apellido: data['apellido'] ?? '',
      horario: data['horario'] ?? '',
      foto: data['foto'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'identificacion': identificacion,
        'nombre': nombre,
        'apellido': apellido,
        'horario': horario,
        'foto': foto,
      };
}

Map<String, dynamic> asesor1 = {
  'identificacion': "123",
  'nombre': "Estefani",
  'apellido': "Rojas",
  'horario': ["8:00 AM", "8:15 AM", "8:30 AM"],
  'foto':
      "https://magazine.caser.es/wp-content/uploads/2020/10/Asesores-comerciales-825x483.jpg",
};

Map<String, dynamic> asesor2 = {
  'identificacion': "234",
  'nombre': "Estefani",
  'apellido': "Rojas",
  'horario': ["8:00 AM", "8:15 AM", "8:30 AM"],
  'foto':
      "https://magazine.caser.es/wp-content/uploads/2020/10/Asesores-comerciales-825x483.jpg",
};
List<Asesor> listaAsesores = [Asesor.crear(asesor1), Asesor.crear(asesor2)];
