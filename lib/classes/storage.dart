import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class storage{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadimage({
    required  Uint8List file,
    required  String id
    })async{
      Reference ref = _storage.ref(id);
      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
  }

}