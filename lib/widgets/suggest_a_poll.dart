import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuggestAPoll extends StatefulWidget {
  const SuggestAPoll({super.key});
  @override
  State<SuggestAPoll> createState() => _SuggestAPollState();
}

class _SuggestAPollState extends State<SuggestAPoll> {
  final _titlecontroller = TextEditingController();
  final _option1controller = TextEditingController();
  final _option2controller = TextEditingController();
  final _option3controller = TextEditingController();
  final _option4controller = TextEditingController();

  @override
  void dispose() {
    _titlecontroller.dispose();
    _option1controller.dispose();
    _option2controller.dispose();
    _option3controller.dispose();
    _option4controller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_titlecontroller.text.trim().isEmpty ||
        _option1controller.text.trim().isEmpty ||
        _option2controller.text.trim().isEmpty ||
        _option3controller.text.trim().isEmpty ||
        _option4controller.text.trim().isEmpty) {
      //error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid data"),
                content: const Text(
                    "Please enter a correct value of title or options. They are compulsory fields!"),
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
    FirebaseFirestore.instance.collection('poll_suggestion').add({
      'question': _titlecontroller.text,
      'option1': _option1controller.text,
      'option2': _option2controller.text,
      'option3': _option3controller.text,
      'option4': _option4controller.text,
      'time': Timestamp.now(),
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Poll suggestion sent succesfully!")));

    //popping any context!
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
//text field to take in question!!
          TextField(
            controller: _titlecontroller,
            decoration: const InputDecoration(
              label: Text("Poll Question Suggestion!"),
            ),
          ),
//text field to take in option1!!
          TextField(
            controller: _option1controller,
            decoration: const InputDecoration(
              label: Text("Option 1 suggestion!"),
            ),
          ),
//text field to take in question!!
          TextField(
            controller: _option2controller,
            decoration: const InputDecoration(
              label: Text("Option 2 suggestion!"),
            ),
          ),
//text field to take in question!!
          TextField(
            controller: _option3controller,
            decoration: const InputDecoration(
              label: Text("Option 3 suggestion!"),
            ),
          ),
//text field to take in question!!
          TextField(
            controller: _option4controller,
            decoration: const InputDecoration(
              label: Text("Option 4 suggestion!"),
            ),
          ),

//buttons to add or cancel sending this suggestion!!
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
                child: const Text("Submit Poll Suggestion!"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
