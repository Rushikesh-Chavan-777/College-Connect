import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/epoch_body.dart';
import 'package:r_connect/chat_libraries.dart/epoch_message.dart';

class EpochChatScreen extends StatelessWidget {
  const EpochChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Only robos allowed!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: EpochBody()),
            Epoch(),
          ],
        ));
  }
}