// ignore_for_file: unnecessary_null_comparison

import 'package:farmax_app/domain/controller/gestionAsesor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrarCitaPagina2 extends StatefulWidget {
  const RegistrarCitaPagina2({super.key});

  @override
  State<RegistrarCitaPagina2> createState() => _RegistrarCitaPagina2State();
}

DateTime selectedDate = DateTime.now();

class _RegistrarCitaPagina2State extends State<RegistrarCitaPagina2> {
  String dropdownvalue = 'Seleccione...';

  void _mostrarVentanaEmergente(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Registrando Turno...'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  AsesorController asesorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/registrarCita");
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Elija un Asesor",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromARGB(234, 6, 47, 86),
              automaticallyImplyLeading: false,
              elevation: 0.0,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0)),
              )),
          body: Obx(
            () => asesorController.getAsesorGnral?.isEmpty == false
                ? Center(
                    child: SizedBox(
                      width: 400,
                      height: 500,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: asesorController.getAsesorGnral?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20, left: 20),
                              width: 300,
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 0,
                                        left: -10,
                                        child: Card(
                                          clipBehavior: Clip.hardEdge,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80)),
                                          elevation: 10,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 100.0,
                                                height: 100.0,
                                                color: Colors.white,
                                                child: Image.network(
                                                  asesorController
                                                      .getAsesorGnral![index]
                                                      .foto,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 60,
                                        left: 50,
                                        right: 0,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${asesorController.getAsesorGnral![index].nombre} ${asesorController.getAsesorGnral![index].apellido}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 130,
                                        left: 0,
                                        right: 200,
                                        child: Column(
                                          children: const [
                                            Text(
                                              "Fecha ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 160,
                                        left: 0,
                                        child: ElevatedButton.icon(
                                            style: OutlinedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1) //<-- SEE HERE
                                                ),
                                            icon: const Icon(
                                              Icons.calendar_month,
                                              color: Colors.black,
                                            ),
                                            onPressed: () =>
                                                _selectDate(context),
                                            label: Text(
                                              selectedDate == null
                                                  ? 'DD/MM/AAAA'
                                                  : DateFormat('dd/MM/yyyy')
                                                      .format(selectedDate),
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                        top: 220,
                                        left: -80,
                                        right: 0,
                                        child: Column(
                                          children: const [
                                            Text(
                                              "Horarios del Turno ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 260,
                                        left: 0,
                                        child: SizedBox(
                                          width: 200,
                                          height: 40,
                                          child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              dropdownColor: Colors.white,
                                              icon: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                ),
                                                child: const Icon(Icons
                                                    .arrow_downward_rounded),
                                              ),
                                              iconEnabledColor:
                                                  const Color.fromARGB(234, 57,
                                                      59, 61), //Icon color
                                              style: const TextStyle(
                                                  color:
                                                      Colors.grey, //Font color
                                                  fontSize: 20),
                                              iconSize: 25,
                                              isExpanded: true,
                                              items: asesorController
                                                  .getAsesorGnral![index]
                                                  .horario
                                                  .map((dynamic item) {
                                                String value = item.toString();
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                      Positioned(
                                          top: 360,
                                          left: 70,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        const Color.fromARGB(
                                                            250, 6, 68, 108)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18.0),
                                                        side: const BorderSide(color: Color.fromARGB(250, 6, 68, 108))))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const <Widget>[
                                                Text("Solicitar Turno"),
                                              ],
                                            ),
                                            onPressed: () {
                                              _mostrarVentanaEmergente(context);
                                              Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () {
                                                Get.offAllNamed('/mainPage');
                                              });
                                            },
                                          ))
                                    ],
                                  )),
                            );
                          }),
                    ),
                  )
                : const Center(child: Icon(Icons.charging_station)),
          )),
    );
  }
}
