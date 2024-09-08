import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/shuffle_body.dart';
import 'package:r_connect/chat_libraries.dart/shuffle_message.dart';


class ShuffleChatScreen extends StatelessWidget {
  const ShuffleChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Let's Dance", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: ShuffleBody()),
            Shuffle(),
          ],
        ));
  }
}