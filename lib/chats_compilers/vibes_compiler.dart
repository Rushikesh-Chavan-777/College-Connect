import 'package:flutter/material.dart';
import 'package:r_connect/chat_body/vibes_body.dart';
import 'package:r_connect/chat_libraries.dart/vibes_message.dart';
import 'package:r_connect/vibes/popover.dart';


class VibesChatScreen extends StatelessWidget {
  const VibesChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
        appBar: AppBar(
          actions: [
            Popover(),
          ],
          backgroundColor: Colors.redAccent,
          title:
              const Text("Let's jam and bread", style: TextStyle(color: Colors.black)),
        ),
//body
        body: const Column(
          children: [
            Expanded(child: VibesBody()),
            Vibes(),
          ],
        ));
  }
}