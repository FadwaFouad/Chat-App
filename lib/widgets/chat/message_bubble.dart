import 'package:flutter/material.dart';

import 'package:Chat/utils/constants.dart' as cons;

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String username;
  final String imageUrl;

  final Key key;

  MessageBubble(this.text, this.isMe, this.username, this.imageUrl, {this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      //padding: EdgeInsets.all(5),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (!isMe)
              Column(children: [
                SizedBox(
                  height: 32,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ]),
            Container(
              margin: EdgeInsets.only(top: 4, right: 4, left: 4),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),

              //width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: isMe ? Radius.circular(14) : Radius.circular(30),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(14),
                  bottomRight: !isMe ? Radius.circular(20) : Radius.circular(0),
                ),
                color: !isMe ? cons.colorPurpleLight : cons.colorGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMe)
                    Text('$username',
                        style: cons.textTheme.headline3.copyWith(
                          color: cons.COLOR_WHITE,
                        )),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    text,
                    style: !isMe
                        ? cons.textTheme.bodyText1.copyWith(
                            color: cons.COLOR_WHITE,
                          )
                        : cons.textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
