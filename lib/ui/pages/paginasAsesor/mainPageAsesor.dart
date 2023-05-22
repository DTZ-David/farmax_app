// ignore_for_file: file_names

import 'package:farmax_app/ui/pages/paginasAsesor/homeAsesor.dart';
import 'package:farmax_app/ui/pages/paginasCliente/registrar_cita.dart';
import 'package:flutter/material.dart';

class MainPageAsesor extends StatefulWidget {
  final String id;
  const MainPageAsesor({super.key, required this.id});

  @override
  State<MainPageAsesor> createState() => _MainPageAsesorState();
}

class _MainPageAsesorState extends State<MainPageAsesor> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [const HomePageAsesor(), RegistrarCita(id: widget.id)];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.shifting,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: const Color.fromARGB(250, 6, 68, 108),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle), label: 'AddAppointment'),
          ]),
    );
  }
}
