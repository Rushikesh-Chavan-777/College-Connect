import 'package:flutter/material.dart';
import 'package:r_connect/widgets/c_comments_list.dart';
import 'package:r_connect/widgets/c_new_comment_bar.dart';

class CCommentsCompiler extends StatelessWidget {
  const CCommentsCompiler(
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
              child: CCommentList(
            docid: docid,
            name: name,
            profilePic: profilePic,
            uid: uid,
          )),
          CNewComment(
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
