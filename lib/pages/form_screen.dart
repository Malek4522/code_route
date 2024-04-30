import 'package:code_route/classes/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
  bool passToggle1 = true;
  bool passToggle2 = true;
  final _formkey = GlobalKey<FormState>();

  final auth = authservice();

  bool activation = false;

  bool isVirified = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(AppLocalizations.of(context)?.createNewAccount ?? "Create New Account"),
               
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
                  validator: (value) => value!.isEmpty? AppLocalizations.of(context)?.enterNameError ?? "*Enter name": null,
                  onChanged: (val){
                    setState(() {
                      nom = val;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)?.fullNameHint ?? "Full Name...",
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
                        return AppLocalizations.of(context)?.enterEmailError ?? "*Enter email";                        
                      }else{
                        if(EmailValidator.validate(value.trim())){                         
                          return null;
                        }
                        else{
                          return AppLocalizations.of(context)?.invalidEmailError ?? "*Invalid email";
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
                      hintText: AppLocalizations.of(context)?.emailHint ?? "Email...",
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
                  validator: (value) => value!.length !=10 ? AppLocalizations.of(context)?.invalidNumberError ?? "*Invalid number": null,                                                          
                  onChanged: (val) {
                    setState(() {
                      num = val ;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)?.phoneNumberHint ?? "Phone Number...",
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
                    validator: (value) => value!.length<6? AppLocalizations.of(context)?.shortPassError ?? "*Password too short": null,
                    onChanged: (val) {
                    setState(() {
                      pass1 = val;
                    });
                  },
                    obscureText: passToggle1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)?.passwordHint ?? "Password...",
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
                            passToggle1 = !passToggle1;
                          });
                        },
                        child: Icon(passToggle1
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
                  validator: (value) => value! !=pass1? AppLocalizations.of(context)?.diffPassError ?? "*Passwords do not match": null,   
                  onChanged: (val) {
                    setState(() {
                      pass2 = val;
                    });
                  },
                  obscureText: passToggle2,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)?.confirmPasswordHint ?? "Confirm Password...",
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
                            passToggle2 = !passToggle2;
                          });
                        },
                        child: Icon(passToggle2
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
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
                  hint:  Text(AppLocalizations.of(context)?.enterUserType ?? "Enter user type"),
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
                  items:  [
                    DropdownMenuItem<String>(
                      value: 'Condidat',
                      child: Text(AppLocalizations.of(context)?.iAmACandidate ?? "I am a candidate"),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Moniteur',
                      child:Text(AppLocalizations.of(context)?.iAmAnInstructor ?? "I am an instructor"),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.pleaseSelectType ?? "Please select type")));
                      }
                      else{ 
                        final result = await auth.registerWithEmailPass(
                          email: email, 
                          password: pass1,
                          phoneNum: num ,
                          name: nom,
                          usertype: ValueChoose!, 

                        );
                        switch(result){
                          case 'done': 
                            Navigator.pop(context);break;
                          case 'weak-password':
                            break;
                          case'email-already-in-use':
                            QuickAlert.show(
                              context: context, 
                              type: QuickAlertType.error,
                              title: AppLocalizations.of(context)?.emailAlreadyUsed ?? "email already used"
                            );
                          default : print("myerror: $result");break;
                        }
                      }
                                     
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
                        AppLocalizations.of(context)?.create ?? "create",
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
