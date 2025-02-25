import 'package:chat_app/widgets/chat_Messages.dart';
import 'package:chat_app/widgets/newMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setUpushnotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print(token);
    // fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setUpushnotification();
  }

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Bot'),
          actions: [
            IconButton(
              onPressed: logOut,
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        body: const Center(
          child: Column(
            children: [
              Expanded(child: ChatMessages()),
              NewMessage(),
            ],
          ),
        ));
  }
}
