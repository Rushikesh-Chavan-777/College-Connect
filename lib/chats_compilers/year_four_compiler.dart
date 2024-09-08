import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/year_four_body.dart';
import 'package:r_connect/chat_libraries.dart/year_four_body.dart';


class YearFourChatScreen extends StatelessWidget {
  const YearFourChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Will you miss IIT H ?", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: YearFourBody()),
            YearFour(),
          ],
        ));
  }
}