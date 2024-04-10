import 'package:code_route/classes/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';


class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String nom = "";
  String email = "";
  String num = "";
  String pass1 = "";
  String pass2 = ""; 
   
  String? ValueChoose ;
  String error = "";
  bool passToggle = true;
  final _formkey = GlobalKey<FormState>();

  final auth = authservice();

  bool activation = false;
  String title = "Crée";
  bool isVirified = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Creer Un Neauveau Compte"),
               
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/backround.jpg"),
          fit: BoxFit.fill,
        )),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,            
            children: [
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,                    
                  validator: (value) => value!.isEmpty? '   *enter name': null,
                  onChanged: (val){
                    setState(() {
                      nom = val;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'Nom complet...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                      if(value!.isEmpty){                   
                        return '   *enter email';                        
                      }else{
                        if(EmailValidator.validate(value.trim())){                         
                          return null;
                        }
                        else{
                          return "   *invalide email";
                        }
                      }
                    },
                
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'E-mail...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(  
                  
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[,.]')),], 
                  keyboardType: TextInputType.numberWithOptions(),              
                  validator: (value) => value!.length !=10 ? '   *invalid num': null,                                                         
                  onChanged: (val) {
                    setState(() {
                      num = val ;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'Numéro de teléphone...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => value!.length<6? '   *short pass': null,
                    onChanged: (val) {
                    setState(() {
                      pass1 = val;
                    });
                  },
                    obscureText: passToggle,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'Mot de passe...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,              
                  validator: (value) => value! !=pass1? '   *diff pass': null,   
                  onChanged: (val) {
                    setState(() {
                      pass2 = val;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'Confirmer le mot de passe...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButton(                  
                  hint: const Text("enter user type  "),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  underline: const SizedBox(),
                  style: const TextStyle(
                      color: Color.fromRGBO(117, 117, 117, 1), fontSize: 18),
                  value: ValueChoose,
                  onChanged:activation? null: (newValue) {
                    setState(() {
                      ValueChoose = newValue! as String;
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Condidat',
                      child: Text('Je suis un condidat'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Moniteur',
                      child: Text('Je suis un moniteur'),
                    ),
                  ],
                  padding: const EdgeInsets.only(left: 17.0),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () async{  
                                    
                    if(_formkey.currentState!.validate()){
                      if(ValueChoose == null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please select type")));
                      }
                      else dynamic result = await auth.registerWithEmailPass(
                        email: email, 
                        password: pass1,
                        phoneNum: num ,
                        name: nom,
                        usertype: ValueChoose!, 

                      );
                      Navigator.pop(context);
                                  
                                       
                    }
                                                                                                                                               
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
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
