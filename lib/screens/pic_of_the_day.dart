import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_connect/screens/profile_search_screen.dart';
import 'package:r_connect/widgets/comments_compiler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:widget_zoom/widget_zoom.dart';

class PictureOfTheDayScreen extends StatefulWidget {
  const PictureOfTheDayScreen({super.key});

  @override
  State<PictureOfTheDayScreen> createState() => _PictureOfTheDayScreenState();
}

class _PictureOfTheDayScreenState extends State<PictureOfTheDayScreen> {
  final itemcontroller = ItemScrollController();
  var userlikedapost;
  var myuserlikes;
  var thispostlikes;

  //new likes function
  Future<void> likePost(
      String postid, String userId, List likes_checker) async {
    //fetch(postid, userId);
    try {
      if (likes_checker.contains(userId)) {
        await FirebaseFirestore.instance
            .collection('post_doc')
            .doc(postid)
            .update({
          'likes_checker': FieldValue.arrayRemove([userId]),
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId) //FirebaseAuth.instance.currentUser!.uid
            .update({'likes': FieldValue.increment(-1)});
      } else {
        await FirebaseFirestore.instance
            .collection('post_doc')
            .doc(postid)
            .update({
          'likes_checker': FieldValue.arrayUnion([userId]),
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(userId) //FirebaseAuth.instance.currentUser!.uid
            .update({'likes': FieldValue.increment(1)});
      }
    } catch (e) {
      //print(e.toString());
    }
  }
  //end of new likes function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
//appbar
      appBar: AppBar(
        title: const Text("Most liked posts"),
        backgroundColor: Colors.redAccent,
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('post_doc')
              .orderBy('likes', descending: true)
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
                  "No new events found",
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

            return ScrollablePositionedList.builder(
                itemScrollController: itemcontroller,
                shrinkWrap: true,
                itemCount: loadedmessages.length,
                itemBuilder: (ctx, index) => FutureBuilder(
                      future: fetch(loadedmessages[index].get('post_doc_id')),
                      builder: (context, snaper) => SingleChildScrollView(
                          child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ProfileSearchScreen(
                                                        userid: loadedmessages[
                                                                index]
                                                            .get('userId'))));
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                loadedmessages[index]
                                                    .get('user_image')),
                                          ),
                                          const SizedBox(width: 16),
                                          Text(
                                            loadedmessages[index]
                                                .get('username'),
                                            textAlign: TextAlign.left,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "More features to user posts coming soon!")));
                                            },
                                            icon: Icon(
                                              Icons.more_vert_rounded,
                                              color: Colors.white,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onDoubleTap: () => likePost(
                                        loadedmessages[index]
                                            .get('post_doc_id'),
                                        FirebaseAuth.instance.currentUser!.uid,
                                        loadedmessages[index]
                                            .get('likes_checker')),
                                    child: WidgetZoom(
                                      heroAnimationTag: 'tag',
                                      zoomWidget: Image.network(
                                        loadedmessages[index].get('image'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => likePost(
                                                loadedmessages[index]
                                                    .get('post_doc_id'),
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                loadedmessages[index]
                                                    .get('likes_checker')),
                                            icon: loadedmessages[index]
                                                    .data()['likes_checker']
                                                    .toString()
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)
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
                                                  builder: (ctx) =>
                                                      CommentsCompiler(
                                                          docid: loadedmessages[
                                                                  index]
                                                              .get(
                                                                  'post_doc_id'),
                                                          name: myuserlikes,
                                                          profilePic:
                                                              thispostlikes,
                                                          uid: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid));
                                            },
                                            icon: const Icon(
                                              Icons.comment,
                                              color: Colors.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Send feature update comming soon....!")));
                                            },
                                            icon: const Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Save your favourite posts feature comming very very soon. Stay tuned ;)")));
                                            },
                                            icon: Icon(
                                              Icons.bookmark_border,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                        '${loadedmessages[index].data()['likes_checker'].length} likes', //'${loadedmessages[index].get('likes')} likes'
                                        style: const TextStyle(
                                          color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Wrap(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                            text:
                                                '${loadedmessages[index].get('username')} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: loadedmessages[index]
                                                    .get('caption'),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (ctx) => CommentsCompiler(
                                              docid: loadedmessages[index]
                                                  .get('post_doc_id'),
                                              name: myuserlikes,
                                              profilePic: thispostlikes,
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10, left: 10, top: 5),
                                      child: Text(
                                        "View all comments",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: Text(
                                      DateFormat.yMMMd().format(
                                          loadedmessages[index]
                                              .get('createdAt')
                                              .toDate()),
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ));
            //);
          }),
    );
  }

  fetch(String docid) async {
    final firebaseuser = FirebaseAuth.instance.currentUser;
    if (firebaseuser != null) {
      await FirebaseFirestore.instance
          .collection('post_doc')
          .doc(docid)
          .get()
          .then((ds) {
        userlikedapost = ds.data()!['likes_checker'];
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((ds) {
        thispostlikes = ds.data()!['image_url'];
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid) //firebaseuser.uid
          .get()
          .then((ds) {
        myuserlikes = ds.data()!['username'];
      });
    }
  }
}
