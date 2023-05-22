// ignore_for_file: file_names

import 'package:farmax_app/domain/models/asesor.dart';
import 'package:get/get.dart';
import '../../data/services/peticionesAsesorFirebase.dart';

class AsesorController extends GetxController {
  final Rxn<List<Asesor>> _asesorFirestore = Rxn<List<Asesor>>();

  Future<void> consultaAsesor() async {
    _asesorFirestore.value = await PeticionesAsesor.consultarGral();
  }

  List<Asesor>? get getAsesorGnral => _asesorFirestore.value;
}
