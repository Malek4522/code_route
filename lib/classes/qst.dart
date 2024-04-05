import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class qst{
  final String title;
  final String explication;
  final String url;
  final Map<String,dynamic> options;
  qst({
    required this.title,
    required this.explication,
    required this.options,
    required this.url
  });

  Map<String,dynamic>toJson()=>{
    "title" : title,
    "explication" : explication,
    "url" : url,
    "options" : options
  };

  static qst fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return qst(
      title: "title", 
      explication: "explication", 
      options: "options" as Map<String,dynamic>, 
      url: "url"
    );
  }

}