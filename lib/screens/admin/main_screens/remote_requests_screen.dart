import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  var currentUserId = FirebaseAuth.instance.currentUser!.uid;
  Widget bottomSheet(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 25,
          ),
          // child: Container(
          //   decoration: BoxDecoration(
          //     color: const Color(0xffDFDFDF),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: TextField(
          //       maxLines: 1,
          //       controller: textEditingController1,
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           borderSide: const BorderSide(width: 0, color: Colors.white),
          //         ),
          //         enabled: true,
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           borderSide: BorderSide(width: 0, color: Colors.white),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           borderSide: BorderSide(width: 0, color: Colors.white),
          //         ),
          //         filled: true,
          //         fillColor: Colors.white,
          //         hintText: "RemoteWorkPercentage",
          //       ),
          //     ),
          //   ),
          // ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffDFDFDF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  maxLines: double.maxFinite.floor(),
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
                      borderSide: BorderSide(width: 0, color: Colors.white),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 10,
            ),
            //refuse button
            Expanded(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Refuse",
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
            //accept button
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
                color: Colors.grey[400],
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Center(child: Text("Remote Requests")),
      ),
      floatingActionButton: Provider.of<RoleProvider>(context).getRole() !=
              'Administrator'
          ? FloatingActionButton(
              child: const Icon(Icons.person_add),
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: bottomSheet);
              },
            )
          : null,
      body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                  children: snapshot.data!.docs.map((doc) {
                return RemoteRequestWidget(
                  nume: '${doc['name']} ${doc['lastName']}',
                  message: doc['remote_request']['message'],
                  imagine: doc['pictureUrl'],
                  remoteProcentage: doc['remote_request']['procentage'],
                  requestStatus: doc['requestStatus'],
                  role: Provider.of<RoleProvider>(context).getRole(),
                  mine: currentUserId == doc['id'] ? true : false,
                );
              }).toList());
            }
          }),
    );
  }
}
