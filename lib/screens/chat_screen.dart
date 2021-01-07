
import 'package:Chat/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:Chat/widgets/chat/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
              items: [
                DropdownMenuItem(
                  value: 'LogOut',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onChanged: (val) async {
                if (val == 'LogOut') await FirebaseAuth.instance.signOut();
              })
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Chat')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemBuilder: (ctx, i) => MessageBubble(
                            snapshot.data.docs[i]['text'],
                            uid == snapshot.data.docs[i]['uid'],
                             snapshot.data.docs[i]['username'],
                             snapshot.data.docs[i]['imageUrl'],
                            key: ValueKey(snapshot.data.docs[i].documentID),
                          ),
                          itemCount: snapshot.data.docs.length,
                        ),
                      ),
                      NewMessage(),
                    ],
                  );
          }),
    );
  }
}
