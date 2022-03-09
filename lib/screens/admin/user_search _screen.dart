import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_user.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/widgets/text_field_input.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _textController = TextEditingController();
  final List<Widget> user_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Users")),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateUser()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFieldInput(
              textEditingController: _textController,
              hintText: "Search users",
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.collection('Users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return UserListWidget(
                              nume: '${doc['name']} ${doc['lastName']}',
                              imagine: doc['pictureUrl'],
                              rol: doc['role'],
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
