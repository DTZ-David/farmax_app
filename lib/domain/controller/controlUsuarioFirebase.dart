// ignore_for_file: file_names

import 'package:farmax_app/domain/models/usuario.dart';
import 'package:get/get.dart';
import '../../data/services/peticionesUsuarioFirebase.dart';

class UsuarioController extends GetxController {
  final Rxn<List<User>> _usuarioFirestore = Rxn<List<User>>();

  Future<void> consultaUsuario() async {
    _usuarioFirestore.value = await PeticionesUser.consultarGral();
  }

  Future<void> crearcatalogo(Map<String, dynamic> catalogo) async {
    await PeticionesUser.crearAsesor(catalogo);
  }

  List<User>? get getUsuarioGral => _usuarioFirestore.value;
}
