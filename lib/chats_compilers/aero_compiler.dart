import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/aero_body.dart';
import 'package:r_connect/chat_libraries.dart/aero_message.dart';


class AeroChatScreen extends StatelessWidget {
  const AeroChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Your own hanger!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: AeroBody()),
            Aero(),
          ],
        ));
  }
}