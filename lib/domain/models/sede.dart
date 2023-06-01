class Sede {
  final String id;
  final String nombre;
  final List idAsesor;

  Sede({required this.id, required this.nombre, required this.idAsesor});

  factory Sede.desdeDoc(Map<String, dynamic> data) {
    return Sede(
      id: data['id'] ?? '',
      nombre: data['nombre'] ?? '',
      idAsesor: List.from(data['idAsesor'] ?? []),
    );
  }

  Map<String, dynamic> toJson() =>
      {'idSede': id, 'nombre': nombre, 'idAsesor': idAsesor};
}
