import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/screens/admin/switch_user_office_screen.dart';

class SwitchUsersBuilding extends StatefulWidget {
  const SwitchUsersBuilding({Key? key}) : super(key: key);

  @override
  State<SwitchUsersBuilding> createState() => _SwitchUsersBuildingState();
}

class _SwitchUsersBuildingState extends State<SwitchUsersBuilding> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _textController = TextEditingController();
  final List<Widget> user_list = [];

  ///TODO fa lista aia cu useri

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firebaseFirestore.collection('User').snapshots(),

        ///ToDO sdrfhdrsfdsrfhsdr
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Select building"),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.collection('Users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return SwitchUsersOffice(
                              id: doc['id'],
                            );
                          }).toList(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("Wtf");
                }),
          );
        });
  }
}
