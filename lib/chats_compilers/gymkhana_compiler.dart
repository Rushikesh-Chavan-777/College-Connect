import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/gymkhana_body.dart';
import 'package:r_connect/chat_libraries.dart/gymkhana_message.dart';


class GymkhanaChatScreen extends StatelessWidget {
  const GymkhanaChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title:
              const Text("Is Gym me Khaana allowed hai ;)", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: GymKhanaBody()),
            Gymkhana(),
          ],
        ));
  }
}