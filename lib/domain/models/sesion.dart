class Sesion {
  final String idSesion;
  final String idCliente;
  final String idAsesor;
  final String fecha;
  final String hora;
  final String estado;

  Sesion(
      {required this.idSesion,
      required this.idCliente,
      required this.idAsesor,
      required this.fecha,
      required this.hora,
      required this.estado});

  factory Sesion.desdeDoc(Map<String, dynamic> data) {
    return Sesion(
        idSesion: data['idSesion'] ?? '',
        idCliente: data['idPaciente'] ?? '',
        idAsesor: data['idPsicologo'] ?? '',
        fecha: data['fecha'] ?? '',
        hora: data['hora'] ?? '',
        estado: data['estado'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'idSesion': idSesion,
        'idCliente': idCliente,
        'idAsesor': idAsesor,
        'fecha': fecha,
        'hora': hora,
        'estado': estado
      };
}

Map<String, dynamic> sesion1 = {
  'idSesion': "1",
  'idCliente': "9909",
  'idAsesor': "123",
  'fecha': "14/03/23",
  'hora': "8.15 AM",
  'estado': "Pendiente"
};
List<Sesion> listadoSesiones = [Sesion.desdeDoc(sesion1)];
