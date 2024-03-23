import 'package:http/http.dart' as http;
import 'package:code_route/classes/question.dart';
import 'dart:convert';

class connect{
  final url = Uri.parse('https://code-route-f1a0f-default-rtdb.europe-west1.firebasedatabase.app/questions.json');
  Future<void> add_question(question qst)async{
    
    http.post(url,body: json.encode({
      'title': qst.title,
      'option': qst.option ,
    }));
    
  }
  

  Future<void> fetch_data()async{
    List<question> quiz = [];
    
    http.get(url).then((response){
      var data = json.decode(response.body) as Map<String,dynamic>;
      /*
      data.forEach((key, value) {
        var newqst = question(
          title: value['title'],
          option: Map.castFrom(value['option'])
          //option: value['option']
        );
        quiz.add(newqst);
      },);
      */

      print(data);
    });
    
  }
}