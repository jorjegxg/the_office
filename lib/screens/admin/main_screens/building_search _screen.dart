import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_building.dart';
import 'package:the_office/widgets/tiles/building_list_widget.dart';
import 'package:the_office/widgets/text_field_input.dart';

class BuildingSearchScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Center(child: Text("Buildings")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnBuilding",
        child: const Icon(Icons.domain_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateBuilding()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFieldInput(
              textEditingController: _textController,
              hintText: "Search buildings",
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.collection('Buildings').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return BuildingListWidget(
                              nume: doc['name'],
                              imagine: doc['pictureUrl'],
                              adress: doc['buildingAdress'],
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

          ],
        ),
      ),
    );
  }
}
