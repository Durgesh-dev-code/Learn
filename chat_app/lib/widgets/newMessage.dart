import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();
  String enterMessage = '';
  @override
  void dispose() {
    _messageController.clear();
    super.dispose();
  }

  void _onSubmit() async {
    enterMessage = _messageController.text;

    if (enterMessage.isEmpty) return;

    FocusScope.of(context).unfocus();
    //Send to FireStore
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enterMessage,
      'createdDate': Timestamp.now(),
      'userid': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_Url'],
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        top: 5,
        right: 10,
        bottom: 70,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: false,
              enableSuggestions: true,
              decoration:
                  const InputDecoration(labelText: 'Sending Message...'),
            ),
          ),
          IconButton(onPressed: _onSubmit, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
