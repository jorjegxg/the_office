import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_office/widgets/remote_request_widget.dart';

class UserRemoteRequestScreen extends StatelessWidget {
  UserRemoteRequestScreen({Key? key}) : super(key: key);
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Center(child: Text("Remote Requests")),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                  children: snapshot.data!.docs.map((doc) {
                return RemoteRequestWidget(
                  nume: '${doc['name']} ${doc['lastName']}',
                  message: doc['remote_request']['message'],
                  imagine: doc['pictureUrl'],
                  remoteProcentage: doc['remote_request']['procentage'],
                );
              }).toList());
            }
          }),
    );
  }
}
