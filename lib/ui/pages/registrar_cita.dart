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
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: Colors.white,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "¡Agenda tú turno!",
                                style: TextStyle(
                                  color: Color.fromARGB(234, 6, 47, 86),
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Tipo de documento",
                                style: TextStyle(
                                  color: Color.fromARGB(234, 6, 47, 86),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.8,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 7),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                              const SizedBox(height: 20),
                              const Text(
                                "Numero Documento",
                                style: TextStyle(
                                  color: Color.fromARGB(234, 6, 47, 86),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.8,
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
                                                  width: 1, color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          label: const Text(
                                            'Numero Documento',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ))),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Telefono",
                                style: TextStyle(
                                  color: Color.fromARGB(234, 6, 47, 86),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.8,
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
                                                  width: 1, color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          label: const Text(
                                            'Telefono',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ))),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Sede",
                                style: TextStyle(
                                  color: Color.fromARGB(234, 6, 47, 86),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.8,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 7),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(250, 6, 68, 108)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                color: Color.fromARGB(
                                                    250, 6, 68, 108))))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text("Siguiente"),
                                  ],
                                ),
                                onPressed: () {
                                  Get.offAllNamed('/registrarCitaP2');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
              child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.assignment_turned_in,
                  size: 40,
                  color: Color.fromARGB(234, 6, 47, 86),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
