import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/widgets/tiles/user_list_widget.dart';
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
            Expanded(
              child: ListView(
                children :[
                Row(
                  children: [
                    Expanded(
                      child: TextFieldInput(
                        textEditingController: _textController,
                        hintText: "Search users",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        child: Icon(
                          Icons.filter_list,
                        ),
                        onTap: () {
                          // showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(30)),
                          //         backgroundColor: Theme.of(context).primaryColor,
                          //         title: const Center(
                          //             child: Text(
                          //           "Search filters",
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 30),
                          //         )),
                          //         actions: [
                          //           Column(
                          //             children: [
                          //               DropdownButton(
                          //                 isExpanded: true,
                          //                 focusColor: Colors.grey,
                          //                 value: selectedGender,
                          //                 items: genderItems,
                          //                 onChanged: (String? value) {
                          //                   setState(() {
                          //                     selectedGender = value!;
                          //                   });
                          //                 },
                          //               ),
                          //               DropdownButton(
                          //                 isExpanded: true,
                          //                 focusColor: Colors.grey,
                          //                 value: selectedGender,
                          //                 items: genderItems,
                          //                 onChanged: (String? value) {
                          //                   setState(() {
                          //                     selectedGender = value!;
                          //                   });
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //           Row(
                          //             children: [
                          //               Expanded(
                          //                 child: TextButton(
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: const Text(
                          //                     "Deactivate account",
                          //                     style: TextStyle(color: Colors.black),
                          //                   ),
                          //                   style: ButtonStyle(
                          //                     backgroundColor:
                          //                         MaterialStateProperty.resolveWith(
                          //                             (state) => Colors.white),
                          //                     shape: MaterialStateProperty.all<
                          //                         RoundedRectangleBorder>(
                          //                       RoundedRectangleBorder(
                          //                         borderRadius:
                          //                             BorderRadius.circular(18.0),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 5,
                          //               ),
                          //               Expanded(
                          //                 child: TextButton(
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: const Text(
                          //                     "Cancel",
                          //                     style: TextStyle(color: Colors.black),
                          //                   ),
                          //                   style: ButtonStyle(
                          //                     backgroundColor:
                          //                         MaterialStateProperty.resolveWith(
                          //                             (state) => Colors.white),
                          //                     shape: MaterialStateProperty.all<
                          //                         RoundedRectangleBorder>(
                          //                       RoundedRectangleBorder(
                          //                         borderRadius:
                          //                             BorderRadius.circular(18.0),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       );)};
                        },
                      ),
                    ),
                  ],
                ),
        SizedBox(
        height: 30,
        ),
        StreamBuilder<QuerySnapshot>(
              stream: _firebaseFirestore.collection('Users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (! snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        return UserListWidget(
                          nume: '${doc['name']} ${doc['lastName']}',
                          imagine: doc['pictureUrl'],
                          rol: doc['role'],
                          id: doc['id'],
                        );
                      }).toList(),
                    );
                  }
              }),
          ],

              ),
            ),

          ],
        ),
      ),
    );
  }
}
