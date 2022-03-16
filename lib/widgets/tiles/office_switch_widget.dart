import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OfficeSwitchWidget extends StatelessWidget {
  OfficeSwitchWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.count,
      required this.buildingID,
      required this.userID,
      required this.buildingName});

  final String nume, imagine, id, buildingID, userID, buildingName;
  final int count;
  List<String> list = ['userID'];
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  void assignUsersOffice(BuildContext context) async {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);

    await _firebaseFirestore
        .collection('Buildings')
        .doc(buildingID)
        .collection('Offices')
        .doc(id)
        .update({
      'usersId': FieldValue.arrayUnion([userID]),
      'usableDeskCount': FieldValue.increment(-1),
      'numberOfOccupiedDesks': FieldValue.increment(1),
    });
    await _firebaseFirestore.collection('Users').doc(userID).update({
      'building': buildingID,
      'office': id,
      'remoteProcentage': '0',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        count != 0
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.grey[300],
                  onPressed: () => assignUsersOffice(context),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(imagine),
                    ),
                    title: Text(nume),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
