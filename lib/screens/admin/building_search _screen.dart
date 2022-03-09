import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_building.dart';
import 'package:the_office/widgets/building_list_widget.dart';
import 'package:the_office/widgets/text_field_input.dart';

class BuildingSearchScreen extends StatelessWidget {
  BuildingSearchScreen({required this.next});
  final TextEditingController _textController = TextEditingController();

  // final List<Widget> building_list = [
  //   BuildingListWidget(nume: "swergsaerg", imagine: 'https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/default_building.jpg?alt=media&token=59cfa57f-7b88-4363-abfc-2e526bdd17b3', id: 'id', adress: "adresa"),
  //   BuildingListWidget(nume: "swergsaerg", imagine: 'https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/default_building.jpg?alt=media&token=59cfa57f-7b88-4363-abfc-2e526bdd17b3', id: 'id', adress: "adresa"),
  //   BuildingListWidget(nume: "swergsaerg", imagine: 'https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/default_building.jpg?alt=media&token=59cfa57f-7b88-4363-abfc-2e526bdd17b3', id: 'id', adress: "adresa"),
  // ];
  final VoidCallback next;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Buildings")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnBuilding",
        child: const Icon(Icons.domain_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateBuilding()),
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
                stream: _firebaseFirestore.collection('buildings').snapshots(),
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
