import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/infero_body.dart';
import 'package:r_connect/chat_libraries.dart/infero_message.dart';


class InferoChatScreen extends StatelessWidget {
  const InferoChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Infero Chat area", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: InferoBody()),
            Infero(),
          ],
        ));
  }
}