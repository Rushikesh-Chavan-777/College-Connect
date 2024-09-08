import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/year_three_body.dart';
import 'package:r_connect/chat_libraries.dart/year_three_message.dart';

class YearThreeChatScreen extends StatelessWidget {
  const YearThreeChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Theen tigda kam bidga!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: YearThreeBody()),
            YearThree(),
          ],
        ));
  }
}