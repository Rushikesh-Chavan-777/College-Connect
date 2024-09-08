import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CCommentList extends StatefulWidget {
  const CCommentList(
      {super.key,
      required this.docid,
      required this.uid,
      required this.name,
      required this.profilePic});
  final String docid;
  final String uid;
  final String name;
  final String profilePic;
  @override
  State<CCommentList> createState() {
    return _CCommentListState();
  }
}

class _CCommentListState extends State<CCommentList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('confessions')
            .doc(widget.docid)
            .collection('comments1')
            .orderBy('date_published', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          

          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              shrinkWrap: true,
              itemCount:
                  (snapshot.data! as dynamic).docs.length, //comments.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            foregroundImage: NetworkImage(
                                (snapshot.data! as dynamic)
                                    .docs[index]
                                    .get('profilePic'))), //userimages[index]
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  (snapshot.data! as dynamic)
                                      .docs[index]
                                      .get('name'), //usernames[index]
                                  style: const TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              Text((snapshot.data! as dynamic)
                                  .docs[index]
                                  .get('text'), style: TextStyle(color: Colors.white),), //comments[index]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
