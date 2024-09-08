import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_connect/widgets/new_event.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {

  
//setting up the notifications  
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('newEvent');
  }
  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }



  @override
  Widget build(BuildContext context) {
    void _openAddExpenseOverlay() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const NewEvent());
    }

    return Scaffold(
      
      //appbar
      appBar: AppBar(
        title: const Text("Gather & Giggle"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No new events found", style: TextStyle(color: Colors.white),),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!", style: TextStyle(color: Colors.white)),
              );
            }

            final loadedmessages = snapshot.data!.docs;

            return SingleChildScrollView(
              //child: Expanded( 
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loadedmessages.length,
                      itemBuilder: (ctx, index) =>  
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 180,
                            //color: Colors.blueGrey,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(loadedmessages[index].get('description'),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.red,
                                      ),
                                      //Text(DateTime.parse(loadedmessages[index].get('date')toString())),
                                      Text(DateFormat.yMMMd().format(loadedmessages[index].get('date').toDate()).toString(), style: TextStyle(color: Colors.white),),
                                      //Text(loadedmessages[index].get('date').toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.pin_drop_rounded,
                                          color: Colors.blue),
                                      Text(loadedmessages[index].get('venue'), style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                        color: Colors.green,
                                      ),
                                      Text(loadedmessages[index].get('time'), style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              //),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              //),
            );
          }),
      backgroundColor:  const Color.fromARGB(67, 158, 158, 158),
    );
  }
}
