import 'package:cloud_firestore/cloud_firestore.dart';

class priority{
  final String title;
  final String explication;
  final String url;
  final Map<String,dynamic> options;
  final double difficulty;

  priority({
    required this.title,
    required this.explication,
    required this.options,
    required this.url,
    required this.difficulty
  });

  static priority fromsnap(QueryDocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return priority(
      title: snapshot["title"], 
      explication: snapshot["explication"], 
      options: snapshot["options"] as Map<String,dynamic>, 
      url: snapshot["url"],
      difficulty : snapshot["difficulty"],
    );
  }

}


class plaque{
  final String title;
  final String type;
  final String url;
  final Map<String,dynamic> options;
  final double difficulty;

  plaque({
    required this.title,
    required this.type,
    required this.options,
    required this.url,
    required this.difficulty
  });


  static plaque fromsnap(QueryDocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return plaque(
      title: snapshot["title"], 
      type: snapshot["type"], 
      options: snapshot["options"] as Map<String,dynamic>, 
      url: snapshot["url"],
      difficulty : snapshot["difficulty"]
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

  static generality fromsnap(QueryDocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return generality(
      title: snapshot["title"], 
      url: snapshot["url"],
      description: snapshot["explication"]
    );
  }

}