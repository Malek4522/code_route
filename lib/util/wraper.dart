import 'package:code_route/classes/myuser.dart';
import 'package:code_route/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final  User = Provider.of<myUser?>(context);
    print(User);
    return login();
  }
}