// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'dart:async';

import 'package:farmax_app/data/services/peticionesTurnoFirebase.dart';
import 'package:farmax_app/domain/controller/gestionAsesor.dart';
import 'package:farmax_app/domain/controller/gestionTurnoFirebase.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

import '../../../domain/controller/gestionClientes.dart';
import '../../../domain/controller/gestionSedeFirebase.dart';

class HomePageCliente extends StatefulWidget {
  final String id;
  const HomePageCliente({super.key, required this.id});

  @override
  State<HomePageCliente> createState() => _HomePageClienteState();
}

List<String> nombres = [];
List<String> hora = [];
List<String> notas = [];
List<String> fotos = [];
List<String> fecha = [];
List<String> idNotas = [];
List<String> idSesion = [];
List<String> fotosFinalizado = [];
List<String> nombresFinalizado = [];
List<String> horasFinalizado = [];

class _HomePageClienteState extends State<HomePageCliente>
    with TickerProviderStateMixin {
  AsesorController asesorController = Get.find();
  SedeController sedeController = Get.find();
  ClienteController clienteController = Get.find();
  TurnoController turnoController = Get.find();

  @override
  Widget build(BuildContext context) {
    nombres = [];
    hora = [];
    fotos = [];
    notas = [];
    fecha = [];

    idNotas = [];
    fotosFinalizado = [];
    nombresFinalizado = [];
    horasFinalizado = [];
    asesorController.consultaAsesor().then((value) => null);
    sedeController.consultaSede().then((value) => null);
    clienteController.consultaCliente().then((value) => null);
    turnoController.consultaTurno().then((value) => null);
    void ModificarPendientesVencidos() {}
    final miTimer = Timer(const Duration(seconds: 3), () {
      for (var i = 0; i < turnoController.getTurnoGnral!.length; i++) {
        if (widget.id == turnoController.getTurnoGnral![i].idCliente) {
          for (var j = 0; j < clienteController.getClienteGnral!.length; j++) {
            if (clienteController.getClienteGnral![j].identificacion ==
                    turnoController.getTurnoGnral![i].idCliente &&
                turnoController.getTurnoGnral![i].estado == 'Pendiente') {
              nombres.add(clienteController.getClienteGnral![j].nombre);
              hora.add(turnoController.getTurnoGnral![i].hora);
              fecha.add(turnoController.getTurnoGnral![i].fecha);
              notas.add(turnoController.getTurnoGnral![i].descripcion);
              fotos.add(turnoController.getTurnoGnral![i].foto);
              idNotas.add(turnoController.getTurnoGnral![i].idTurno);
            }
            if (clienteController.getClienteGnral![j].identificacion ==
                    turnoController.getTurnoGnral![i].idCliente &&
                turnoController.getTurnoGnral![i].estado != "Pendiente") {
              nombresFinalizado
                  .add(clienteController.getClienteGnral![j].nombre);
              horasFinalizado.add(turnoController.getTurnoGnral![i].hora);

              fotosFinalizado.add(turnoController.getTurnoGnral![i].foto);
            }
          }
        }
      }
    });
    idNotas = [];

    void handleClick(String value) {
      switch (value) {
        case 'Cerrar Sesión':
          Get.offAllNamed("/login");
          break;
      }
    }

    TabController tabController = TabController(length: 2, vsync: this);
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Cerrar Sesión'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
              title: Padding(
                padding: const EdgeInsets.only(bottom: 0, top: 20),
                child: Image.asset(
                  "assets/images/logoww1.png",
                  height: 200,
                  width: 300,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: const Color.fromARGB(234, 6, 47, 86),
              elevation: 0.0,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(60.0),
                ),
              ),
              toolbarHeight: 60,
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: TabBar(
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          labelColor: Colors.black,
                          controller: tabController,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: CircleTabIndicator(
                              color: const Color.fromARGB(150, 6, 68, 108),
                              radius: 4),
                          tabs: const [
                            Tab(
                              text: 'Inicio Cliente',
                            ),
                            Tab(
                              text: 'Historial',
                            )
                          ]),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          CargarCards(),
                          CargarCards2(),
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}

class CargarCards2 extends StatelessWidget {
  const CargarCards2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return nombresFinalizado.isEmpty
        ? Center(
            child: LoadingAnimationWidget.threeRotatingDots(
            color: const Color.fromARGB(150, 6, 68, 108),
            size: 100,
          ))
        : ListView.builder(
            itemCount: nombresFinalizado.length,
            //scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                height: 180,
                width: 300,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: Stack(clipBehavior: Clip.none, children: [
                      Positioned(
                        top: -10,
                        left: -90,
                        child: Container(
                          margin: const EdgeInsets.only(left: 100, top: 10),
                          height: 100,
                          width: 100,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80)),
                            elevation: 2,
                            child:
                                Image.network(fotosFinalizado.elementAt(index)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 35,
                        child: Column(
                          children: [
                            const Text('FINALIZADA'),
                            const SizedBox(height: 10),
                            Text(
                              nombresFinalizado.elementAt(index),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              horasFinalizado.elementAt(index),
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ])),
              );
            },
          );
  }
}

class CargarCards extends StatefulWidget {
  const CargarCards({
    Key? key,
  }) : super(key: key);

  @override
  State<CargarCards> createState() => _CargarCardsState();
}

class _CargarCardsState extends State<CargarCards> {
  TextEditingController controladorNotas = TextEditingController();
  var selectedItem;
  var idSesion;

  @override
  Widget build(BuildContext context) {
    Future<void> _refresh() {
      return Future.delayed(const Duration(seconds: 3));
    }

    return nombres.isEmpty
        ? const Center(
            child: Text("No hay turnos para mostrar "),
          )
        : RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: nombres.length,
              //scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                    height: 260,
                    width: 300,
                    child: GestureDetector(
                      onLongPress: () {
                        //editarCard(context, "Notas...");
                        showDialog(
                            barrierColor:
                                const Color.fromARGB(175, 104, 104, 103),
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    "Editar Turno",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  content: Column(
                                    children: [
                                      Positioned(
                                        top: 200,
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 50),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                                hintText: "Estado del Turno",
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        36,
                                                                        0,
                                                                        167)))),
                                            value: selectedItem,
                                            dropdownColor: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            isExpanded: true,
                                            items: <String>[
                                              "Cancelar",
                                            ].map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            icon: const Icon(
                                                Icons.arrow_back_ios_new),
                                            elevation: 4,
                                            // underline: Container(
                                            // height: 2,
                                            //color:
                                            //  Color.fromARGB(255, 119, 94, 137),
                                            //  ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedItem = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.cancel,
                                            color: Colors.redAccent)),
                                    IconButton(
                                        onPressed: () {
                                          if (selectedItem != "Seleccione" &&
                                              selectedItem != null) {
                                            PeticionesTurno.actualizarEstado(
                                                idNotas.elementAt(index),
                                                selectedItem.toString());
                                          }
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.check,
                                            color: Colors.green)),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: Stack(clipBehavior: Clip.none, children: [
                            Positioned(
                              top: -50,
                              left: -50,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 100, top: 10),
                                height: 100,
                                width: 100,
                                child: GestureDetector(
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    elevation: 2,
                                    child:
                                        Image.network(fotos.elementAt(index)),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Formula'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      maxHeight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.8),
                                                  child: Image.network(
                                                    fotos.elementAt(index),
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.8, // ajustar el ancho según tu necesidad
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cerrar'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              right: 35,
                              child: Column(
                                children: [
                                  Text(
                                    fecha.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    hora.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    nombres.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 130,
                              left: 29,
                              child: Column(
                                children: [
                                  Text(
                                    notas.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    ));
              },
            ),
          );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
