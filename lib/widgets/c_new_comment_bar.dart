import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CNewComment extends StatefulWidget {
  const CNewComment(
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
  State<CNewComment> createState() {
    return _CNewCommentState();
  }
}

class _CNewCommentState extends State<CNewComment> {
  final _messagecontroller = TextEditingController();

  @override
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }


  Future<void> commentor(String postId, String text, String uid, String name,String profilePic) async {
    try {
      if (_messagecontroller.text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await FirebaseFirestore.instance
            .collection('confessions')
            .doc(postId)
            .collection('comments1')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'date_published': DateTime.now(),
        });

        _messagecontroller.clear();
      } else {
        print("Text is empty");
      }
    } catch (e) {

    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
              controller: _messagecontroller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                  fillColor: Colors.white,labelStyle: TextStyle(color: Colors.white),
                labelText: 'Add a new comment...',
              ),
            )),
            IconButton(onPressed: () {
              commentor(widget.docid, _messagecontroller.text, widget.uid,
                      widget.name, widget.profilePic);
            }, icon: const Icon(Icons.send, color: Colors.white,)),
          ],
        ),
      );
    
  }


}
