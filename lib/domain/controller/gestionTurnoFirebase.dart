// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../data/services/peticionesTurnoFirebase.dart';
import '../models/turno.dart';

class TurnoController extends GetxController {
  final Rxn<List<Turno>> _turnoFirestore = Rxn<List<Turno>>();

  Future<void> consultaTurno() async {
    _turnoFirestore.value = await PeticionesTurno.consultarGral();
  }

  Future<void> crearTurno(Map<String, dynamic> catalogo, foto) async {
    await PeticionesTurno.crearTurno(catalogo, foto);
  }

  List<Turno>? get getTurnoGnral => _turnoFirestore.value;
}
