//import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
var formatter = DateFormat.yMd();

class EventModel {
  EventModel(
      {required this.description,
      required this.date,
      required this.time,
      required this.venue});
  final String description;
  final DateTime date;
  final String time;
  final String venue;
    String get formatteddate {
    return formatter.format(date);
  }
 
}
//yMd
