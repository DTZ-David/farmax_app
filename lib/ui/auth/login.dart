// ignore_for_file: unused_element, unused_field, prefer_final_fields

import 'package:farmax_app/domain/controller/controlUserFirebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/peticionUserFirebase.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controluser = TextEditingController();
  TextEditingController controlpass = TextEditingController();
  Peticioneslogin controlu = Get.find();
  bool _obscureText = true;
  late bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Column(children: <Widget>[
              const SizedBox(height: 40),
              Container(
                  margin: const EdgeInsets.all(17.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/logoww.png', scale: 2.5),
                      ])),
              SizedBox(
                width: 300,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                      controller: controluser,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.info),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Usuario',
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
                      obscureText: _obscureText,
                      controller: controlpass,
                      decoration: InputDecoration(
                          suffixIcon: togglePassword(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Contraseña',
                            style: TextStyle(color: Colors.grey),
                          ))),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "¿Aun no tienes cuenta?",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                height: 100,
                child: GestureDetector(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      margin: const EdgeInsets.all(14),
                      color: const Color.fromARGB(250, 6, 68, 108),
                      child: const Icon(
                        Icons.alternate_email,
                        color: Colors.white,
                        size: 40,
                      )),
                  onTap: () {
                    Get.offAllNamed('/registro');
                  },
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(250, 6, 68, 108)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(250, 6, 68, 108))))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text("Iniciar Sesion"),
                    ],
                  ),
                  onPressed: () => _login(context),
                ),
              ),
            ]),
          ]),
        ));
  }

  _login(BuildContext context) {
    ControlUserAuth controladorUser = Get.find();

    if (controlpass.text.isEmpty || controluser.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(250, 6, 68, 108),
          content: Text(
            'Por favor ingrese su usuario y contraseña para ingresar',
            style: TextStyle(color: Colors.white),
          )));
    } else {
      setState(() {
        controladorUser
            .ingresarUser(controluser.text, controlpass.text)
            .then((value) {
          if (controladorUser.userValido == null) {
            Get.snackbar("Usuarios", controladorUser.mensajesUser,
                duration: const Duration(seconds: 4),
                backgroundColor: Colors.red);
          } else {
            Get.snackbar("Usuarios", controladorUser.mensajesUser,
                duration: const Duration(seconds: 4),
                backgroundColor: Colors.green);
            Get.toNamed("/mainPage");
          }
        });
      });
    }
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: _obscureText
            ? const Icon(
                Icons.visibility,
                color: Colors.blue,
              )
            : const Icon(
                Icons.visibility_off,
                color: Colors.grey,
              ));
  }
}
