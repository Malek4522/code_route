import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

Future<String> translate(String text,String to)async{
  final translator = GoogleTranslator();
  return translator.translate(text,to: to).then((value) => value.toString());
}


class FutureBuilder_translate extends StatelessWidget {
  const FutureBuilder_translate({
    super.key,
    required this.text,
    required this.to,
    this.style
  });
  final String text,to ;
  final TextStyle? style;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: translate(text, to), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return to=='en'? Text('connection available to translate\n'+text):
          Text('connexion disponible pour traduire\n'+text);
        } else {
          return Text(snapshot.data!,style: style,); 
        }
      }  
    );
  }
}