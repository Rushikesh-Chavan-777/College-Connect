import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/year_one_body.dart';
import 'package:r_connect/chat_libraries.dart/year_one_message.dart';

class YearOneChatScreen extends StatelessWidget {
  const YearOneChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Facho Ka Ilaaka!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: YearOneBody()),
            YearOne(),
          ],
        ));
  }
}