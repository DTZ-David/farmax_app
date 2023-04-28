// ignore_for_file: prefer_final_fields

import 'package:farmax_app/ui/pages/paginasRegistro/registrarUsuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController controluser = TextEditingController();
  TextEditingController controlpassw = TextEditingController();

  late bool _loading = false;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await showMyDialog();
          return shouldPop ?? false;
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 400,
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(250, 6, 68, 108),
                    ),
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(height: 100),
                        SizedBox(
                          width: 300,
                          child: PhysicalModel(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.white,
                            elevation: 5.0,
                            shadowColor: Colors.grey,
                            child: TextFormField(
                                obscureText: false,
                                controller: controluser,
                                decoration: InputDecoration(
                                    suffixIcon:
                                        const Icon(Icons.alternate_email),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.all(14),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    label: const Text(
                                      'Email',
                                      style: TextStyle(color: Colors.grey),
                                    ))),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 300,
                          child: PhysicalModel(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.white,
                            elevation: 5.0,
                            shadowColor: Colors.grey,
                            child: TextFormField(
                                obscureText: true,
                                controller: controlpassw,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                        Icons.remove_red_eye_outlined),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.all(14),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    label: const Text(
                                      'Contraseña',
                                      style: TextStyle(color: Colors.grey),
                                    ))),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(250, 6, 68, 108)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              250, 6, 68, 108))))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Registrate"),
                              if (_loading)
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(left: 20),
                                  child:
                                      LoadingAnimationWidget.threeRotatingDots(
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                )
                            ],
                          ),
                          onPressed: () => _registro(context),
                        ),
                        const SizedBox(height: 40)
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                  top: 260,
                  left: 100,
                  child: Text(
                    'Bienvenido a FarMax',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(250, 6, 68, 108),
                      fontSize: 16,
                    ),
                  )),
              Positioned(
                top: 140,
                left: 130,
                width: 100,
                height: 100,
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
            ],
          ),
        )),
      );

  _registro(BuildContext context) {
    if (!_loading) {
      if (controluser.text.isEmpty || controlpassw.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(250, 6, 68, 108),
            content: Text(
              'Por favor ingrese su usuario y contraseña para ingresar',
              style: TextStyle(color: Colors.white),
            )));
      } else {
        setState(() {
          //_loading = true;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisterStepper(controluser.text, controlpassw.text)));
        });
      }
    }
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Quieres volver al inicio de sesión?'),
          actions: [
            TextButton(
                child: const Text('No'),
                onPressed: () => Navigator.pop(context, false)),
            TextButton(
              child: const Text('Si'),
              onPressed: () => Get.offAllNamed('/login'),
            )
          ],
        ),
      );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
