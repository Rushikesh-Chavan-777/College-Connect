import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/models/event_model.dart';

class NewSlot extends StatefulWidget {
  const NewSlot({super.key});
  @override
  State<NewSlot> createState() => _NewSlotState();
}

class _NewSlotState extends State<NewSlot> {
  final _namecontroller = TextEditingController(); //title
  final _rollcontroller = TextEditingController(); //location
  final _intimecontroller = TextEditingController(); //time
  final _outtimecontroller = TextEditingController(); //created by me //out time
  final _contactcontroller = TextEditingController(); //contact
  DateTime? _selectdate;
  //Category _selectedcategory = Category.leisure;
  @override
  void dispose() {
    _namecontroller.dispose();
    _rollcontroller.dispose();
    _intimecontroller.dispose();
    _outtimecontroller.dispose();
    _contactcontroller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_namecontroller.text.trim().isEmpty ||
        _rollcontroller.text.trim().isEmpty ||
        _selectdate == null ||
        _intimecontroller.text.trim().isEmpty|| _contactcontroller.text.trim().isEmpty) {
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

//throwing everything to the firestore
    var newDocRef = FirebaseFirestore.instance.collection('vibes_slot').doc();
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
    });

    //popping any context!
    Navigator.pop(context);
  }

  //function to open calendar
  void _opencalendar() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastdate = DateTime(now.year, now.month + 1, now.day);
    final datepicker = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastdate);
    setState(() {
      _selectdate = datepicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _namecontroller,
            decoration: const InputDecoration(
              label: Text("Name"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 50,
                  controller: _rollcontroller,
                  decoration: const InputDecoration(
                    //prefixText: '\$ ',
                    label: Text("Roll Number(s)"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16),
                    Text(_selectdate == null
                        ? 'No date selected'
                        : formatter
                            .format(_selectdate!)
                            .toString() /*: formatter.format(_selectdate!).toString()*/),
                    IconButton(
                        onPressed: _opencalendar,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          TextField(
            controller: _intimecontroller,
            decoration: const InputDecoration(
              label: Text("In Time"),
            ),
          ),
          TextField(
            controller: _outtimecontroller,
            decoration: const InputDecoration(
              label: Text("Out Time"),
            ),
          ),
           TextField(
            controller: _contactcontroller,
            decoration: const InputDecoration(
              label: Text("Contact"),
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
                child: const Text("Add Entry"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}