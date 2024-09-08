import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/nso_body.dart';
import 'package:r_connect/chat_libraries.dart/nso_message.dart';

class NsoChatScreen extends StatelessWidget {
  const NsoChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("NSO Chat Area", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: NsoBody()),
            Nso(),
          ],
        ));
  }
}