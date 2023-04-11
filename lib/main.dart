import 'package:farmax_app/domain/controller/gestionAsesor.dart';
import 'package:farmax_app/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/controller/gestionClientes.dart';

void main() {
  Get.put(ClienteController());
  Get.put(AsesorController());
  runApp(const App());
}
