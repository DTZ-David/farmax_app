import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrarCita extends StatefulWidget {
  const RegistrarCita({super.key});

  @override
  State<RegistrarCita> createState() => _RegistrarCitaState();
}

class _RegistrarCitaState extends State<RegistrarCita> {
  TextEditingController controlCed = TextEditingController();
  TextEditingController controlTel = TextEditingController();
  String dropdownvalue = 'Seleccione...';

  var items = ['C.C', 'T.I'];
  var items2 = ['San Martin', 'Novena'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
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
                      height: 540,
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
                                top: 10,
                                left: 80,
                                child: Text(
                                  "¡Agenda tú turno!",
                                  style: TextStyle(
                                      color: Color.fromARGB(234, 6, 47, 86),
                                      fontSize: 20),
                                ),
                              ),
                              const Positioned(
                                top: 80,
                                left: 20,
                                child: Text(
                                  "Tipo de documento",
                                  style: TextStyle(
                                      color: Color.fromARGB(234, 6, 47, 86),
                                      fontSize: 16),
                                ),
                              ),
                              Positioned(
                                top: 110,
                                left: 60,
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
                                            width: 1,
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
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      }),
                                ),
                              ),
                              const Positioned(
                                top: 170,
                                left: 20,
                                child: Text(
                                  "Numero Documento",
                                  style: TextStyle(
                                      color: Color.fromARGB(234, 6, 47, 86),
                                      fontSize: 16),
                                ),
                              ),
                              Positioned(
                                top: 200,
                                left: 60,
                                child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: PhysicalModel(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.white,
                                    elevation: 1.0,
                                    shadowColor: Colors.grey,
                                    child: TextFormField(
                                        controller: controlCed,
                                        decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding:
                                                const EdgeInsets.all(14),
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            label: const Text(
                                              'Numero Documento',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ))),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 260,
                                left: 20,
                                child: Text(
                                  "Telefono",
                                  style: TextStyle(
                                      color: Color.fromARGB(234, 6, 47, 86),
                                      fontSize: 16),
                                ),
                              ),
                              Positioned(
                                top: 290,
                                left: 60,
                                child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: PhysicalModel(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.white,
                                    elevation: 5.0,
                                    shadowColor: Colors.grey,
                                    child: TextFormField(
                                        controller: controlTel,
                                        decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding:
                                                const EdgeInsets.all(14),
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            label: const Text(
                                              'Telefono',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ))),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 350,
                                left: 20,
                                child: Text(
                                  "Sede",
                                  style: TextStyle(
                                      color: Color.fromARGB(234, 6, 47, 86),
                                      fontSize: 16),
                                ),
                              ),
                              Positioned(
                                top: 380,
                                left: 60,
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
                                            width: 1,
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
                                      items: items2.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
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
                                  top: 430,
                                  left:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          90,
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
                                                    BorderRadius.circular(18.0),
                                                side: const BorderSide(
                                                    color: Color.fromARGB(250, 6, 68, 108))))),
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
                    )
                  ],
                ),
              ))),
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
}
