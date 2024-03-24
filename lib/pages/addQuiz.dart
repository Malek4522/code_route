import 'package:flutter/material.dart';


class addQuiz extends StatefulWidget {
  const addQuiz({super.key});
  @override
  State<addQuiz> createState() => addQuizState();
}

class addQuizState extends State<addQuiz> {
  final _textController = TextEditingController();
  final _choix1Controller = TextEditingController();
  final _choix2Controller = TextEditingController();
  final _bonnereponseController = TextEditingController();
  final _typedQuizController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text(
          'AJOUTER UN QUIZ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/backround.jpg"),fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TEXT
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'text...',
                    fillColor: Color.fromARGB(255, 216, 214, 214),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // choix1
              Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _choix1Controller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintText: 'choix1',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),

              // choix2
              Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _choix2Controller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintText: 'choix2',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),

              FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                foregroundColor: Colors.black,
                onPressed: () {},
                child: Icon(Icons.add),
              ),
              SizedBox(
                height: 10,
              ),

              //bonne reponse
              Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _bonnereponseController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintText: 'BONNE REPONSE',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              //type de Quiz
              Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _typedQuizController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintText: 'typt de QUIZ',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  )),

              // envoyer un message
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'CONFERMER',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
