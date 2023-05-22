import 'package:farmax_app/ui/auth/login.dart';
import 'package:farmax_app/ui/pages/paginasAsesor/mainPageAsesor.dart';
import 'package:farmax_app/ui/pages/paginasCliente/main_pageCliente.dart';
import 'package:farmax_app/ui/pages/paginasRegistro/registro.dart';
import 'package:farmax_app/ui/pages/paginasCliente/registrar_cita.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Far Max',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(150, 6, 68, 108),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromARGB(150, 6, 68, 108))),
      routes: {
        '/login': (context) => const Login(),
        '/registro': (context) => const Registro(),
        '/mainPageCliente': (context) => const MainPageCliente(id: ''),
        '/mainPageAsesor': (context) => const MainPageAsesor(id: ''),
        '/registrarCita': (context) => const RegistrarCita(id: '')
      },
      home: const Login(),
    );
  }
}
