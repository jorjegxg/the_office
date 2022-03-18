import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/screens/empty_office.dart';

import '../providers/role_provider.dart';
import 'admin/main_screens/building_search _screen.dart';
import 'admin/tiles_view/office_view_screen.dart';

class SelectScreens extends StatelessWidget {
  SelectScreens({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var currentUserId = FirebaseAuth.instance.currentUser!.uid;
  String id = '', idBuilding = '', buildingName = '', officeName = '';

  Future<void> getOfficeData() async {
    var ref1 = await _firestore.collection('Users').doc(currentUserId).get();
    id = await ref1['office'];
    idBuilding = await ref1['building'];

    if (!id.isEmpty && !idBuilding.isEmpty) {
      var ref = await _firestore
          .collection("Buildings")
          .doc(idBuilding)
          .collection("Offices")
          .doc(id)
          .get();
      var ref2 = await _firestore.collection("Buildings").doc(idBuilding).get();
      buildingName = await ref2['name'];
      officeName = await ref['name'];
    }
    print(id);
    print(idBuilding);
  }

  @override
  Widget build(BuildContext context) {
    getOfficeData();
    return FutureBuilder(
        future: getOfficeData(),
        builder: (context, snapshot) {
          return Provider.of<RoleProvider>(context).getRole() != 'Employee'
              ? BuildingSearchScreen()
              : (!id.isEmpty && !idBuilding.isEmpty)
                  ? OfficeViewScreen(
                      id: id,
                      idBuilding: idBuilding,
                      buildingName: buildingName,
                      officeName: officeName,
                    )
                  : EmptyOffice();
        });
  }
}
