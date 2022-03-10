import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/widgets/tiles/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/widgets/text_field_input.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select building"),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: StreamBuilder(
          stream: _firebaseFirestore.collection('User').snapshots(),

          ///ToDO sdrfhdrsfdsrfhsdr
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ///TODO fa lista de useri
                  // Expanded(
                  //   child: ListView(
                  //       children:snapshot.data.,
                  //   ),
                  // ),

                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //         left: 20, right: 20, top: 20, bottom: 30),
                  //     child: ListView.builder(
                  //       itemCount: user_list.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return user_list[index];
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
    );
  }
}
