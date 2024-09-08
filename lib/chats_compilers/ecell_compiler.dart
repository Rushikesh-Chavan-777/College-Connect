import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/ecell_body.dart';
import 'package:r_connect/chat_libraries.dart/ecell_message.dart';


class EcellChatScreen extends StatelessWidget {
  const EcellChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Lets talk business!", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: EcellBody()),
            Ecell(),
          ],
        ));
  }
}