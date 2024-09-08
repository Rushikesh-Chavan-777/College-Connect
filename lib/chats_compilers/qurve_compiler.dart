import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/qurve_body.dart';
import 'package:r_connect/chat_libraries.dart/qurve_message.dart';

class QurveChatScreen extends StatelessWidget {
  const QurveChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("We are all humans :)", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: QurveBody()),
            Qurve(),
          ],
        ));
  }
}