import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/services/firebase_firestore_functions.dart';

import '../../../providers/role_provider.dart';

class ViewRemoteRequest extends StatelessWidget {
  ViewRemoteRequest({
    required this.nume,
    required this.imagine,
    required this.remoteProcentage,
    required this.message,
    required this.id,
    required this.adminMessage,
  });
  final String nume, imagine, message, id, adminMessage;
  final String remoteProcentage;
  final TextEditingController textEditingController = TextEditingController();
  //Casuta pop-up bottom sheet
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  Widget bottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 25,
          ),
          child: ListTile(
            tileColor: const Color(0xffDFDFDF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                imagine,
              ),
            ),
            title: Text(nume),
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
                    borderSide: const BorderSide(width: 0, color: Colors.white),
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
                  hintText: "Text",
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
                  Map<String, dynamic> updatedData = {
                    'procentage': remoteProcentage,
                    'message': message,
                    'adminMessage': textEditingController.text,
                    'status': false,
                  };
                  _firebase.collection('Users').doc(id).update({
                    'remote_request': updatedData,
                    'requestStatus': false,
                  });
                  int count = 0;
                  textEditingController.text != ''
                      ? Navigator.of(context).popUntil((_) => count++ >= 2)
                      : SizedBox();
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
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(20),
        //   ),
        // ),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(nume),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    imagine,
                  ),
                  radius: 30,
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  nume,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Remote work procentage: $remoteProcentage%",
                style: const TextStyle(fontSize: 15),
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 15),
                      textHeightBehavior: TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Provider.of<RoleProvider>(context).getRole() == 'Administrator'
                ? Row(
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
                              ),
                            );
                          },
                          color: Color(0xffAC477C),
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
                            "Accept",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            Map<String, dynamic> updatedData = {
                              'procentage': '',
                              'message': '',
                              'adminMessage': '',
                              'status': false,
                            };
                            if (remoteProcentage == '100') {
                              _firebase.collection('Users').doc(id).update({
                                'remoteProcentage': remoteProcentage,
                                'requestStatus': false,
                                'remote_request': updatedData,
                                'office': '',
                                'building': '',
                              });
                            } else {
                              _firebase.collection('Users').doc(id).update({
                                'remoteProcentage': remoteProcentage,
                                'requestStatus': false,
                                'remote_request': updatedData,
                              });
                            }
                            Navigator.pop(context);
                          },
                          color: Color(0xff6D74B7),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                : adminMessage != ''
                    ? MaterialButton(
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text(
                          "See reason",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  title: Center(
                                      child: Text(
                                    adminMessage,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  )),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Map<String, dynamic> updatedData = {
                                            'message': '',
                                            'procentage': '',
                                            'adminMessage': '0',
                                            'status': false,
                                          };
                                          _firebase
                                              .collection('Users')
                                              .doc(id)
                                              .update({
                                            'requestStatus': false,
                                            'remote_request': updatedData,
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (state) => Colors.white),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });

                          Navigator.pop(context);
                        },
                        color: Colors.green,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        child: const Center(
                            child: Text(
                          'Status: Pending',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
          ],
        ),
      ),
    );
  }
}
