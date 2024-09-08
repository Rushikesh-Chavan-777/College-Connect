import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_connect/vibes/new_registrar.dart';
import 'package:r_connect/vibes/reg_out_edit.dart';

class VibesRegistrarScreen extends StatefulWidget {
  const VibesRegistrarScreen({super.key});

  @override
  State<VibesRegistrarScreen> createState() => _VibesRegistrarScreenState();
}

class _VibesRegistrarScreenState extends State<VibesRegistrarScreen> {
  @override
  Widget build(BuildContext context) {
    void _openAddExpenseOverlay() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const NewRegistrar());
    }

    void _outtime(String doc_id) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => OutRegistrar(
                doc_id: doc_id,
              ));
    }

    return Scaffold(
      //appbar
      appBar: AppBar(
        title: const Text("Vibes Registrar"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('vibes_registrar')
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
                  "No new logs found",
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
                          height: 260,
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
                                    color: Colors.white,//(220, 244, 67, 54),
                                  ),
                                  //Text(DateTime.parse(loadedmessages[index].get('date')toString())),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(loadedmessages[index]
                                            .get('date')
                                            .toDate())
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  //Text(loadedmessages[index].get('date').toString()),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.numbers_outlined,
                                      color: Colors.blue),
                                  Text(
                                    loadedmessages[index].get('roll'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    loadedmessages[index].get('in_time'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer_off_outlined,
                                    color: Color.fromARGB(220, 244, 67, 54),
                                  ),
                                  Text(
                                    loadedmessages[index].get('out_time'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              //const SizedBox(height: 10),
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
                                                .collection('vibes_registrar')
                                                .doc(loadedmessages[index]
                                                    .get('registrar_id'))
                                                .update({
                                              "out_time": DateFormat.jm()
                                                  .format(DateTime.now())
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Add Out Time',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
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
      backgroundColor: const Color.fromARGB(
          67, 158, 158, 158), //const Color.fromARGB(240, 255, 255, 255),
    );
  }
}
