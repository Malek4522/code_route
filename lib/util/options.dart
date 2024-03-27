import 'package:code_route/classes/auth.dart';
import 'package:flutter/material.dart';

class OptionsBar extends StatefulWidget {
  const OptionsBar({super.key});
  @override
  State<OptionsBar> createState() => OptionsBarState();
}

class OptionsBarState extends State<OptionsBar> {
  final auth = authservice();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 233, 169, 51),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(''), accountEmail: Text('')),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('COURS'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('QUIZ'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('PARAMETRE'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('ABOUT'),
            onTap: () {},
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('DECONNECCTER'),
            onTap: () async{
              await auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
