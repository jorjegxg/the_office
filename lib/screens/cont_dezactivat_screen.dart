import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContDezactivatScreen extends StatelessWidget {
  ContDezactivatScreen({Key? key}) : super(key: key);

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Your account in deactivated \n sorry :(",
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 40,),
          ElevatedButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text('Logout'))
        ],
      ),
    );
  }
}
