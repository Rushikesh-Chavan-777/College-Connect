import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/post_widget.dart';
import 'package:uuid/uuid.dart';

class NewBorrowScreen extends StatefulWidget {
  const NewBorrowScreen({super.key});
  @override
  State<NewBorrowScreen> createState() {
    return _NewBorrowScreenState();
  }
}

class _NewBorrowScreenState extends State<NewBorrowScreen> {
  TextEditingController descriptioneditingcontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController intimecontroller = TextEditingController();
  TextEditingController outtimecontroller = TextEditingController();
  TextEditingController rollcontroller = TextEditingController();
  TextEditingController nameeditingcontroller = TextEditingController();
  File? selectedimage;
  var uuid = Uuid();

  @override
  void dispose() {
    descriptioneditingcontroller.dispose();
    contactcontroller.dispose();
    intimecontroller.dispose();
    outtimecontroller.dispose();
    rollcontroller.dispose();
    nameeditingcontroller.dispose();
    super.dispose();
  }

  void submit() async {
    if (nameeditingcontroller.text.trim().isEmpty ||
        descriptioneditingcontroller.text.trim().isEmpty ||
        rollcontroller.text.trim().isEmpty ||
        outtimecontroller.text.trim().isEmpty ||
        intimecontroller.text.trim().isEmpty ||
        contactcontroller.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid data"),
                content: const Text(
                    "Please enter a correct value of date, title or amount"),
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Posting..."), duration: Duration(seconds: 4)));
    final storageRefer = FirebaseStorage.instance
        .ref()
        .child('borrow_images')
        .child('${uuid.v1()}.jpg');
    await storageRefer.putFile(selectedimage!);
    final imageurl = await storageRefer.getDownloadURL();

//throwing everything to the firestore
    var newDocRef = FirebaseFirestore.instance.collection('vibes_borrow').doc();
    var newDocId = newDocRef.id;
    newDocRef.set({
      'name': nameeditingcontroller.text,
      'image': imageurl,
      'description': descriptioneditingcontroller.text,
      'roll': rollcontroller.text,
      'in_time': intimecontroller.text,
      'out_time': outtimecontroller.text,
      'contact': contactcontroller.text,
      'createdAt': Timestamp.now(),
      'registrar_id': newDocId,
      'user_id': FirebaseAuth.instance.currentUser!.uid,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PostImagePicker(
                onpickimage: (pickedimage) {
                  selectedimage = pickedimage;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 16, left: 16),
                child: Column(
                  children: [
                    TextField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      controller: descriptioneditingcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Describe what you are borrowing',
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      controller: nameeditingcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      controller: intimecontroller,
                      decoration: const InputDecoration(
                        labelText:
                            'At what date and time are you borrowing the item',
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      controller: outtimecontroller,
                      decoration: const InputDecoration(
                        labelText:
                            'At what date and time do you expect to return the item',
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      controller: rollcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Roll Number',
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      controller: contactcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Your contact',
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
