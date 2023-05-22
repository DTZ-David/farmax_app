class Turno {
  final String idTurno;
  final String idCliente;
  final String idAsesor;
  final String fecha;
  final String hora;
  final String estado;
  final String foto;

  Turno(
      {required this.idTurno,
      required this.idCliente,
      required this.idAsesor,
      required this.fecha,
      required this.hora,
      required this.estado,
      required this.foto});

  factory Turno.desdeDoc(Map<String, dynamic> data) {
    return Turno(
        idTurno: data['idTurno'] ?? '',
        idCliente: data['idCliente'] ?? '',
        idAsesor: data['idAsesor'] ?? '',
        fecha: data['fecha'] ?? '',
        hora: data['hora'] ?? '',
        estado: data['estado'] ?? '',
        foto: data['foto'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'idTurno': idTurno,
        'idCliente': idCliente,
        'idAsesor': idAsesor,
        'fecha': fecha,
        'hora': hora,
        'estado': estado,
        'foto': foto
      };
}
