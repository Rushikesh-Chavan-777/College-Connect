import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/post_widget.dart';
import 'package:uuid/uuid.dart';

class PostImagePickerScreen extends StatefulWidget {
  const PostImagePickerScreen({super.key});
  @override
  State<PostImagePickerScreen> createState() {
    return _PostImagePickerScreenState();
  }
}

class _PostImagePickerScreenState extends State<PostImagePickerScreen> {
  TextEditingController texteditingcontroller = TextEditingController();
  File? selectedimage;
  var myusername;
  var myuserimage;
  var myposter;
  var uuid = Uuid();

  @override
  void dispose() {
    texteditingcontroller.dispose();
    super.dispose();
  }

  void submit() async {

    if(texteditingcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("A caption is mandatory in order to post"), duration: Duration(seconds: 2)));
        return;
    }
    if(selectedimage == null) {
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Please enter an image in order to post"), duration: Duration(seconds: 2)));
        return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Posting..."), duration: Duration(seconds: 5)));
    final storageRefer = FirebaseStorage.instance
        .ref()
        .child('post_images')
        .child('${uuid.v1()}.jpg');
    await storageRefer.putFile(selectedimage!);
    final imageurl = await storageRefer.getDownloadURL();

//trying
    var newDocRef = FirebaseFirestore.instance.collection('post_doc').doc();
    var newDocId = newDocRef.id;
    newDocRef.set({
      'image': imageurl,
      'caption': texteditingcontroller.text,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'likes': 0,
      'createdAt': Timestamp.now(),
      'username': myusername,
      'user_image': myuserimage,
      'likes_checker': [],  //{} //FirebaseAuth.instance.currentUser!.uid: false
      'post_doc_id': newDocId,
      'comments_user_id': [],
      'comments': [],
      'comments_name': [],
      'comments_image': [],
      'comments_timestamp': [],
    });
    setState(() {
      myposter = myposter + 1;
    });
    var list = [imageurl];
    var caplist = [texteditingcontroller.text];

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"post_captions": FieldValue.arrayUnion(caplist)});
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"user_posts": FieldValue.arrayUnion(list)});
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'posts': myposter});

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetch(),
      builder: (context, snapshot) => Scaffold(
        body: Center(
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
                child: TextField(
                  textAlign: TextAlign.left,
                  autocorrect: true,
                  controller: texteditingcontroller,
                  decoration: const InputDecoration(
                    labelText: 'A caption for your post!',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: submit,
                child: const Text("Post"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fetch() async {
    final firebaseuser = await FirebaseAuth.instance.currentUser;
    if (firebaseuser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseuser.uid)
          .get()
          .then((ds) {
        myusername = ds.data()!['username'];
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseuser.uid)
          .get()
          .then((ds) {
        myuserimage = ds.data()!['image_url'];
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseuser.uid)
          .get()
          .then((ds) {
        myposter = ds.data()!['posts'];
      });
    }
  }
}
