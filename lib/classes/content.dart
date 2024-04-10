import 'package:cloud_firestore/cloud_firestore.dart';

class priority{
  final String title;
  final String explication;
  final String url;
  final Map<String,dynamic> options;

  priority({
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

  static priority fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return priority(
      title: snapshot["title"], 
      explication: snapshot["explication"], 
      options: snapshot["options"] as Map<String,dynamic>, 
      url: snapshot["url"]
    );
  }

}


class plaque{
  final String title;
  final String type;
  final String url;
  final Map<String,dynamic> options;

  plaque({
    required this.title,
    required this.type,
    required this.options,
    required this.url
  });

  Map<String,dynamic>toJson()=>{
    "title" : title,
    "type" : type,
    "url" : url,
    "options" : options
  };

  static plaque fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return plaque(
      title: snapshot["title"], 
      type: snapshot["type"], 
      options: snapshot["options"] as Map<String,dynamic>, 
      url: snapshot["url"]
    );
  }

}


class generality{
  final String title;
  final String url;
  final String description;

  generality({
    required this.title,
    required this.url,
    required this.description,
  });

  Map<String,dynamic>toJson()=>{
    "title" : title,
    "url" : url,
    "description" : description,
  };

  static generality fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return generality(
      title: snapshot["title"], 
      url: snapshot["url"],
      description: snapshot["description"]
    );
  }

}