class Turno {
  final String idTurno;
  final String idCliente;
  final String idAsesor;
  final String fecha;
  final String hora;
  final String estado;

  Turno(
      {required this.idTurno,
      required this.idCliente,
      required this.idAsesor,
      required this.fecha,
      required this.hora,
      required this.estado});

  factory Turno.desdeDoc(Map<String, dynamic> data) {
    return Turno(
        idTurno: data['idTurno'] ?? '',
        idCliente: data['idPaciente'] ?? '',
        idAsesor: data['idPsicologo'] ?? '',
        fecha: data['fecha'] ?? '',
        hora: data['hora'] ?? '',
        estado: data['estado'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'idTurno': idTurno,
        'idCliente': idCliente,
        'idAsesor': idAsesor,
        'fecha': fecha,
        'hora': hora,
        'estado': estado
      };
}

Map<String, dynamic> sesion1 = {
  'idTurno': "1",
  'idCliente': "9909",
  'idAsesor': "123",
  'fecha': "14/03/23",
  'hora': "8.15 AM",
  'estado': "Pendiente"
};
List<Turno> listadoSesiones = [Turno.desdeDoc(sesion1)];
