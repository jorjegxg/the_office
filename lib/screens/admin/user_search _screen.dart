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
  final List<Widget> user_list = [
  ];
///TODO fa lista aia cu useri

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Users")),
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomRight: Radius.circular(30),
        //         bottomLeft: Radius.circular(30),
        //     ),),
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
      body: StreamBuilder(
        stream: _firebaseFirestore.collection('User').snapshots(),
        ///ToDO sdrfhdrsfdsrfhsdr
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFieldInput(
                  textEditingController: _textController,
                  hintText: "Search users",
                ),

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
        }
      ),
    );
  }
}
