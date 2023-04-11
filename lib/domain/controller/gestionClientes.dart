// ignore_for_file: file_names

import 'package:get/get.dart';
import '../models/cliente.dart';

class ClienteController extends GetxController {
  Rx<List<Cliente>> listaLocal = Rx<List<Cliente>>([]);
  final contador = 0.obs;

  @override
  void onInit() {
    listaLocal.value = listaClientes;
    super.onInit();
  }

  List<Cliente> get listapublica => listaLocal.value;
  int get total => contador.value;

  aumentar() {
    contador.value++;
  }
}
