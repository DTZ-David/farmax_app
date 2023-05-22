// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../data/services/peticionesTurnoFirebase.dart';
import '../models/turno.dart';

class TurnoController extends GetxController {
  final Rxn<List<Turno>> _turnoFirestore = Rxn<List<Turno>>();

  Future<void> consultaAsesor() async {
    _turnoFirestore.value = await PeticionesTurno.consultarGral();
  }

  List<Turno>? get getAsesorGnral => _turnoFirestore.value;
}
