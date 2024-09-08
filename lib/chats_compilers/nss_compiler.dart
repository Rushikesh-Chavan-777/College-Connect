import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/nss_body.dart';
import 'package:r_connect/chat_libraries.dart/nss_message.dart';


class NssChatScreen extends StatelessWidget {
  const NssChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Jhaadu marne ke liye kitne hours??", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: NssBody()),
            Nss(),
          ],
        ));
  }
}