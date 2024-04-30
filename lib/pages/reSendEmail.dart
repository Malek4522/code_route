import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:code_route/util/options.dart';

class reSend extends StatefulWidget {
  const reSend({super.key});
  @override
  State<reSend> createState() => reSendState();
}

class reSendState extends State<reSend> {
  int time = 30;

  void _countDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: OptionsBar(),
        appBar: AppBar(
          title: Text(
            '???????',
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
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            ElevatedButton(
               
              style: ElevatedButton.styleFrom(),
               child: Text(time > 0 
    ? AppLocalizations.of(context)?.resendButtonText(time) ?? "Resend in $time seconds" 
    : AppLocalizations.of(context)?.resendButtonReady ?? "Resend Now"),
  onPressed: time > 0 ? null : () {
    setState(() {
      time = 30; // Reset the timer
      _countDown(); // Restart the countdown
    });
  },
            )
          ],
        ))));
  }
}
