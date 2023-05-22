// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/controller/gestionSedeFirebase.dart';

class RegistrarCita extends StatefulWidget {
  final String id;
  const RegistrarCita({super.key, required this.id});

  @override
  State<RegistrarCita> createState() => _RegistrarCitaState();
}

class _RegistrarCitaState extends State<RegistrarCita> {
  var _image;
  ImagePicker picker = ImagePicker();
  TextEditingController controlCed = TextEditingController();
  TextEditingController controlTel = TextEditingController();
  String dropdownvalue = 'Seleccione...';
  SedeController sedeController = Get.find();
  var items = ['C.C', 'T.I'];

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
    sedeController.consultaSede().then((value) => null);
    List<String> nombres = [];
    void obtenerNombresDesdeFirestore() {
      for (var i = 0; i < sedeController.getAsesorGnral!.length; i++) {
        nombres.add(sedeController.getAsesorGnral![i].nombre);
      }
    }

    List<DropdownMenuItem<String>> generarDropdownItems() {
      obtenerNombresDesdeFirestore();
      return nombres.map((nombre) {
        return DropdownMenuItem<String>(
          value: nombre,
          child: Text(nombre),
        );
      }).toList();
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          WillPopScope(
            onWillPop: () async {
              Get.offAllNamed("/mainPageCliente");
              return false;
            },
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: const Size(80, 80),
                  child: AppBar(
                      backgroundColor: const Color.fromARGB(234, 6, 47, 86),
                      automaticallyImplyLeading: false,
                      elevation: 0.0,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.0),
                            bottomRight: Radius.circular(60.0)),
                      )),
                ),
                body: SingleChildScrollView(
                    child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 520,
                        width: 330,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Colors.white,
                            child: Stack(
                              children: [
                                const Positioned(
                                  top: 40,
                                  left: 70,
                                  child: Text(
                                    "¡Agenda tú turno!",
                                    style: TextStyle(
                                        color: Color.fromARGB(234, 6, 47, 86),
                                        fontSize: 20),
                                  ),
                                ),
                                const Positioned(
                                    top: 100,
                                    left: 80,
                                    child: Text(
                                      "¡Sube tu Formula!",
                                      style: TextStyle(
                                          color: Color.fromARGB(234, 6, 47, 86),
                                          fontSize: 16),
                                    )),
                                Positioned(
                                  top: 120,
                                  left: 100,
                                  child: GestureDetector(
                                    onTap: () async {
                                      _opcioncamara(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                      child: _image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(48),
                                              child: Image.file(
                                                _image,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    234, 6, 47, 86),
                                                borderRadius:
                                                    BorderRadius.circular(48),
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
                                ),
                                const Positioned(
                                  top: 260,
                                  left: 70,
                                  child: Text(
                                    "Selecciona la sede",
                                    style: TextStyle(
                                        color: Color.fromARGB(234, 6, 47, 86),
                                        fontSize: 18),
                                  ),
                                ),
                                Positioned(
                                  top: 300,
                                  left: 45,
                                  child: SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 7),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      dropdownColor: Colors.white,
                                      icon: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                color: Colors.grey, width: 1),
                                          ),
                                        ),
                                        child: const Icon(
                                            Icons.arrow_downward_rounded),
                                      ),
                                      iconEnabledColor: const Color.fromARGB(
                                          234, 57, 59, 61), //Icon color
                                      style: const TextStyle(
                                          color: Colors.grey, //Font color
                                          fontSize: 20),
                                      iconSize: 25,
                                      isExpanded: true,
                                      items: generarDropdownItems(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 380,
                                    left: MediaQuery.of(context).size.width *
                                            0.5 -
                                        85,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromARGB(
                                                      250, 6, 68, 108)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: const BorderSide(
                                                      color:
                                                          Color.fromARGB(250, 6, 68, 108))))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const <Widget>[
                                          Text("Siguiente"),
                                        ],
                                      ),
                                      onPressed: () {
                                        Get.offAllNamed('/registrarCitaP2');
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.025, // 20% desde arriba
            left: MediaQuery.of(context).size.width * 0.5 -
                50, // centrado horizontalmente
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(
                  height: 60,
                  child: Icon(
                    Icons.assignment_turned_in,
                    size: 60,
                    color: Color.fromARGB(234, 6, 47, 86),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
}
