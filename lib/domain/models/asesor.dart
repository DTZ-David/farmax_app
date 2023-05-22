class Asesor {
  final String identificacion;
  final String nombre;
  final String apellido;
  final List horario;
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
