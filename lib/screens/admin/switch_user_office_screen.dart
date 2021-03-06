import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/widgets/tiles/office_switch_widget.dart';

class SwitchUsersOffice extends StatelessWidget {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final String id, userID, buildingName;

  SwitchUsersOffice(
      {required this.id, required this.userID, required this.buildingName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Text("Assign office to user"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseFirestore
                .collection('Buildings')
                .doc(id)
                .collection('Offices')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return OfficeSwitchWidget(
                      nume: doc['name'],
                      imagine: doc['pictureUrl'],
                      id: doc['id'],
                      count: doc['usableDeskCount'],
                      buildingID: id,
                      userID: userID,
                      buildingName: buildingName,
                      officeAdmin: doc['idAdmin'],
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
