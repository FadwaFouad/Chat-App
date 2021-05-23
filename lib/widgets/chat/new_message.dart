import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Chat/utils/constants.dart' as cons;

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final messageController = TextEditingController();

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final uid = FirebaseAuth.instance.currentUser.uid;
    final userData =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    await FirebaseFirestore.instance.collection('Chat').add({
      'text': messageController.text,
      'uid': uid,
      'username': userData.data()['username'],
      'imageUrl': userData.data()['imageUrl'],
      'time': Timestamp.now(),
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: cons.inputDecor,
            child: TextField(
              decoration: InputDecoration.collapsed(
                  hintText: '  type your message...',
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  )),
              controller: messageController,
              onChanged: (val) => setState(() {}),
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          //width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
            // boxShadow: [
            //   BoxShadow(offset: Offset.fromDirection(direction) )
            // ]
          ),
          child: IconButton(
            icon: Icon(
              Icons.send,
              color: cons.COLOR_WHITE,
            ),
            onPressed:
                messageController.text.trim().isEmpty ? null : sendMessage,
          ),
        ),
      ]),
    );
  }
}
