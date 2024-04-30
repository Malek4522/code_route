import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/util/options.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
    static const String routeName = 'pages/parametre.dart';


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _name = GlobalKey<FormState>();
  final _email = GlobalKey<FormState>();
  final _pass = GlobalKey<FormState>();
  final _phone = GlobalKey<FormState>(); 

  

  // Define a Color variable to store the icon color
  Color iconColor = Colors.white;
  String password ="";
  String nom ="";
  String email ="";
  String num ="";
  bool passToggle = true;

  final auth = authservice();
  myUser? user ;
  @override
  Widget build(BuildContext context) {
    Provider.of<user_provider>(context,listen: false).refreshUser();
    user =  Provider.of<user_provider>(context,listen: false).getuser;
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),  
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
        elevation: 0, 
        title: Text(AppLocalizations.of(context)?.settingsTitle ?? 'settings',
            style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.black,fontWeight: FontWeight.bold // Set the text color to black
            )),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _name,
                  child: CupertinoListTile(
                    trailing: IconButton(
                      onPressed: (){
                        if(_name.currentState!.validate()){
                          var user = FirebaseAuth.instance.currentUser;
                          FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
                            'name' : nom,
                          });
                          Navigator.pop(context);
                          Provider.of<routeProvider>(context, listen: false).removeroute();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                            Text(AppLocalizations.of(context)?.nameUpdated ?? 'Name has been updated')
                          ));
                        }
                      }, 
                      icon: Icon(Icons.keyboard_double_arrow_right,size: 50,color: Colors.white,)
                    ),
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        validator: (value) => nom.length !=0? null:AppLocalizations.of(context)?.enterName ?? '*Enter name',
                        keyboardType: TextInputType.emailAddress,                                            onChanged: (val){
                          setState(() {
                            nom = val;
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)?.changeUserName ?? 'Change user name',
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _email,
                  child: CupertinoListTile(
                    trailing: (email.isNotEmpty)? Container():IconButton(
                        onPressed: (){
                          if(_email.currentState!.validate()){
                  
                          }
                        }, 
                        icon: Icon(Icons.keyboard_double_arrow_right,size: 50,color: Colors.white,)
                      ),
                   
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                            if(value!.isEmpty){                   
                              return AppLocalizations.of(context)?.enterYourEmail ?? '*enter your email';                        
                            }else{
                              if(value == user!.email){
                                return AppLocalizations.of(context)?.sameEmail ?? '*Same email';
                              }
                              if(EmailValidator.validate(value.trim())){                         
                                return null;
                              }
                              else{
                                return AppLocalizations.of(context)?.invalidEmail ?? '*Invalid email';
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
                            hintText:AppLocalizations.of(context)?.changeEmail ?? 'Change email',
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),const SizedBox(
                  height: 5,
                ),
                (email.length ==0)? Container():Form(
                  key: _pass,
                  child: ListTile(
                     trailing: IconButton(
                        onPressed: (){
                          if(_email.currentState!.validate()&&_pass.currentState!.validate()){
                            final auth=authservice();
                            auth.changeEmail(email, password).then((result){
                  
                              switch(result as String){ 
                                case 'done':
                                  Navigator.pop(context);
                                  Provider.of<routeProvider>(context, listen: false).removeroute();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                                    Text(AppLocalizations.of(context)?.checkEmailBox ?? 'Check your email box for verification link')
                                  ));

                                  auth.signOut();
                                  break;
                                case 'invalid-credential':
                                  QuickAlert.show(
                                    context: context, 
                                    type: QuickAlertType.error,
                                    title: AppLocalizations.of(context)?.wrongPassword ?? 'Wrong password'
                                  );
                                  break;
                                case 'too-many-requests':
                                  QuickAlert.show(
                                    context: context, 
                                    type: QuickAlertType.error,
                                    title: AppLocalizations.of(context)?.tooManyAttempts ?? 'Too many attempts',
                                    text: AppLocalizations.of(context)?.accountDisabled ?? 'Account has been disabled temporarily, please try to reset the password'
                                  );
                                  break;
                                default:
                                  print(result);
                                  break;  
                              }
                            });
                          }
                        }, 
                        icon: Icon(Icons.keyboard_double_arrow_right,size: 50,color: Colors.white,)
                      ),
                    title: Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        validator: (value) => value!.length<6? AppLocalizations.of(context)?.invalidPassword ?? '*Invalid password': null,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: passToggle,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)?.passwordHint ?? 'Enter your password',
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
                  ),
                ),
          
          
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _phone,
                  child: CupertinoListTile(
                    trailing: IconButton(
                          onPressed: (){
                            if(_phone.currentState!.validate()){
                              var user = FirebaseAuth.instance.currentUser;
                              FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
                                'phoneNum' : num,
                              });
                              Navigator.pop(context);
                              Provider.of<routeProvider>(context, listen: false).removeroute();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                              Text(AppLocalizations.of(context)?.phoneUpdated ?? 'Phone number has been updated')
                          ));
                            }
                          }, 
                          icon: Icon(Icons.keyboard_double_arrow_right,size: 50,color: Colors.white,)
                        ),
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(  
                        
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[,.]')),], 
                        keyboardType: TextInputType.numberWithOptions(),              
                        validator: (value){
                          if(value!.isEmpty){
                            return null;
                          }else{
                            if(value.length!=10){
                              return AppLocalizations.of(context)?.invalidPhoneNumber ?? '*Invalid number';
                            }
                            else{
                              return null;
                            }
                          }
                        },                                                        
                        onChanged: (val) {
                          setState(() {
                            num = val ;
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)?.changePhoneNumber ?? 'Change phone number',
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(
            height: 50,
          ),
          
              ],
            ),
          )
        ],
      ),
    );
  }
}