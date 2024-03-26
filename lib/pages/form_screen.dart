import 'dart:ui';

import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _confirmationcontroller = TextEditingController();
  final _nomController = TextEditingController();
  final _motdepassecontroller = TextEditingController();
  final _numdetelcontroller = TextEditingController();
  final _mailcontroller = TextEditingController();
  String msg = "";
  void envoyermsg() {
    setState(() {
      msg = "Merci " + _nomController.text + "votre compte a ete cree";
    });
  }

  String ValueChoose = 'Condidat';
  String s = "envoyer un message";
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Creer Un Neauveau Compte"),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.white,
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
          width: double.infinity,
          height: 750,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/backround.jpg"),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(msg),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _nomController,
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
                child: TextField(
                  controller: _mailcontroller,
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
                child: TextField(
                  controller: _numdetelcontroller,
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
                child: TextField(
                    controller: _motdepassecontroller,
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
                child: TextField(
                  controller: _confirmationcontroller,
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
                  hint: const Text("Je suis un  "),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  underline: const SizedBox(),
                  style: const TextStyle(
                      color: Color.fromRGBO(117, 117, 117, 1), fontSize: 18),
                  value: ValueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      ValueChoose = newValue!;
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
                  onTap: envoyermsg,
                    
                  
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Créer',
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
