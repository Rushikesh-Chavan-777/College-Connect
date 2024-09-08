import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/lambda_body.dart';
import 'package:r_connect/chat_libraries.dart/lambda_message.dart';


class LambdaChatScreen extends StatelessWidget {
  const LambdaChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Lambda Chat Area", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: LambaBody()),
            Lambda(),
          ],
        ));
  }
}