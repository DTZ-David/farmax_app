import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PeticionesCliente {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearCliente(Map<String, dynamic> cliente, foto) async {
    print(cliente['foto']);

    var url = '';
    if (foto != null) {
      url = await PeticionesCliente.cargarfoto(
          foto, cliente['nombre'] + cliente['apellido']);
    }
    print(url);
    cliente['foto'] = url.toString();

    await _db.collection('Clientes').doc().set(cliente).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Clientes");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<void> actualizarcatalogo(
      String id, Map<String, dynamic> catalogo) async {
    await _db
        .collection('Identificacion')
        .doc(id)
        .update(catalogo)
        .catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('Identificacion').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
