import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_building.dart';
import 'package:the_office/widgets/tiles/building_switch_widget.dart';

class SwitchUsersBuilding extends StatelessWidget {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Text("Buildings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseFirestore.collection('Buildings').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (! snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                else
              {
                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((doc) {
                        return BuildingSwitchWidget(
                          nume: doc['name'],
                          imagine: doc['pictureUrl'],
                          id: doc['id'],
                        );
                      }).toList(),
                    ),
                  );
                }
            }),
      ),
    );
  }
}
