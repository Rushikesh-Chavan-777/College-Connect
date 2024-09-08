import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/ncc_body.dart';
import 'package:r_connect/chat_libraries.dart/ncc_message.dart';


class NccChatScreen extends StatelessWidget {
  const NccChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("NCC Chat Area", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: NccBody()),
            Ncc(),
          ],
        ));
  }
}