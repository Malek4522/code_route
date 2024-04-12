import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:code_route/util/options.dart';


class addContent extends StatefulWidget {
  const addContent({super.key});
  @override
  State<addContent> createState() => addContentState();
}

class addContentState extends State<addContent> {
  final _titleController = TextEditingController();
  final _explicationController = TextEditingController();
  List<TextEditingController> controllers = [
    for (int i = 0; i < 5; i++) TextEditingController()
  ];

  int n = 3;
  List<int> options = [1, 2, 3];
  int? _selectedOption;
  List types = ["معلومات عامة","اولويات","اشارات",];
  String? _selectedType;
  List plaqueType = ["لتحذير","الارشاد","الممنوع","الاجباري"];
  String?_selectedPlaqueType;

  Uint8List? _selectedImage; 
  final _formkey = GlobalKey<FormState>();

  final db = firestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: OptionsBar(),
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
        child: Form(
          key: _formkey,
          child: ListView(
              children: [
                //TEXT
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    validator: (value) => value!.isEmpty? '   *enter title': null,
                    controller: _titleController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'titre...',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: const Color.fromARGB(255, 233, 169, 51),
                  child: Text(
                    "choisir une photo de gallery",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    pickimage();
                  },
                ),
            
                SizedBox(
                  height: 10,
                ),
                
            
                _selectedImage==null? Text("please select image"): Container(
                  margin: EdgeInsets.fromLTRB(100, 50, 100, 50),
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Image.memory(_selectedImage!)
          
                  ),
                  
                ),

                //type de Quiz
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton(
                      
                      borderRadius: BorderRadius.circular(8),
                      hint: Text(' choose the type'),
                      dropdownColor: const Color.fromARGB(255, 216, 214, 214),
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      value: _selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = newValue as String;
                        });
                      },
                      items: types.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text("   "+value),
                        );

                      },).toList()
                      
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child:(_selectedType ==null||_selectedType !=types[2])?null: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton(
                      
                      borderRadius: BorderRadius.circular(8),
                      hint: Text(' choose the type'),
                      dropdownColor: const Color.fromARGB(255, 216, 214, 214),
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      value: _selectedPlaqueType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedPlaqueType = newValue as String;
                        });
                      },
                      items: plaqueType.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text("   "+value),
                        );

                      },).toList()
                      
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
            
                
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: n,
                  itemBuilder: (context, index) =>(_selectedType==null||_selectedType==types[0])? null : Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) => value!.isEmpty? '   *enter choice': null,
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
            
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (_selectedType==null||_selectedType==types[0])?[]:[
                    FloatingActionButton(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      foregroundColor: Colors.black,
                      onPressed: () {
                        if (n < 5) {
                          options.add(n + 1);
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
                          if(_selectedOption == null){
                            setState(() {
                              n--;
                            options.removeLast();
                            });
                          }else{
                            setState(() {                           
                            if (n <= _selectedOption!) _selectedOption =_selectedOption! -1;
                            n--;
                            options.removeLast();
                          });
                          }
                          
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
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: (_selectedType==null||(_selectedType!=types[0]&&_selectedType!=types[1]))? null:TextFormField(
                    validator: (value) => value!.isEmpty? '   *enter explication': null,
                    controller: _explicationController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText:(_selectedType==types[0])? 'description...':'explication...',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
            
                //bonne reponse
            
                Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                    child: (_selectedType==null || _selectedType==types[0])? null:Container(                     
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(8),
                        hint: Text(' choose the corect answer'),
                        dropdownColor: const Color.fromARGB(255, 216, 214, 214),
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        value: _selectedOption,
                        items: options.map(( option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(
                              "   "+option.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value ;
                          });
                        },
                      ),
                    )),
            
                SizedBox(
                  height: 10,
                ),
                
            
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){
                        if(_selectedImage == null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please select image")));
                        }else if(_selectedType == null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please select type")));
                        }else if(_selectedType == types[2] && _selectedPlaqueType == null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please select plaque type")));
                        }else{
                          Map<String,dynamic> options = {} ;
                          for(int i = 0;i<n;i++){
                            options.addAll({
                              controllers[i].text.trim(): (i == (_selectedOption?? 0) -1)
                            });
                          }
                          db.uploadcontent(
                            monitorRef: FirebaseFirestore.instance.collection("users").doc("dev"),
                            //monitorId: ,
                            type: _selectedType!,
                            plaqueType: _selectedPlaqueType,
                            options: options,
                            title: _titleController.text.trim(), 
                            image: _selectedImage!, 
                            explication: _explicationController.text.trim(),
                          );                         
                                               
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("added")));
                          setState(() {
                            _selectedImage = null;
                            _titleController.clear();
                            
                            for(var controller in controllers){ 
                              controller.clear();
                            }
                            
                            _explicationController.clear();
                            
                          });
                        }
                      }
                    },
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
  Future pickimage()async{  
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image != null){
      _selectedImage = await image.readAsBytes();
      setState(() {
        _selectedImage ;
      });
    }
  }
}
