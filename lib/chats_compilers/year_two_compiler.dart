import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/year_two_body.dart';
import 'package:r_connect/chat_libraries.dart/year_two_message.dart';

class YearTwoChatScreen extends StatelessWidget {
  const YearTwoChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Do number ka kam!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: YearTwoBody()),
            YearTwo(),
          ],
        ));
  }
}