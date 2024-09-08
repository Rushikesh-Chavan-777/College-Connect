import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/models/event_model.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});
  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final _titlecontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _timecontroller = TextEditingController();
  DateTime? _selectdate;
  //Category _selectedcategory = Category.leisure;
  @override
  void dispose() {
    _titlecontroller.dispose();
    _locationcontroller.dispose();
    _timecontroller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_titlecontroller.text.trim().isEmpty ||
        _titlecontroller.text.trim().isEmpty ||
        _selectdate == null ||
        _timecontroller.text.trim().isEmpty) {
      //erroe message
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
    FirebaseFirestore.instance.collection('events').add({
      'description': _titlecontroller.text,
      'venue': _locationcontroller.text,
      'date': _selectdate!,
      'time': _timecontroller.text,
      'createdAt': Timestamp.now(),
    });

    //popping any context!
    Navigator.pop(context);
  }

  //function to open calendar
  void _opencalendar() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastdate = DateTime(now.year + 1, now.month, now.day);
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
            controller: _titlecontroller,
            decoration: const InputDecoration(
              label: Text("Event Details"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 50,
                  controller: _locationcontroller,
                  decoration: const InputDecoration(
                    //prefixText: '\$ ',
                    label: Text("Location"),
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
            controller: _timecontroller,
            decoration: const InputDecoration(
              label: Text("Time"),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel event"),
              ),
              ElevatedButton(
                onPressed: _submitExpenses,
                child: const Text("Add Event"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
