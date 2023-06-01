class Asesor {
  final String id;
  final String nombre;
  final String apellido;
  final List horario;
  final String foto;
  final String idSede;

  Asesor(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.horario,
      required this.foto,
      required this.idSede});

  factory Asesor.crear(Map<String, dynamic> data) {
    return Asesor(
        id: data['id'] ?? '',
        nombre: data['nombre'] ?? '',
        apellido: data['apellido'] ?? '',
        horario: data['horario'] ?? '',
        foto: data['foto'] ?? '',
        idSede: data['idSede'] ?? '');
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'horario': horario,
        'foto': foto,
        'idSede': idSede
      };
}
