import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/role_provider.dart';

class OfficeSwitchWidget extends StatelessWidget {
  OfficeSwitchWidget({
    required this.nume,
    required this.imagine,
    required this.id,
    required this.count,
    required this.buildingID,
    required this.userID,
    required this.buildingName,
    required this.officeAdmin,
  });

  final String nume, imagine, id, buildingID, userID, buildingName, officeAdmin;
  final int count;
  List<String> list = ['userID'];
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
        Provider.of<RoleProvider>(context).getRole() == 'Administrator'
            ? count != 0
                ? Column(
                    children: [
                      const Divider(
                        height: 0,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                      ListTile(
                        onTap: () => assignUsersOffice(context),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(imagine),
                        ),
                        title: Text(nume),
                      ),
                      const Divider(
                        height: 0,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                    ],
                  )
                : const SizedBox()
            : officeAdmin == FirebaseAuth.instance.currentUser!.uid
                ? count != 0
                    ? Column(
                        children: [
                          const Divider(
                            height: 0,
                            color: Color.fromARGB(255, 153, 153, 153),
                          ),
                          ListTile(
                            onTap: () => assignUsersOffice(context),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(imagine),
                            ),
                            title: Text(nume),
                          ),
                          const Divider(
                            height: 0,
                            color: Color.fromARGB(255, 153, 153, 153),
                          ),
                        ],
                      )
                    : const SizedBox()
                : SizedBox(),
      ],
    );
  }
}
