import 'package:better_polls/better_polls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/suggest_a_poll.dart';

class PollView extends StatefulWidget {
  const PollView({Key? key}) : super(key: key);

  @override
  State<PollView> createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {
//adding the notification stuff!

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('newPoll');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

//end of the notification stuff!

  String user = FirebaseAuth.instance.currentUser!.uid; //"king@mail.com";
  Map<String, int> usersWhoVoted = {};
  /*{
    //'sam@mail.com': 0,
    //'mike@mail.com': 0,
    //'john@mail.com': 0,
    //'kenny@mail.com': 0,
  };*/
  String creator = "eddy@mail.com";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('polls').snapshots(),
        builder: (context, snapshot) {
          final loadedmessages = snapshot.data!.docs;

          usersWhoVoted = loadedmessages[0].get('map').cast<String, int>();
          double option1 = loadedmessages[0].get('option1_int');
          double option2 = loadedmessages[0].get('option2_int');
          double option3 = loadedmessages[0].get('option3_int');
          double option4 = loadedmessages[0].get('option4_int');
          return Scaffold(backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: const Text("Poll of the day!"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                        //backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => const SuggestAPoll());
                  },
                )
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Polls(
                  children: [
                    // This cannot be less than 2, else will throw an exception
                    Polls.options(
                        title: loadedmessages[0].get('option1_string'),
                        value: loadedmessages[0].get('option1_int')), //option1
                    Polls.options(
                        title: loadedmessages[0].get('option2_string'),
                        value: loadedmessages[0].get('option2_int')),
                    Polls.options(
                        title: loadedmessages[0].get('option3_string'),
                        value: loadedmessages[0].get('option3_int')),
                    Polls.options(
                        title: loadedmessages[0].get('option4_string'),
                        value: loadedmessages[0].get('option4_int')),
                  ],
                  optionBarRadius: 24,
                  borderWidth: 1,
                  optionHeight: 50,
                  optionSpacing: 12,
                  question: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      loadedmessages[0].get('question'),
                      style: const TextStyle(
                        color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  currentUser: user,
                  creatorID: creator,
                  voteData: usersWhoVoted,
                  userChoice: usersWhoVoted[user],
                  onVoteBorderColor: Colors.deepPurple,
                  voteCastedBorderColor: Colors.orange,
                  onVoteBackgroundColor: Colors.blue,
                  leadingBackgroundColor: Colors.lightGreen,
                  backgroundColor: const Color.fromARGB(240, 255, 255, 255),
                  voteCastedBackgroundColor: Colors.grey,//grey
                  onVote: (choice) {
                    setState(() {
                      usersWhoVoted[user] = choice;
                    });
                    if (choice == 0) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection('polls')
                            .doc('KwXIFWrJOmXEaSyfjQf2')
                            .update({'option1_int': FieldValue.increment(1)});

                        FirebaseFirestore.instance
                            .collection('polls')
                            .doc('KwXIFWrJOmXEaSyfjQf2')
                            .set({
                          'map': {FirebaseAuth.instance.currentUser!.uid: 0}
                        }, SetOptions(merge: true));
                      });
                    }

                    if (choice == 1) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection('polls')
                            .doc('KwXIFWrJOmXEaSyfjQf2')
                            .update({'option2_int': FieldValue.increment(1)});

                        FirebaseFirestore.instance
                            .collection('polls')
                            .doc('KwXIFWrJOmXEaSyfjQf2')
                            .set({
                          'map': {FirebaseAuth.instance.currentUser!.uid: 1}
                        }, SetOptions(merge: true));
                      });
                    }

                    if (choice == 2) {
                      setState(() {
                        //option1 += 1;
                        FirebaseFirestore.instance
                            .collection('polls')
                            .doc('KwXIFWrJOmXEaSyfjQf2')
                            .update({'option3_int': FieldValue.increment(1)});
                      });

                      FirebaseFirestore.instance
                          .collection('polls')
                          .doc('KwXIFWrJOmXEaSyfjQf2')
                          .set({
                        'map': {FirebaseAuth.instance.currentUser!.uid: 2}
                      }, SetOptions(merge: true));
                    }

                    if (choice == 3) {
                      setState(() {
                        //option1 += 1;
                        FirebaseFirestore.instance
                            .collection('polls')
                            .doc('KwXIFWrJOmXEaSyfjQf2')
                            .update({'option4_int': FieldValue.increment(1)});
                      });

                      FirebaseFirestore.instance
                          .collection('polls')
                          .doc('KwXIFWrJOmXEaSyfjQf2')
                          .set({
                        'map': {FirebaseAuth.instance.currentUser!.uid: 3}
                      }, SetOptions(merge: true));
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}



/*FirebaseFirestore.instance
                              .collection('polls')
                              .doc('KwXIFWrJOmXEaSyfjQf2')
                              .update({'option1_int': option1});*/
