class Sede {
  final String idSede;
  final String nombre;
  final List idAsesor;

  Sede({required this.idSede, required this.nombre, required this.idAsesor});

  factory Sede.desdeDoc(Map<String, dynamic> data) {
    return Sede(
      idSede: data['idSede'] ?? '',
      nombre: data['nombre'] ?? '',
      idAsesor: List.from(data['idAsesor'] ?? []),
    );
  }

  Map<String, dynamic> toJson() =>
      {'idSede': idSede, 'nombre': nombre, 'idAsesor': idAsesor};
}
