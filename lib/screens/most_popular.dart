import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/screens/profile_search_screen.dart';

class MostPoppularScreen extends StatelessWidget {
  const MostPoppularScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("The new rank holders"),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
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
                  "No new messages found",
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
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    "A look at the top most popular students in college",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 30),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: loadedmessages.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileSearchScreen(
                                userid: loadedmessages[index].get('userId'))));
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('${index + 1}', style: TextStyle(color: Colors.white),),
                              const SizedBox(width: 30),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    loadedmessages[index].get('image_url')),
                              ),
                              const SizedBox(width: 30),
                              Text(loadedmessages[index].get('username'), style: TextStyle(color: Colors.white),),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${loadedmessages[index].get('likes')}', style: TextStyle(color: Colors.white),),
                                    const Text("likes", style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${loadedmessages[index].get('yearofgraduation')}", style: TextStyle(color: Colors.white),),
                                    const Text("class", style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            );
          }),
    );
  }
}
