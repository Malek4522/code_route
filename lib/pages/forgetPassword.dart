import 'package:flutter/material.dart';
import 'package:code_route/util/options.dart';

class ForgotPasword extends StatefulWidget {
  const ForgotPasword({super.key});
  @override
  State<ForgotPasword> createState() => ForgotPaswordState();
}

class ForgotPaswordState extends State<ForgotPasword> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String greetingmsg = "";

  void sndmsg() {
    setState(() {
      greetingmsg =
          "email de confermation a ete envoyer a " + _emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OptionsBar(),
      appBar: AppBar(
        title: Text(
          'mot de passe oublie?',
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
              image: AssetImage("assets/background.jpg"), fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                greetingmsg,
                style: TextStyle(
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                child: Text(
                  'ENTRER VOTRE EMAIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //confermation par email
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Entrer votre EMAIL',
                    fillColor: Color.fromARGB(255, 216, 214, 214),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                child: Text(
                  'ou ENTRER VOTRE NUMERO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // confermation par num de tel
              Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _phoneController,
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
                      hintText: 'Entrer votre numero',
                      fillColor: Color.fromARGB(255, 216, 214, 214),
                      filled: true,
                    ),
                  )),
              SizedBox(
                height: 100,
              ),

              // envoyer un message
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: sndmsg,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'ENVOYER UN MESSAGE',
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
