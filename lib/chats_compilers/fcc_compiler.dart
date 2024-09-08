import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/fcc_body.dart';
import 'package:r_connect/chat_libraries.dart/fcc_message.dart';


class FccChatScreen extends StatelessWidget {
  const FccChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Market down kyu hai??", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: FCCBody()),
            Fcc(),
          ],
        ));
  }
}