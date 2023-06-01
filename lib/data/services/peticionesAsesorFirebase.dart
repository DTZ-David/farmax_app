// ignore_for_file: unused_local_variable, file_names

import 'dart:developer';
import 'package:farmax_app/domain/models/asesor.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';

class PeticionesAsesor {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearAsesor(Map<String, dynamic> catalogo, foto) async {
    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, catalogo['identificacion']);
    }

    catalogo['foto'] = url.toString();

    await _db
        .collection('Asesor')
        .doc(catalogo['apellido'])
        .set(catalogo)
        .catchError((e) {});
    //return true;
  }

  Future createUser(Asesor asesor, foto) async {
    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, asesor.id);
    }
    final docUser =
        FirebaseFirestore.instance.collection("Asesor").doc(asesor.id);

    final json = asesor.toJson();
    await docUser.set(json);
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Asesor");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();

    return url.toString();
  }

  static Future<void> actualizarArticulo(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('Asesor').doc(id).update(catalogo).catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('Asesor').doc(id).delete().catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<List<Asesor>> consultarGral() async {
    List<Asesor> lista = [];

    QuerySnapshot<Map<String, dynamic>> respuesta =
        await _db.collection("Asesor").get();

    for (var doc in respuesta.docs) {
      log(doc.data().toString());
      Asesor asesor = Asesor.crear(doc.data());
      lista.add(asesor);
    }

    return lista;
  }

  static Future<List<Asesor>> consultarGralUsuarios(String id) async {
    List<Asesor> lista = [];
    await _db.collection("Asesor").get().then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(Asesor.crear(doc.data()));
      }
    });

    return lista;
  }
}
