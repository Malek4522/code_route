import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/content.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class addContent extends StatefulWidget {
  const addContent({super.key});
  static const String routeName = 'pages/addContent.dart';
  @override
  State<addContent> createState() => addContentState();
}

class addContentState extends State<addContent> {
  final _titleController = TextEditingController();
  final _explicationController = TextEditingController();
  List<TextEditingController> controllers = [
    for (int i = 0; i < 5; i++) TextEditingController()
  ];

  double difficulty = 1;
  int n = 3;
  List<int> options = [1, 2, 3];
  int? _selectedOption;
  
  // Localized types list
  List<String> types = [];
  List<String> plaqueType = [];

  String? _selectedType;
  String? _selectedPlaqueType;

  Uint8List? _selectedImage; 
  final _formkey = GlobalKey<FormState>();

  final db = firestore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize localized strings
    final loc = AppLocalizations.of(context)!;
    types = [
      loc.generality,
      loc.priority,
      loc.plaques
    ];
    plaqueType = [
      loc.warning,
      loc.guidance,
      loc.prohibition,
      loc.mandatory
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: OptionsBar(),
      appBar: AppBar(
        title: Text(
           AppLocalizations.of(context)?.addQuizTitle ?? 'ADD A QUIZ',        
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
                    validator: (value) => value!.isEmpty?  AppLocalizations.of(context)?.enterTitleError ?? '*Enter title': null,
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
                      hintText:AppLocalizations.of(context)?.titleHint ?? 'Title...',
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
                    AppLocalizations.of(context)?.choosePhotoGallery ?? 'Choose a photo from gallery',
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
                
            
                _selectedImage==null? Text(AppLocalizations.of(context)?.pleaseSelectImage ?? 'Please select an image'): Container(
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
                      hint: Text(AppLocalizations.of(context)?.chooseType ?? 'choose the type'),
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
                      hint: Text(AppLocalizations.of(context)?.chooseType ?? 'choose the type'),
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
                        validator: (value) => value!.isEmpty? AppLocalizations.of(context)?.enterChoice ?? '*enter choice': null,
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
                          hintText: AppLocalizations.of(context)?.choiceHint ?? "Choice...${index + 1}",
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
                    validator: (value) => value!.isEmpty? AppLocalizations.of(context)?.enterExplanation ?? 'Enter explanation': null,
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
                      hintText:(_selectedType==types[0])? AppLocalizations.of(context)?.descriptionHint ?? 'Description...':AppLocalizations.of(context)?.explanationHint ?? 'Explanation...',
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
                        hint: Text(AppLocalizations.of(context)?.chooseCorrectAnswer ?? 'Choose the correct answer'),
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

                SizedBox(
                  height: 10,
                ),

                (_selectedType == null)?SizedBox(height: 1,)  : (_selectedType==types[0])?
                  SizedBox(height: 1,) :Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white
                    ),
                    child: Column(
                      children: [                       
                        Text(
                          AppLocalizations.of(context)?.selectDifficulty ?? 'Select difficulty',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25, 
                          ),
                        ),
                        Slider(                    
                          value: difficulty, 
                          onChanged: (value) => setState(() {difficulty = value;}),
                          min: 1,
                          max: 10,
                          divisions: 18,
                          label: difficulty.toString(),
                          thumbColor: Color.fromARGB(255, 28, 28, 68),
                        
                        ),
                      ],
                    ),
                  ),
                
            
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){
                        if(_selectedImage == null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.pleaseSelectImage ?? 'Please select an image')));
                        }else if(_selectedType == null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.pleaseSelectType ?? 'Please select type')));
                        }else if(_selectedType == types[2] && _selectedPlaqueType == null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.pleaseSelectPlaqueType ?? 'Please select plaque type')));
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
                            difficulty: difficulty,
                            type: _selectedType!,
                            plaqueType: _selectedPlaqueType,
                            options: options,
                            title: _titleController.text.trim(), 
                            image: _selectedImage!, 
                            explication: _explicationController.text.trim(),
                          );                         
                                               
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.added ?? 'Added')));
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
                          AppLocalizations.of(context)?.confirm ?? 'CONFIRM',
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
