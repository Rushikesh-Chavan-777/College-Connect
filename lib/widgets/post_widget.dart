import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostImagePicker extends StatefulWidget {
  const PostImagePicker({super.key, required this.onpickimage});
  final void Function(File pickedimage) onpickimage;

  @override
  State<PostImagePicker> createState() {
    return _PostImagePickerState();
  }
}

class _PostImagePickerState extends State<PostImagePicker> {
  File? userimagefile;
  void pickimage() async {
    final pickedimage = await ImagePicker() 
        .pickImage(source: ImageSource.gallery, imageQuality: 100, /*maxWidth: 150*/);
    if (pickedimage == null) {
      return;
    }
    setState(() {
      userimagefile = File(pickedimage.path);
    });
    widget.onpickimage(userimagefile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:  MediaQuery.of(context).size.height*0.35,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            image: userimagefile != null ? DecorationImage(image: FileImage(userimagefile!), fit: BoxFit.cover) : null,
          ),
        ),
        TextButton.icon(
            onPressed: pickimage,
            icon: const Icon(Icons.image),
            label: const Text("Add image"),),
      ],
    );
  }
}