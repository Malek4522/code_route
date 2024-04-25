import 'package:code_route/classes/user_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';//.....
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:code_route/pages/forgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:code_route/classes/auth.dart';
import 'package:code_route/pages/form_screen.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:email_validator/email_validator.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String email = "";
  String password = "";
  


  final auth = authservice();
  final _formkey = GlobalKey<FormState>(); 

  RestartableTimer? timer;
  bool enable = true;
  
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.connection ?? 'Connection'),
        backgroundColor: const Color.fromARGB(255, 233, 169, 51),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/backround.jpg"),fit: BoxFit.fill)
        ),
        child: Form(
          key: _formkey,
          child: Column(
            
            children: [
              
              SizedBox(height: 100,),
              Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return AppLocalizations.of(context)?.enter_email ?? '   *enter email';
                      }else{
                        if(EmailValidator.validate(value.trim())){
                          return null;
                        }
                        else{
                          return AppLocalizations.of(context)?.invalid_email ?? "   *invalid email";
                        }
                      }
                      
                    },
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email=value;
                      });
                    },
                    decoration: InputDecoration(
                        
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText:  AppLocalizations.of(context)?.email_hint ?? 'E-MAIL',
                      prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.person,
                          color: Colors.black,
                      ),
                    )
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    validator: (value) => value!.length<6? AppLocalizations.of(context)?.short_pass ?? '   *short pass': null,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: passToggle,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)?.password_hint ?? 'Password',
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
                      ),
                      
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>ForgotPasword()
                        )
                    );
                  },
                  child:Text(AppLocalizations.of(context)?.forgot_password ?? 'Forgot password?'
,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      color: Colors.white,
                      fontSize: 15,                 
                      fontWeight: FontWeight.bold 
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  
                  child: GestureDetector(
                    onTap:()async{                      
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          enable = false;
                        });
                        dynamic reslut = await auth.loginWithEmailPass(email: email, password: password);
                        handelerror(reslut);
                                                                                       
                      }                      
                      
                    },
                                       
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 233, 169, 51),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Center(
                        child: Text(
                           AppLocalizations.of(context)?.log_in ?? 'Log in',
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
                SizedBox(height: 15,),
                Text(
                  AppLocalizations.of(context)?.dont_have_account ?? "Don't have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,                 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: (){                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>FormScreen()
                        )
                      );
                      
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
                          AppLocalizations.of(context)?.create_account ?? 'Create account',
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
          
                Text(
                  AppLocalizations.of(context)?.or ?? "Or",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,                 
                    fontWeight: FontWeight.bold
                  ),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: ()async{                    
                      await auth.sign_anonym();                                                            
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
                           AppLocalizations.of(context)?.continue_as_guest ?? 'Continue as guest',
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

  handelerror(e){
    switch(e){
      case 'done': 
        break;
      case 'invalid-credential':  
        QuickAlert.show(
          context: context, 
          type: QuickAlertType.error,
          title: AppLocalizations.of(context)?.email_and_pass_dont_match ?? 'Email and pass does not match'
        );
        break;
      case 'too-many-requests':
        QuickAlert.show(
          context: context, 
          type: QuickAlertType.error,
          title: AppLocalizations.of(context)?.too_many_attempts ?? 'Too many attempts',
          text: AppLocalizations.of(context)?.account_disabled ?? 'Account has been disable temporarily, please try to reset the password'
        );    
      default: 
        print("myerror: $e");break; 
    }
  }
}