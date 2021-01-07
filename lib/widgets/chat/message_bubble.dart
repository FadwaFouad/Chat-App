import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String username;
  final String imageUrl;

  final Key key;

  MessageBubble(this.text, this.isMe, this.username, this.imageUrl, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isMe)
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(imageUrl),
            ),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(5),
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                topLeft: Radius.circular(14),
                bottomLeft: isMe ? Radius.circular(0) : Radius.circular(14),
                bottomRight: isMe ? Radius.circular(14) : Radius.circular(0),
              ),
              color: isMe ? Theme.of(context).primaryColor : Colors.grey,
            ),
            child: Column(
              children: [
                Text(
                  '\"$username\"',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    )),
              ],
            ),
          ),
          if (!isMe)
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(imageUrl),
            ),
        ]);
  }
}
