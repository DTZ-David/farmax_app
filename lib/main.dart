import 'package:farmax_app/data/services/peticionUserFirebase.dart';
import 'package:farmax_app/domain/controller/controlUserFirebase.dart';
import 'package:farmax_app/domain/controller/gestionAsesor.dart';
import 'package:farmax_app/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/controller/gestionClientes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ClienteController());
  Get.put(AsesorController());
  Get.put(ControlUserAuth());
  Get.put(Peticioneslogin());
  runApp(const App());
}
