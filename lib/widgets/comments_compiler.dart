import 'package:flutter/material.dart';
import 'package:r_connect/widgets/comments_list.dart';
import 'package:r_connect/widgets/new_comment_bar.dart';

class CommentsCompiler extends StatelessWidget {
  const CommentsCompiler(
      {super.key,
      required this.docid,
      required this.uid,
      required this.name,
      required this.profilePic});
  final String docid;
  //final String text;
  final String uid;
  final String name;
  final String profilePic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
              child: CommentList(
            docid: docid,
            name: name,
            profilePic: profilePic,
            uid: uid,
          )),
          NewComment(
            docid: docid,
            name: name,
            profilePic: profilePic,
            uid: uid,
          ),
        ],
      ),
    );
  }
}
