import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_office/providers/role_provider.dart';
import 'package:the_office/widgets/remote_request_widget.dart';
import 'package:provider/provider.dart';

class RemoteRequestScreen extends StatefulWidget {
  const RemoteRequestScreen({Key? key}) : super(key: key);

  @override
  State<RemoteRequestScreen> createState() => _RemoteRequestScreenState();
}

class _RemoteRequestScreenState extends State<RemoteRequestScreen> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController1 = TextEditingController();
  String? _dropDownValue;
  var currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Widget bottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 25,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffDFDFDF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                    hint: const Text("Select Percentage"),
                    value: _dropDownValue,
                    isExpanded: true,
                    iconSize: 20.0,
                    style: const TextStyle(color: Colors.black),
                    items: List<String>.generate(
                        100, (int index) => '${index + 1}').map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        _dropDownValue = val;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffDFDFDF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    maxLines: 10,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                      ),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(width: 0, color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Message",
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Map<String, dynamic> updatedData = {
                        'procentage': _dropDownValue,
                        'message': textEditingController.text,
                        'status': true,
                        'adminMessage': '',
                      };
                      _firebaseFirestore
                          .collection('Users')
                          .doc(currentUserId)
                          .update({
                        'remote_request': updatedData,
                        'requestStatus': true,
                      });

                      Navigator.pop(context);
                    },
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Center(child: Text("Remote Requests")),
      ),
      floatingActionButton:
          Provider.of<RoleProvider>(context).getRole() != 'Administrator'
              ? StreamBuilder(
                  stream: _firebaseFirestore
                      .collection('Users')
                      .doc(currentUserId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    } else {
                      if (snapshot.data['requestStatus'] == false) {
                        return FloatingActionButton(
                          child: const Icon(Icons.person_add),
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: bottomSheet(context)),
                                    ));
                          },
                        );
                      } else
                        return SizedBox();
                    }
                  },
                )
              : null,
      body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              
              return ListView(
                  children: snapshot.data!.docs.map((doc) {    
                return RemoteRequestWidget(
                  nume: '${doc['name']} ${doc['lastName']}',
                  message: doc['remote_request']['message'],
                  imagine: doc['pictureUrl'],
                  remoteProcentage: doc['remote_request']['procentage'],
                  requestStatus: doc['requestStatus'],
                  role: Provider.of<RoleProvider>(context).getRole(),
                  mine: currentUserId == doc['id'] ? true : false,
                  id: doc['id'],
                  adminMessage: doc['remote_request']['adminMessage'],
                );
              }).toList());
            }
          }),
    );
  }
}
