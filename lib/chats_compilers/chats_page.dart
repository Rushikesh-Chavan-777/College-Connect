import 'package:flutter/material.dart';
//import 'package:r_connect/chat_libraries.dart/year_one_message.dart';
import 'package:r_connect/chat_body/chat_message.dart';
import 'package:r_connect/chat_libraries.dart/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          title:
              const Text("Chat Rooms", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: ChatMessage()),
            NewMessage(),
          ],
        ));
  }
}
