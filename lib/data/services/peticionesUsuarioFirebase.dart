// ignore_for_file: file_names, unused_local_variable

import 'dart:developer';
import 'package:farmax_app/domain/models/usuario.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';

class PeticionesUser {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearAsesor(Map<String, dynamic> catalogo) async {
    await _db
        .collection('Usuarios')
        .doc(catalogo['email'])
        .set(catalogo)
        .catchError((e) {});
    //return true;
  }

  Future createUser(User usuario, foto) async {
    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, usuario.email);
    }
    final docUser =
        FirebaseFirestore.instance.collection("Usuarios").doc(usuario.email);

    final json = usuario.toJson();
    await docUser.set(json);
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Usuarios");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();

    return url.toString();
  }

  static Future<void> actualizarArticulo(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('Usuarios').doc(id).update(catalogo).catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('Usuarios').doc(id).delete().catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<List<User>> consultarGral() async {
    List<User> lista = [];

    QuerySnapshot<Map<String, dynamic>> respuesta =
        await _db.collection("Usuarios").get();

    for (var doc in respuesta.docs) {
      log(doc.data().toString());
      User usuarios = User.desdeJson(doc.data());
      lista.add(usuarios);
    }

    return lista;
  }

  static Future<List<User>> consultarGralUsuarios(String id) async {
    List<User> lista = [];
    await _db.collection("Usuarios").get().then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(User.desdeJson(doc.data()));
      }
    });

    return lista;
  }
}
