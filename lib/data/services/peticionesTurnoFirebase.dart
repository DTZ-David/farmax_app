// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/turno.dart';

class PeticionesTurno {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearTurno(Map<String, dynamic> catalogo, foto) async {
    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, catalogo['idTurno']);
    }

    catalogo['foto'] = url.toString();

    await _db
        .collection('Turno')
        .doc(catalogo['idTurno'])
        .set(catalogo)
        .catchError((e) {});
    //return true;
  }

  Future createUser(Turno turno, foto) async {
    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, turno.idTurno);
    }
    final docUser =
        FirebaseFirestore.instance.collection("Turno").doc(turno.idTurno);

    final json = turno.toJson();
    await docUser.set(json);
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Turnos");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<void> actualizarArticulo(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('Turno').doc(id).update(catalogo).catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('Turno').doc(id).delete().catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<List<Turno>> consultarGral() async {
    List<Turno> lista = [];

    QuerySnapshot<Map<String, dynamic>> respuesta =
        await _db.collection("Turno").get();

    for (var doc in respuesta.docs) {
      log(doc.data().toString());
      Turno turno = Turno.desdeDoc(doc.data());
      lista.add(turno);
    }

    return lista;
  }

  static Future<List<Turno>> consultarGralUsuarios(String id) async {
    List<Turno> lista = [];
    await _db.collection("Turno").get().then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(Turno.desdeDoc(doc.data()));
      }
    });

    return lista;
  }
}
