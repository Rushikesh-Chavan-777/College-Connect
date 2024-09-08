import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_connect/vibes/new_slot.dart';
import 'package:r_connect/vibes/slot_edit.dart';

class VibesSlotScreen extends StatefulWidget {
  const VibesSlotScreen({super.key});

  @override
  State<VibesSlotScreen> createState() => _VibesSlotScreenState();
}

class _VibesSlotScreenState extends State<VibesSlotScreen> {


  @override
  Widget build(BuildContext context) {
    void _openAddExpenseOverlay() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const NewSlot());
    }

    void _edittime(String doc_id) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => SlotEdit(doc_id: doc_id));
    }

    return Scaffold(backgroundColor:const Color.fromARGB(67, 158, 158, 158),
      //appbar
      appBar: AppBar(
        title: const Text("Vibes Slot Booking"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('vibes_slot')
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
                child: Text("No new logs found", style: TextStyle(color: Colors.white),),
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
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(loadedmessages[index].get('name'),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                    ),
                                    //Text(DateTime.parse(loadedmessages[index].get('date')toString())),
                                    Text(DateFormat.yMMMd()
                                        .format(loadedmessages[index]
                                            .get('date')
                                            .toDate())
                                        .toString(), style: TextStyle(color: Colors.white),),
                                    //Text(loadedmessages[index].get('date').toString()),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.numbers_outlined,
                                        color: Colors.blue),
                                    Text(loadedmessages[index].get('roll'), style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      color: Colors.green,
                                    ),
                                    Text(loadedmessages[index].get('in_time'), style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer_off_outlined,
                                      color: Color.fromARGB(220, 244, 67, 54),
                                    ),
                                    Text(loadedmessages[index].get('out_time'), style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                //const SizedBox(height: 10),
                                loadedmessages[index].get('user_id') ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid //&&
                                        /*loadedmessages[index].get('out_time') ==
                                            null*/
                                    ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              _edittime(loadedmessages[index]
                                                  .get('registrar_id'));
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                                Text('Edit', style: TextStyle(color: Colors.white),),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
                                    : Container(),
                                loadedmessages[index].get('user_id') ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid //&&
                                        /*loadedmessages[index].get('out_time') ==
                                            null*/
                                    ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance.collection('vibes_slot').doc(loadedmessages[index].get('registrar_id')).delete();
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
      //backgroundColor: const Color.fromARGB(240, 255, 255, 255),
    );
  }
}