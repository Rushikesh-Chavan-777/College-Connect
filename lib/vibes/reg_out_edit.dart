import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OutRegistrar extends StatefulWidget {
  const OutRegistrar({super.key, required this.doc_id});
  final doc_id;
  @override
  State<OutRegistrar> createState() => _OutRegistrarState();
}

class _OutRegistrarState extends State<OutRegistrar> {
  final _outtimecontroller = TextEditingController(); //created by me

  @override
  void dispose() {
    _outtimecontroller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_outtimecontroller.text.trim().isEmpty) {
      //error message
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

/*//throwing everything to the firestore
    var newDocRef = FirebaseFirestore.instance.collection('vibes_registrar').doc();
    var newDocId = newDocRef.id;
    newDocRef.set({
      'name': _namecontroller.text,
      'roll': _rollcontroller.text,
      'date': _selectdate!,
      'in_time': _intimecontroller.text,
      'out_time': _outtimecontroller.text,
      'createdAt': Timestamp.now(),
      'registrar_id': newDocId,
      'user_id': FirebaseAuth.instance.currentUser!.uid,
    });*/

    //throwing everything to the firestore
    /*FirebaseFirestore.instance.collection('vibes_registrar').add({
      'name': _namecontroller.text,
      'roll': _rollcontroller.text,
      'date': _selectdate!,
      'in_time': _intimecontroller.text,
      'out_time': _outtimecontroller.text,
      'createdAt': Timestamp.now(),
    });*/

    FirebaseFirestore.instance
        .collection('vibes_registrar')
        .doc(widget.doc_id)
        .update({"out_time": _outtimecontroller.text});

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
            controller: _outtimecontroller,
            decoration: const InputDecoration(
              label: Text("Out Time"),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel Entry"),
              ),
              ElevatedButton(
                onPressed: _submitExpenses,
                child: const Text("Add Out Time"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
