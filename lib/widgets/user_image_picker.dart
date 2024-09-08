import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onpickimage});
  final void Function(File pickedimage) onpickimage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
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
        CircleAvatar(
          radius: 40,
          foregroundImage:
              userimagefile != null ? FileImage(userimagefile!) : null,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
            onPressed: pickimage,
            icon: const Icon(Icons.image),
            label: const Text("Add image(Mandatory)")),
      ],
    );
  }
}
