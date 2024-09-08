import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/models/event_model.dart';

class NewRide extends StatefulWidget {
  const NewRide({super.key});
  @override
  State<NewRide> createState() => _NewRideState();
}

class _NewRideState extends State<NewRide> {
  final _titlecontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _timecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _moneycontroller = TextEditingController();
  DateTime? _selectdate;
  @override
  void dispose() {
    _titlecontroller.dispose();
    _locationcontroller.dispose();
    _timecontroller.dispose();
    _emailcontroller.dispose();
    _phonecontroller.dispose();
    _numbercontroller.dispose();
    _moneycontroller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_titlecontroller.text.trim().isEmpty ||
        _titlecontroller.text.trim().isEmpty ||
        _selectdate == null ||
        _timecontroller.text.trim().isEmpty ||
        _emailcontroller.text.trim().isEmpty) {
      //error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid data"),
                content: const Text(
                    "Please enter valid data in all fields!. Phone number is not mandatory!!"),
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
    FirebaseFirestore.instance.collection('ride').add({
      'from': _titlecontroller.text,
      'to': _locationcontroller.text,
      'date': _selectdate!,
      'time': _timecontroller.text,
      'email': _emailcontroller.text,
      'phone': _phonecontroller.text,
      'number': _numbercontroller.text,
      'money': _moneycontroller.text,
      'createdAt': Timestamp.now(),
    });

    //popping any context!
    Navigator.pop(context);
  }

  //function to open calendar
  void _opencalendar() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    final datepicker = await showDatePicker(
        context: context, firstDate: now, lastDate: lastDate);
    setState(() {
      _selectdate = datepicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _titlecontroller,
              decoration: const InputDecoration(
                label: Text("From"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 50,
                    controller: _locationcontroller,
                    decoration: const InputDecoration(
                      label: Text("To"),
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
            Expanded(
              child: TextField(
                maxLength: 50,
                controller: _phonecontroller,
                decoration: const InputDecoration(
                  label: Text("Phone"),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                maxLength: 50,
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                maxLength: 50,
                controller: _numbercontroller,
                decoration: const InputDecoration(
                  label: Text("Max. Number of members required"),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                maxLength: 50,
                controller: _moneycontroller,
                decoration: const InputDecoration(
                  label: Text(
                      "Approximate expenditure if max members are achieved!"),
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel request"),
                ),
                ElevatedButton(
                  onPressed: _submitExpenses,
                  child: const Text("Add request"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
