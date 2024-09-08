import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/message_bubble.dart';

class EpochBody extends StatelessWidget {
  const EpochBody({super.key});
  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('epoch_chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text("No new messages found"),
            );
          }

          if (chatSnapshots.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          }

          final loadedmessages = chatSnapshots.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: loadedmessages.length,
            itemBuilder: (ctx, index) {
              final chatMessage = loadedmessages[index].data();
              final nextchatmessage = index + 1 < loadedmessages.length
                  ? loadedmessages[index + 1].data()
                  : null;
              final currentMessageUserId = chatMessage['userId'];
              final nextChatMessageUserId =
                  nextchatmessage != null ? nextchatmessage['userId'] : null;
              final nextUserIsSame =
                  nextChatMessageUserId == currentMessageUserId;
              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: authenticatedUser.uid == currentMessageUserId,
                );
              } else {
                return MessageBubble.first(
                    userImage: chatMessage['userImage'],
                    username: chatMessage['userName'],
                    message: chatMessage['text'],
                    isMe: authenticatedUser.uid == currentMessageUserId);
              }
            },
          );
        });
  }
}

/* */