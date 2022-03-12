import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/tiles/office_list_widget.dart';


class SwitchUsersOffice extends StatefulWidget {
  const SwitchUsersOffice({required this.id});
  final String id;
  @override
  State<SwitchUsersOffice> createState() => _SwitchUsersOfficeState();
}

class _SwitchUsersOfficeState extends State<SwitchUsersOffice> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _textController = TextEditingController();
  final List<Widget> office_list = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Select building")),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore
              .collection('Buildings')
              .doc(widget.id)
              .collection("Offices")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return OfficeListWidget(
                        nume: '${doc['name']}',
                        imagine: doc['pictureUrl'],
                        id: doc['id'],
                        building: doc['building'],
                        idBuilding: 'ia id de la building',
                        buildingName: 'ia buildingName',
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
  }
}
