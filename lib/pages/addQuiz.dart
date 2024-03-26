import 'package:flutter/material.dart';
import 'package:code_route/util/options.dart';

class addQuiz extends StatefulWidget {
  const addQuiz({super.key});
  @override
  State<addQuiz> createState() => addQuizState();
}

class addQuizState extends State<addQuiz> {
  final _textController = TextEditingController();
  List<Object> controllers = [
    for (int i = 0; i < 5; i++) TextEditingController()
  ];

  int _selectedItem = 1;
  int n = 3;
  List<int> items = [1, 2, 3];

  String valueChoose = 'plaques';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OptionsBar(),
      appBar: AppBar(
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
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
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
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: n,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 25.0),
                      child: TextField(
                        controller: controllers[index] as TextEditingController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                          ),
                          hintText: 'choix${index + 1}',
                          fillColor: Color.fromARGB(255, 216, 214, 214),
                          filled: true,
                        ),
                      )),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor: Colors.black,
                    onPressed: () {
                      if (n < 5) {
                        items.add(n + 1);
                        setState(() {
                          n++;
                        });
                      }
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor: Colors.black,
                    onPressed: () {
                      if (n > 2) {
                        setState(() {
                          if (n <= _selectedItem) _selectedItem--;
                          n--;
                          items.removeLast();
                        });
                      }
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //bonne reponse

              Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton(
                      hint: Text('typedeQuiz'),
                      dropdownColor: const Color.fromARGB(255, 216, 214, 214),
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      value: _selectedItem,
                      items: items.map((int item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value as int;
                        });
                      },
                    ),
                  )),

              SizedBox(
                height: 10,
              ),
              //type de Quiz
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton(
                    hint: Text('typedeQuiz'),
                    dropdownColor: const Color.fromARGB(255, 216, 214, 214),
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'plaques',
                        child: Text('plaques'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'priorite',
                        child: Text('priorite'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'gene',
                        child: Text('gene'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

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
