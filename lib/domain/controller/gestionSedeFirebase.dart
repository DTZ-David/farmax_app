// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../data/services/peticionesSedeFirebase.dart';
import '../models/sede.dart';

class SedeController extends GetxController {
  final Rxn<List<Sede>> _sedeFirestore = Rxn<List<Sede>>();

  Future<void> consultaSede() async {
    _sedeFirestore.value = await PeticionesSede.consultarGral();
  }

  List<Sede>? get getAsesorGnral => _sedeFirestore.value;
}
