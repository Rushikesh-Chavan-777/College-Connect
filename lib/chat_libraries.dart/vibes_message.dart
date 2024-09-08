import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Vibes extends StatefulWidget {
  const Vibes({super.key});
  @override
  State<Vibes> createState() {
    return _VibesState();
  }
}

class _VibesState extends State<Vibes> {
  final _messagecontroller = TextEditingController();
  @override
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }

  void submitmessage() async {
    final enteredmessage = _messagecontroller.text;
    if (enteredmessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messagecontroller.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('vibes_chat').add({
      'text': enteredmessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _messagecontroller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(
              fillColor: Colors.white,labelStyle: TextStyle(color: Colors.white),
              labelText: 'Send a message...',
            ),
          )),
          IconButton(
              onPressed: submitmessage,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
