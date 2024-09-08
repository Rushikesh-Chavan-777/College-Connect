import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/post_widget.dart';
import 'package:uuid/uuid.dart';

class BuyImagePickerScreen extends StatefulWidget {
  const BuyImagePickerScreen({super.key});
  @override
  State<BuyImagePickerScreen> createState() {
    return _BuyImagePickerScreenState();
  }
}

class _BuyImagePickerScreenState extends State<BuyImagePickerScreen> {
  TextEditingController texteditingcontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController priceeditingcontroller = TextEditingController();
  File? selectedimage;
  var uuid = Uuid();

  @override
  void dispose() {
    texteditingcontroller.dispose();
    contactcontroller.dispose();
    priceeditingcontroller.dispose();
    super.dispose(); 
  }

  void submit() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Posting..."), duration: Duration(seconds: 4)));
    final storageRefer = FirebaseStorage.instance
            .ref()
            .child('buy_images')
            .child('${uuid.v1()}.jpg');
    await storageRefer.putFile(selectedimage!);
    final imageurl = await storageRefer.getDownloadURL();

//trying
    FirebaseFirestore.instance.collection('market_doc').add({
        'image': imageurl,
        'description': texteditingcontroller.text,
        'price': priceeditingcontroller.text,
        'contact': contactcontroller.text,
        'createdAt': Timestamp.now(),       
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
                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
                  child: Column(
                    children: [
                      TextField(
                        textAlign: TextAlign.left,
                        autocorrect: true,
                        controller: texteditingcontroller,
                        decoration: const InputDecoration(
                          labelText: 'Describe what you want to SELL',
                        ),
                      ),
                        TextField(
                    textAlign: TextAlign.left,
                    autocorrect: true,
                    controller: priceeditingcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Asking price for your item',
                    ),
                  ),
                      TextField(
                    textAlign: TextAlign.left,
                    autocorrect: true,
                    controller: contactcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Any of your contact, so you can be approached!',
                    ),
                  ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: submit, child: const Text("Submit"),),
              ],
            ),
          ),
        ),
    );
  }
} 