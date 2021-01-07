import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final messageController = TextEditingController();

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final uid = FirebaseAuth.instance.currentUser.uid;
   final userData= await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    await FirebaseFirestore.instance.collection('Chat').add({
      'text': messageController.text,
      'uid':uid,
      'username': userData.data()['username'],
      'imageUrl':userData.data()['imageUrl'],
      'time': Timestamp.now(),
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 15),
      child: Row(children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'new message'),
            controller: messageController,
            onChanged: (val) => setState(() {}),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(
            Icons.send,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: messageController.text.trim().isEmpty ? null : sendMessage,
        ),
      ]),
    );
  }
}
