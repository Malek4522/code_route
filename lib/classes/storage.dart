import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class storage{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadimage({
    required  Uint8List image,
    required DocumentReference reference
    })async{
      //print(reference.path);
      Reference ref = _storage.ref(reference.id);
      UploadTask uploadTask = ref.putData(image);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
  }

}