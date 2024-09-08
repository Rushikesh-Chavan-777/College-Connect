import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/c_comments_compiler.dart';
import 'package:r_connect/widgets/new_confession.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ConfessionsScreen extends StatefulWidget {
  const ConfessionsScreen({super.key});
  @override
  State<ConfessionsScreen> createState() {
    return _ConfessionsScreenState();
  }
}

class _ConfessionsScreenState extends State<ConfessionsScreen> {
//adding the notification stuff
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('newConfession');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

//likes function
  final itemcontroller = ItemScrollController();
  final itemlistener = ItemPositionsListener.create();
  var userlikedapost;
  var thispostlikes;

  //new likes function
  Future<void> likePost(
      String postid, String userId, List likes_checker) async {
    //fetch(postid, userId);
    try {
      if (likes_checker.contains(userId)) {
        await FirebaseFirestore.instance
            .collection('confessions')
            .doc(postid)
            .update({
          'likes_checker': FieldValue.arrayRemove([userId]),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('confessions')
            .doc(postid)
            .update({
          'likes_checker': FieldValue.arrayUnion([userId]),
        });
      }
    } catch (e) {
      //print(e.toString());
    }
  }
  //end of new likes function

  /*Future onlikes(postid, index) async {
    fetch(postid);
    var kill = userlikedapost[FirebaseAuth.instance.currentUser!.uid];
    var isliked;
    //itemcontroller.jumpTo(index: 10);
    if (kill == null) {
      setState(() {
        userlikedapost[FirebaseAuth.instance.currentUser!.uid] = false;
        isliked = userlikedapost[FirebaseAuth.instance.currentUser!.uid];
      });
    }
    isliked = userlikedapost[FirebaseAuth.instance.currentUser!.uid];
    if (isliked == false) {
      setState(() {
        isliked = !isliked;
        thispostlikes = thispostlikes + 1;
      });
      FirebaseFirestore.instance
          .collection('confessions')
          .doc(postid)
          .update({'likes': thispostlikes});

      userlikedapost[FirebaseAuth.instance.currentUser!.uid] = true;
      FirebaseFirestore.instance.collection('confessions').doc(postid).update({
        'likes_checker': {FirebaseAuth.instance.currentUser!.uid: true}
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Click yes to add a like this post!!"),
        action: SnackBarAction(
            label: 'Yes!',
            onPressed: () {
              itemcontroller.jumpTo(index: index);
            }),
      ));
    } else if (isliked == true) {
      return;
    }

    /*else if (isliked == true) {
      isliked = !isliked;
      setState(() {
        myuserlikes = myuserlikes - 1;
        thispostlikes = thispostlikes - 1;
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'likes': myuserlikes});
      FirebaseFirestore.instance
          .collection('post_doc')
          .doc(postid)
          .update({'likes': thispostlikes});
      userlikedapost[FirebaseAuth.instance.currentUser!.uid] = false;
      FirebaseFirestore.instance.collection('post_doc').doc(postid).update({
        'likes_checker': {FirebaseAuth.instance.currentUser!.uid: false}
      });
      fetch(postid);
    }*/
    //itemcontroller.jumpTo(index: 10);
  }*/

//end of likes function

  @override
  Widget build(BuildContext context) {
//method to show modal bottom sheet
    void _openAddExpenseOverlay() {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const NewConfession());
    }

    return Scaffold(
//appbar
      appBar: AppBar(
        title: const Text("Confessions page"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add_to_photos_outlined))
        ],
      ),
//body
      backgroundColor: const Color.fromARGB(67, 158, 158, 158),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('confessions')
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
                  "No new confessions yet. Be the first one to add!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            }

            final loadedmessages = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Column(
                children: [
                  //first instance of the container
                  ScrollablePositionedList.builder(
                    itemScrollController: itemcontroller,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: loadedmessages.length,
                    itemBuilder: (ctx, index) => FutureBuilder(
                      future: fetch(loadedmessages[index].get('docid')),
                      builder: (context, snp) => Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 400,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                Radius.elliptical(20, 10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(loadedmessages[index].get('description'),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),

                          //initiating botton row
                          Row(children: [
                            IconButton(
                              onPressed: () => likePost(
                                  loadedmessages[index].get('docid'),
                                  FirebaseAuth.instance.currentUser!.uid,
                                  loadedmessages[index].get('likes_checker')),
                              icon: loadedmessages[index]
                                      .data()['likes_checker']
                                      .toString()
                                      .contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx) => CCommentsCompiler(
                                        docid: loadedmessages[index]
                                            .get('docid'),
                                        name: userlikedapost,
                                        profilePic: thispostlikes,
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid));
                              },
                              icon: const Icon(
                                  Icons.chat_bubble_outline_outlined,
                                  color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Send feature update comming soon....!")));
                              },
                              icon: const Icon(Icons.send, color: Colors.white),
                            ),
                          ]),
                          //stopping that row
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                  '${loadedmessages[index].data()['likes_checker'].length} likes',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ],
                          ),
                          //stopping number of likes
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  fetch(String docid) async {
    final firebaseuser = FirebaseAuth.instance.currentUser;
    if (firebaseuser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((ds) {
        userlikedapost = ds.data()!['username'];
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((ds) {
        thispostlikes = ds.data()!['image_url'];
      });
    }
  }
}
