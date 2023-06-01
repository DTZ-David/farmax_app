// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, file_names

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmax_app/domain/models/sede.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PeticionesSede {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearSede(Map<String, dynamic> sede) async {
    await _db.collection('Sedes').doc().set(sede).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<List<Sede>> consultarGral() async {
    List<Sede> lista = [];

    QuerySnapshot<Map<String, dynamic>> respuesta =
        await _db.collection("Sedes").get();

    for (var doc in respuesta.docs) {
      log(doc.data().toString());
      Sede sede = Sede.desdeDoc(doc.data());
      lista.add(sede);
    }

    return lista;
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Sedes");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<void> actualizarcatalogo(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('id').doc(id).update(catalogo).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('id').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
