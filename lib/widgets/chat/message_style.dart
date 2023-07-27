// ignore_for_file: unused_field

import "package:flutter/material.dart";

class MessageStyle extends StatelessWidget {
  MessageStyle(
    this.message,
    this.userName,
    this.isMe,
    this.key,
  );
  final String message;
  final String userName;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromARGB(255, 165, 165, 164)
                : Color.fromARGB(255, 218, 192, 99),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(13),
              topLeft: Radius.circular(13),
              bottomLeft: isMe ? Radius.circular(13) : Radius.zero,
              bottomRight: isMe ? Radius.zero : Radius.circular(13),
            ),
          ),
          child: Column(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(message),
            ],
          ),
        ),
      ],
    );
  }
}
