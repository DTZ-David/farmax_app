// ignore_for_file: file_names

import 'package:farmax_app/data/services/peticionesCliente.dart';
import 'package:farmax_app/domain/models/cliente.dart';
import 'package:get/get.dart';

class ClienteController extends GetxController {
  final Rxn<List<Cliente>> _asesorFirestore = Rxn<List<Cliente>>();

  Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    await PeticionesCliente.crearCliente(catalogo, foto);
  }

  Future<void> consultaCliente() async {
    _asesorFirestore.value = await PeticionesCliente.consultarGral();
  }

  List<Cliente>? get getClienteGnral => _asesorFirestore.value;
}
