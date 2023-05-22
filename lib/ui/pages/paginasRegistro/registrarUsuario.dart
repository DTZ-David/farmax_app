// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unused_import, unused_local_variable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmax_app/data/services/peticionesCliente.dart';
import 'package:farmax_app/domain/controller/gestionClientes.dart';
import 'package:farmax_app/domain/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/peticionUserFirebase.dart';
import '../../../domain/controller/controlUserFirebase.dart';
import '../../../domain/controller/controlUsuarioFirebase.dart';
import '../../../domain/models/usuario.dart';

class RegisterStepper extends StatefulWidget {
  final String user;
  final String password;
  const RegisterStepper(this.user, this.password, {super.key});

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  var _image;
  ImagePicker picker = ImagePicker();

  DateTime date = DateTime.now();
  var items = ['C.C', 'T.I'];
  String? selectedItem = 'C.C';
  int currentStep = 0;
  String tipoId = "C.C";
  TextEditingController controlidentificacion = TextEditingController();
  TextEditingController controlnombre = TextEditingController();
  TextEditingController controlapellido = TextEditingController();
  TextEditingController controldireccion = TextEditingController();
  TextEditingController controlemail = TextEditingController();
  TextEditingController controlnumero = TextEditingController();

  ControlUserAuth controlu = Get.find();
  ControlUserPerfil controlUserPerfil = Get.find();
  UsuarioController controlUsuario = Get.find();

  _camGaleria(bool op) async {
    XFile? image;
    image = op
        ? await picker.pickImage(source: ImageSource.camera, imageQuality: 50)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Registro'),
          backgroundColor: const Color.fromARGB(250, 6, 68, 108),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(250, 6, 68, 108))),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                var cliente = <String, dynamic>{
                  "tipoId": tipoId,
                  "identificacion": controlidentificacion.text,
                  "nombre": controlnombre.text,
                  "apellido": controlapellido.text,
                  "direccion": controldireccion.text,
                  "email": widget.user,
                  "telefono": controlnumero.text,
                  "foto": ''
                };
                var user = <String, dynamic>{
                  'email': widget.user,
                  'password': widget.password,
                  'rol': 'Cliente',
                  'id': controlidentificacion.text
                };
                controlUserPerfil.crearcatalogo(cliente, _image);
                controlUsuario.crearcatalogo(user);
                controlu.crearUser(widget.user, widget.password).then((value) {
                  if (controlu.userValido == null) {
                    Get.snackbar("Usuarios", controlu.mensajesUser,
                        duration: const Duration(seconds: 4),
                        backgroundColor: Colors.red);
                  } else {
                    Get.snackbar("Usuarios", controlu.mensajesUser,
                        duration: const Duration(seconds: 4),
                        backgroundColor: Colors.green);
                    Get.offAllNamed("/mainPageCliente");
                  }
                });
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep = step),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(width: 20),
                      if (currentStep != 0)
                        Container(
                          width: 100,
                          height: 40,
                          margin: const EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Atras'),
                          ),
                        ),
                      Container(
                        width: 100,
                        height: 40,
                        margin: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(isLastStep ? 'Enviar' : 'Siguiente'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Datos'),
          content: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _opcioncamara(context);
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                child: Image.file(
                                  _image,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(234, 6, 47, 86),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                                width: 60,
                                height: 60,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black))),
                value: selectedItem,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                    tipoId = selectedItem as String;
                  });
                  tipoId = selectedItem as String;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                      obscureText: false,
                      controller: controlidentificacion,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.dvr),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Identificacion',
                            style: TextStyle(color: Colors.grey),
                          ))),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                      obscureText: false,
                      controller: controlnombre,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Nombre',
                            style: TextStyle(color: Colors.grey),
                          ))),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                      obscureText: false,
                      controller: controlapellido,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Apellido',
                            style: TextStyle(color: Colors.grey),
                          ))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text('Direccion'),
          content: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                      obscureText: false,
                      controller: controldireccion,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.assistant_navigation),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Direccion',
                            style: TextStyle(color: Colors.grey),
                          ))),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('Contacto'),
          content: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                      obscureText: false,
                      controller: controlnumero,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.call),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(14),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0)),
                          label: const Text(
                            'Numero',
                            style: TextStyle(color: Colors.grey),
                          ))),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        )
      ];
  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Imagen de Galeria'),
                    onTap: () {
                      _camGaleria(false);
                      Get.back();
                      // Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Capturar Imagen'),
                  onTap: () {
                    _camGaleria(true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future createUser(Cliente cliente, foto) async {
    var url = '';
    if (foto != null) {
      url = await PeticionesCliente.cargarfoto(foto, cliente.identificacion);
    }
    final docUser = FirebaseFirestore.instance
        .collection("Clientes")
        .doc(cliente.identificacion);

    final json = cliente.toJson();
    json['foto'] = url.toString();
    await docUser.set(json);
  }
}
