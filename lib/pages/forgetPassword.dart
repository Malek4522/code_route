import 'package:code_route/classes/auth.dart';
import 'package:code_route/util/timed_button.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgotPasword extends StatefulWidget {
  const ForgotPasword({super.key});
  @override
  State<ForgotPasword> createState() => ForgotPaswordState();
}

class ForgotPaswordState extends State<ForgotPasword> {
  final _emailController = TextEditingController();
  final auth = authservice();
  final _formkey = GlobalKey<FormState>();
  String email = "";
  bool _returning = true;
  bool validate = false;

  void returning(){
    setState(() {
      _returning =!_returning ;
    });
  }
  
  

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=>_returning ,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.0,
          leading: _returning? null:Text(""),
          title: Text(
            AppLocalizations.of(context)?.forgotPasswordTitle ?? 'Forgot Password?',
            style: TextStyle(
            color: Colors.black,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
            
          ),
          backgroundColor: Color(0xFFFDC80F),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.fill),
          ),
          child: Center(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  SizedBox(
                    height: 30,
                  ),
              
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                    child: Text(
                      AppLocalizations.of(context)?.enterYourEmail ?? 'ENTER YOUR EMAIL',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //confermation par email
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){                   
                          return  AppLocalizations.of(context)?.enterEmailError ?? '*enter email';                        
                        }else{
                          if(EmailValidator.validate(value.trim())){                         
                            return null;
                          }
                          else{
                            return AppLocalizations.of(context)?.invalidEmailError ?? '*invalid email';
                          }
                        }
                      },
                                            
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                          
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)?.emailHint ?? 'E-MAIL',
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
              
                  SizedBox(height: 100,),
              
                  // envoyer un message
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        _formkey.currentState!.validate();
                      },
                      child: timedbutton(
                        started: false,
                        validate:  !email.trim().isEmpty && 
                          EmailValidator.validate(_emailController.text.trim()),
                        returning: returning,
                        ontap: (){
                          if(_formkey.currentState!.validate()){
                            showDialog(
                              context: context, 
                              builder: (context)=>Center(child: CircularProgressIndicator(),)
                            );
                                  
                            auth.resetpassword(email: _emailController.text.trim());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.emailSentMessage ?? "An email sent")));
                            
                          } 
                        },
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
