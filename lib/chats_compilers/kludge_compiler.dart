import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/kludge_body.dart';
import 'package:r_connect/chat_libraries.dart/kludge_message.dart';


class KludgeChatScreen extends StatelessWidget {
  const KludgeChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Target: Director's Phone", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: KludgeBody()),
            Kludge(),
          ],
        ));
  }
}