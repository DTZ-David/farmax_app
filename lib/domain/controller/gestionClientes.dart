// ignore_for_file: file_names

import 'package:farmax_app/data/services/peticionesCliente.dart';
import 'package:get/get.dart';

class ControlUserPerfil extends GetxController {
  Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    await PeticionesCliente.crearCliente(catalogo, foto);
  }
}
