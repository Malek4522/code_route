import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/qst.dart';
import 'package:code_route/classes/storage.dart';

class firestore{
  final db = FirebaseFirestore.instance;
  qst? question ;
  
  Future<String> uploadQuestion({
    required String courseId,
    required String title,
    required String explication,
    required Uint8List file,
    required Map<String,dynamic> options,
  })async{
    String state ="error";
    try{
      String url = await storage().uploadimage(file: file, id: courseId);
       question = qst(
        title: title, 
        explication: explication, 
        options: options, 
        url: url
      );

      db.doc(courseId).set(question!.toJson());
      state = "done";
    }catch(e){
      state = e.toString();
    }
    return state; 
  }
  

}