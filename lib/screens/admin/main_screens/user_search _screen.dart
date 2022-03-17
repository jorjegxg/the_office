import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/widgets/tiles/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/widgets/text_field_input.dart';

import '../../../providers/role_provider.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _textController = TextEditingController();
  String datiUpdateOdata = "";
  @override
  Widget build(BuildContext context) {
    
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Users")),
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      floatingActionButton: Provider.of<RoleProvider>(context).getRole() ==
              'Administrator'
          ? FloatingActionButton(
              child: const Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateUser()),
                );
              },
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                              autofocus: false,
                            ///fa hint textul sa se duca sus dupa ce e apasat
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: "Search users",
                              border: inputBorder,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              filled: true,
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            onChanged: (value){
                              setState(() {
                                datiUpdateOdata = value;
                                print("datiUpdateOdata : " + datiUpdateOdata);
                              });
                            },
                            onEditingComplete: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: GestureDetector(
                      //     child: Icon(
                      //       Icons.filter_list,
                      //     ),
                      //     onTap: () {
                      //       // showDialog(
                      //       //     barrierDismissible: false,
                      //       //     context: context,
                      //       //     builder: (BuildContext context) {
                      //       //       return AlertDialog(
                      //       //         shape: RoundedRectangleBorder(
                      //       //             borderRadius: BorderRadius.circular(30)),
                      //       //         backgroundColor: Theme.of(context).primaryColor,
                      //       //         title: const Center(
                      //       //             child: Text(
                      //       //           "Search filters",
                      //       //           style: TextStyle(
                      //       //               color: Colors.white, fontSize: 30),
                      //       //         )),
                      //       //         actions: [
                      //       //           Column(
                      //       //             children: [
                      //       //               DropdownButton(
                      //       //                 isExpanded: true,
                      //       //                 focusColor: Colors.grey,
                      //       //                 value: selectedGender,
                      //       //                 items: genderItems,
                      //       //                 onChanged: (String? value) {
                      //       //                   setState(() {
                      //       //                     selectedGender = value!;
                      //       //                   });
                      //       //                 },
                      //       //               ),
                      //       //               DropdownButton(
                      //       //                 isExpanded: true,
                      //       //                 focusColor: Colors.grey,
                      //       //                 value: selectedGender,
                      //       //                 items: genderItems,
                      //       //                 onChanged: (String? value) {
                      //       //                   setState(() {
                      //       //                     selectedGender = value!;
                      //       //                   });
                      //       //                 },
                      //       //               ),
                      //       //             ],
                      //       //           ),
                      //       //           Row(
                      //       //             children: [
                      //       //               Expanded(
                      //       //                 child: TextButton(
                      //       //                   onPressed: () {
                      //       //                     Navigator.pop(context);
                      //       //                   },
                      //       //                   child: const Text(
                      //       //                     "Deactivate account",
                      //       //                     style: TextStyle(color: Colors.black),
                      //       //                   ),
                      //       //                   style: ButtonStyle(
                      //       //                     backgroundColor:
                      //       //                         MaterialStateProperty.resolveWith(
                      //       //                             (state) => Colors.white),
                      //       //                     shape: MaterialStateProperty.all<
                      //       //                         RoundedRectangleBorder>(
                      //       //                       RoundedRectangleBorder(
                      //       //                         borderRadius:
                      //       //                             BorderRadius.circular(18.0),
                      //       //                       ),
                      //       //                     ),
                      //       //                   ),
                      //       //                 ),
                      //       //               ),
                      //       //               const SizedBox(
                      //       //                 width: 5,
                      //       //               ),
                      //       //               Expanded(
                      //       //                 child: TextButton(
                      //       //                   onPressed: () {
                      //       //                     Navigator.pop(context);
                      //       //                   },
                      //       //                   child: const Text(
                      //       //                     "Cancel",
                      //       //                     style: TextStyle(color: Colors.black),
                      //       //                   ),
                      //       //                   style: ButtonStyle(
                      //       //                     backgroundColor:
                      //       //                         MaterialStateProperty.resolveWith(
                      //       //                             (state) => Colors.white),
                      //       //                     shape: MaterialStateProperty.all<
                      //       //                         RoundedRectangleBorder>(
                      //       //                       RoundedRectangleBorder(
                      //       //                         borderRadius:
                      //       //                             BorderRadius.circular(18.0),
                      //       //                       ),
                      //       //                     ),
                      //       //                   ),
                      //       //                 ),
                      //       //               ),
                      //       //             ],
                      //       //           ),
                      //       //         ],
                      //       //       );)};
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream:
                          _firebaseFirestore.collection('Users').snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Column(
                            children: snapshot.data!.docs.map((doc) {
                              if (doc['id'] == 'GRzHoyaXc2WzB9AcHK41caRSYtI3') {
                                return Container();
                              }
                              if (datiUpdateOdata == "") {

                                return UserListWidget(
                                  nume: '${doc['name']} ${doc['lastName']}',
                                  imagine: doc['pictureUrl'],
                                  rol: doc['role'],
                                  id: doc['id'],
                                );
                              } else {


                                if ((doc['name'] as String).toLowerCase()
                                    .contains(datiUpdateOdata.toLowerCase()) || (doc['lastName'] as String).toLowerCase()
                                    .contains(datiUpdateOdata.toLowerCase())) {

                                  return UserListWidget(
                                    nume: '${doc['name']} ${doc['lastName']}',
                                    imagine: doc['pictureUrl'],
                                    rol: doc['role'],
                                    id: doc['id'],
                                  );
                                } else {
                                  return Container();
                                }
                              }
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
