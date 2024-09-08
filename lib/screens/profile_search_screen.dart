import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/comments_compiler.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ProfileSearchScreen extends StatefulWidget {
  const ProfileSearchScreen({super.key, required this.userid});
  final String userid;

  @override
  State<ProfileSearchScreen> createState() => _ProfileSearchScreenState();
}

class _ProfileSearchScreenState extends State<ProfileSearchScreen> {
  var userData = {};
  var myuserData = {};
  var postdocs;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userid)
          .get();
      var myuserSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('post_doc')
          .where('userId', isEqualTo: widget.userid)
          .get();
      myuserData = myuserSnap.data()!;
      userData = userSnap.data()!;
      postdocs = postSnap.docs; //[7][''];
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile View'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfile(
                userid: widget.userid,
                username: userData['username'],
                image_url: userData['image_url'],
                likes_checker_length: userData['likes'],
                user_posts_length: userData['user_posts'].length,
                yearofgraduation: userData['yearofgraduation']),
            UserBio(userid: widget.userid),
            UserPosts(
                userid: widget.userid,
                postdocs: postdocs,
                myuserData: myuserData),
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  const UserProfile(
      {super.key,
      required this.userid,
      required this.username,
      required this.image_url,
      required this.yearofgraduation,
      required this.likes_checker_length,
      required this.user_posts_length});
  final String userid;

  final username;
  final image_url;
  final yearofgraduation;
  final likes_checker_length;
  final user_posts_length;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WidgetZoom(
                  heroAnimationTag: 'tag',
                  zoomWidget: CircleAvatar(
                    radius: 50,
                    foregroundImage: NetworkImage(widget.image_url),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('${widget.user_posts_length}',
                          style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                      const Text("Posts",
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${widget.likes_checker_length}',
                          style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                      const Text(
                        "Likes",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${widget.yearofgraduation}',
                          style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                      const Text(
                        "Class",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              '${widget.username}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserBio extends StatefulWidget {
  const UserBio({super.key, required this.userid});
  final String userid;

  @override
  State<UserBio> createState() => _UserBioState();
}

class _UserBioState extends State<UserBio> {
  String myuserbio = '';
  String mybatchof = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetch(),
      builder: (ctx, snapper) => Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Batch of $mybatchof",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            Text(
              myuserbio,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetch() async {
    final firebaseuser = await FirebaseAuth.instance.currentUser;
    if (firebaseuser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userid)
          .get()
          .then((ds) {
        myuserbio = ds.data()!['enteredbio1'];
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userid)
          .get()
          .then((ds) {
        mybatchof = ds.data()!['yearofgraduation'];
      });
    }
  }
}

class UserPosts extends StatefulWidget {
  const UserPosts(
      {super.key,
      required this.userid,
      required this.postdocs,
      required this.myuserData});
  final String userid;
  final postdocs;
  final myuserData;

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  //new likes function
  Future<void> likePost(
      String postid, String userId, List likes_checker) async {
    try {
      if (likes_checker.contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance
            .collection('post_doc')
            .doc(postid)
            .update({
          'likes_checker':
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
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
          'likes_checker':
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId) //FirebaseAuth.instance.currentUser!.uid
            .update({'likes': FieldValue.increment(1)});
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Likes being updated shortly. Continue scrolling ;)")));
    } catch (e) {
      //print(e.toString());
    }
  }
  //end of new likes function

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.postdocs.length, //myuserposts,
        itemBuilder: (ctx, index) => Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget.postdocs[index]['user_image']),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${widget.postdocs[index]['username']}',
                            textAlign: TextAlign.left,
                            style: TextStyle( color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "More features to user posts coming soon!")));
                              },
                              icon: Icon(Icons.more_vert_rounded, color: Colors.white))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: GestureDetector(
                      onDoubleTap: () => likePost(
                          widget.postdocs[index]['post_doc_id'],
                          widget.postdocs[index]['userId'],
                          widget.postdocs[index]['likes_checker']),
                      child: WidgetZoom(
                        heroAnimationTag: 'tag',
                        zoomWidget: Image.network(
                          widget.postdocs[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //],
                  ),
                  //),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                likePost(
                                    widget.postdocs[index]['post_doc_id'],
                                    widget.postdocs[index]['userId'],
                                    widget.postdocs[index]['likes_checker']);
                              },
                              icon: widget.postdocs[index]['likes_checker']
                                      .toString()
                                      .contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : Icon(Icons.favorite_outline, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx) => CommentsCompiler(
                                        docid: widget.postdocs[index]
                                            ['post_doc_id'],
                                        name: widget.myuserData['username'],
                                        profilePic:
                                            widget.myuserData['image_url'],
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid));
                              },
                              icon: const Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Send feature update coming soon....!")));
                              },
                              icon: const Icon(Icons.send, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Save your favourite posts feature comming very very soon. Stay tuned ;)")));
                                },
                                icon: Icon(Icons.bookmark_border_rounded, color: Colors.white))
                          ],
                        )
                      ]),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                          '${widget.postdocs[index]['likes_checker'].length} likes', //'${loadedmessages[index].get('likes')} likes',loadedmessages[index].data()['likes_checker'].length
                          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Wrap(
                      children: [
                        Text.rich(
                          TextSpan(
                              text: '${widget.postdocs[index]['username']} ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${widget.postdocs[index]['caption']}',
                                  style: const TextStyle(
                                     color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPost extends StatefulWidget {
  final String imageUrl;

  const UserPost({required this.imageUrl, super.key});

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Image.network(widget.imageUrl),
    );
  }
}
