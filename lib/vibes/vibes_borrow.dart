import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/vibes/new_borrow.dart';
import 'package:widget_zoom/widget_zoom.dart';

class VibesBorrowScreen extends StatefulWidget {
  const VibesBorrowScreen({super.key});

  @override
  State<VibesBorrowScreen> createState() => _VibesBorrowScreenState();
}

class _VibesBorrowScreenState extends State<VibesBorrowScreen> {
  @override
  Widget build(BuildContext context) {
    void _openAddExpenseOverlay() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const NewBorrowScreen());
    }

    return Scaffold(backgroundColor:const Color.fromARGB(67, 158, 158, 158),
      //backgroundColor: Colors.black,
//appbar
      appBar: AppBar(
        title: const Text("Borrow Instruments"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('vibes_borrow')
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
                child: Text("No logs yet", style: TextStyle(color: Colors.white),),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!", style: TextStyle(color: Colors.white),),
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
                          height: 780,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: double.infinity,
                                child: WidgetZoom(
                                  heroAnimationTag: 'tag',
                                  zoomWidget: Image.network(
                                      loadedmessages[index].get('image'),
                                      fit: BoxFit.cover),
                                ),
                                //)),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.bubble_chart,
                                          color: Colors.blue),
                                      Text(" Item Description",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('description')}', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.person, color: Colors.blue),
                                      Text(" Name of borrower",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('name')}', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.timer_outlined,
                                          color: Colors.green),
                                      Text(" Time of borrow",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontWeight: FontWeight.bold, )),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('in_time')}', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.timer_off_outlined,
                                          color: Colors.red),
                                      Text(" Time of return",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('out_time')}', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.phone, color: Colors.green),
                                      Text(" Contact of the uploader",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('contact')}', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.numbers_outlined, color: Colors.white),
                                      Text(" Roll number",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                          '${loadedmessages[index].get('roll')}', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  loadedmessages[index].get('user_id') ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid //&&
                                      /*loadedmessages[index].get('out_time') ==
                                            null*/
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('vibes_borrow')
                                                    .doc(loadedmessages[index]
                                                        .get('registrar_id'))
                                                    .delete();
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text('Delete', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
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
      //backgroundColor: const Color.fromARGB(240, 255, 255, 255),
    );
  }
}
