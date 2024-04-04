import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OptionsBar extends StatefulWidget {
  const OptionsBar({super.key});
  @override
  State<OptionsBar> createState() => OptionsBarState();
}

class OptionsBarState extends State<OptionsBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 233, 169, 51),
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
            title: Text("user",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                )),
            subtitle: Text("email",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                )),
          ),
          SizedBox(
            height: 60,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('COURS'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text('QUIZ'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('PARAMETRE'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('ABOUT'),
            onTap: () {},
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('DECONNECCTER'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
