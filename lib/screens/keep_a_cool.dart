import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_connect/widgets/new_ride.dart';

class CabScreen extends StatefulWidget {
  const CabScreen({super.key});

  @override
  State<CabScreen> createState() => _CabScreenState();
}

class _CabScreenState extends State<CabScreen> {
//Adding the notification. Manual control for now!
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('newPool');
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
          builder: (ctx) => const NewRide());
    }

    return Scaffold(
//appbar
      appBar: AppBar(
        title: const Text("Simple Cab sharing page"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('ride')
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
                child: Text(
                  "No new cab sharing requests found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Something went wrong!",
                  style: TextStyle(color: Colors.white),
                ),
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
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 510,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text('From ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const Icon(Icons.local_taxi, color: Colors.white,),
                                    Text(
                                        ' ${loadedmessages[index].get('from')}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text('To     ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const Icon(Icons.pin_drop_rounded,
                                        color: Colors.white),
                                    Text(' ${loadedmessages[index].get('to')}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Color.fromARGB(220, 244, 67, 54),
                                      ),
                                      Text(" Date of journey",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          ' ${DateFormat.yMMMd().format(loadedmessages[index].get('date').toDate()).toString()}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      Text(" Time of journey",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          ' ${loadedmessages[index].get('time')}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.group,
                                        color: Colors.green,
                                      ),
                                      Text(" Number of people required",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('number')}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.price_change,
                                        color: Colors.orange,
                                      ),
                                      Text(
                                          " Approx. price(if max members are achieved)",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('money')}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: Colors.blue,
                                      ),
                                      Text(" Email of the uploader",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          ' ${loadedmessages[index].get('email')}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                      ),
                                      Text(" Phone No. of the uploader",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          ' ${loadedmessages[index].get('phone')}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //),
            );
          }),
      backgroundColor: const Color.fromARGB(
          67, 158, 158, 158), //const Color.fromARGB(240, 255, 255, 255),
    );
  }
}
