import 'package:chat_app/widgets/chat/message_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final docs = snapshot.data!.docs;
        final userId = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) {
            return MessageStyle(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['userId'] == userId!.uid,
              ValueKey(docs[index].id),
            );
          },
        );
      },
    );
  }
}
