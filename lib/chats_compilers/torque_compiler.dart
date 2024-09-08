import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/torque_body.dart';
import 'package:r_connect/chat_libraries.dart/torque_message.dart';


class TorqueChatScreen extends StatelessWidget {
  const TorqueChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Let's race!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: TorqueBody()),
            Torque(),
          ],
        ));
  }
}