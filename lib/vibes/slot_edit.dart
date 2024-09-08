import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/models/event_model.dart';

class SlotEdit extends StatefulWidget {
  const SlotEdit({super.key, required this.doc_id});
  final doc_id;
  @override
  State<SlotEdit> createState() => _SlotEditState();
}

class _SlotEditState extends State<SlotEdit> {//location
  final _intimecontroller = TextEditingController(); //time
  final _outtimecontroller = TextEditingController(); //created by me //out time
  DateTime? _selectdate;
  //Category _selectedcategory = Category.leisure;
  @override
  void dispose() {
    _intimecontroller.dispose();
    _outtimecontroller.dispose();
    super.dispose();
  }

  void _submitExpenses() async {
    if (_intimecontroller.text.trim().isEmpty|| _intimecontroller.text.trim().isEmpty|| _selectdate == null) {
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

        FirebaseFirestore.instance
        .collection('vibes_slot')
        .doc(widget.doc_id)
        .update({"out_time": _outtimecontroller.text});

        FirebaseFirestore.instance
        .collection('vibes_slot')
        .doc(widget.doc_id)
        .update({"in_time": _intimecontroller.text});


        FirebaseFirestore.instance
        .collection('vibes_slot')
        .doc(widget.doc_id)
        .update({"date": _selectdate!});

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
          
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel Edit"),
              ),
              ElevatedButton(
                onPressed: _submitExpenses,
                child: const Text("Add Edit"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}