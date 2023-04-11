// ignore_for_file: file_names

import 'package:get/get.dart';
import '../models/asesor.dart';

class AsesorController extends GetxController {
  Rx<List<Asesor>> listaLocal = Rx<List<Asesor>>([]);
  final contador = 0.obs;

  @override
  void onInit() {
    listaLocal.value = listaAsesores;
    super.onInit();
  }

  List<Asesor> get listapublica => listaLocal.value;
  int get total => contador.value;

  aumentar() {
    contador.value++;
  }
}
