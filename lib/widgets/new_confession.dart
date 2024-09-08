import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewConfession extends StatefulWidget {
  const NewConfession({super.key});
  @override
  State<NewConfession> createState() => _NewConfessionState();
}

class _NewConfessionState extends State<NewConfession> {
  final _titlecontroller = TextEditingController();

  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_titlecontroller.text.trim().isEmpty ||
        _titlecontroller.text.trim().isEmpty) {
      //error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid data"),
                content: const Text("Please enter a non-null confession!"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }

    //throwing everything to the firestore
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    /*FirebaseFirestore.instance.collection('confessions').add({
      'description': _titlecontroller.text,
      'date': DateTime.now(),
      'createdAt': Timestamp.now(),
      'userId' : user.uid,
      'userName' : userData.data()!['username'],
      'likes_checker': {}, 
    });*/
    //
    var newDocRef = FirebaseFirestore.instance.collection('confessions').doc();
    var newDocId = newDocRef.id;
    newDocRef.set({
      'description': _titlecontroller.text,
      'date': DateTime.now(),
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['username'],
      'likes_checker': [],//{}
      'docid': newDocId,
      'likes': 0,
      'comments': [],
      'comments_image': [],
      'comments_name': [],
      'comments_user_id': [],
      'comments_timestamp': [],
    });

    //popping any context!
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLines: 10,
            controller: _titlecontroller,
            decoration: const InputDecoration(
              label: Text("Confess here"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              hintText:
                  'Speak your heart out without any user(not even the creators) ever knowing who you are at all. You have a lovely chance, why not try ;).',
            ),
          ),

//row to add or save the confession
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenses,
                child: const Text("Add Confession"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
