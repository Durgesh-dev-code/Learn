import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdDate', descending: true)
          .snapshots(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapShots) {
        if (chatSnapShots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (chatSnapShots.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (!chatSnapShots.hasData || chatSnapShots.data!.docs.isEmpty) {
          return const Center(child: Text('No Messages'));
        }

        final chatMessages = chatSnapShots.data!.docs;
        return ListView.builder(
            padding: const EdgeInsets.only(
              left: 0,
              top: 10,
              right: 0,
              bottom: 10,
            ),
            reverse: true,
            itemCount: chatMessages.length,
            itemBuilder: (ctx, index) {
              //Text(chatMessages[index].data()['text']);
              final message = chatMessages[index].data();
              final nextMessage = index + 1 < chatMessages.length
                  ? chatMessages[index + 1].data()
                  : null;
              final currentMessageUserId = message['userid'];
              final nextMessageUserId =
                  nextMessage != null ? nextMessage['userid'] : null;

              final nextUserIsSame = currentMessageUserId == nextMessageUserId;
              print('authenticatedUser.uid ${authenticatedUser.uid}');
              print('message[userid] ${message['userid']}');
              print('currentMessageUserId.uid ${currentMessageUserId}');
              if (nextUserIsSame) {
                return MessageBubble.next(
                    message: message['text'],
                    isMe: authenticatedUser.uid == currentMessageUserId);
              } else {
                return MessageBubble.first(
                  userImage: message['userImage'],
                  username: message['username'],
                  message: message['text'],
                  isMe: authenticatedUser.uid == currentMessageUserId,
                );
              }
              // return ListTile(
              //   title: Text(chatMessages[index].data()['text']),
              // );
            });
      },
    );
  }
}
