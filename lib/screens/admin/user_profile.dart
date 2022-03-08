import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_office/services/auth_methods.dart';
import 'package:the_office/services/storage_methods.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _picIsLoading = false;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  File? imageFile;

  _picFromWhere(BuildContext context, ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source, //ImageSource.camera ,
    );
    if (pickedFile != null) {
      setState(() {
        _picIsLoading = true;
      });
      //------------------------e bun?????
      Navigator.pop(context);
      imageFile = File(pickedFile.path);

      String photoLink =
          await StorageMethods().uploadFile(name: 'Users', file: imageFile!);

      _firebaseFirestore
          .collection('Administrator')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({'pictureUrl': photoLink});
      setState(() {
        _picIsLoading = false;
      });
    }
  }

  pickYourImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Pick"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      await _picFromWhere(context, ImageSource.gallery);
                    },
                    title: Text("Gallery"),
                  ),
                  ListTile(
                    onTap: () async {
                      await _picFromWhere(context, ImageSource.camera);
                    },
                    title: Text("Camera"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          GestureDetector(
            child: Icon(Icons.logout),
            onTap: () {
              AuthMethods().logout();
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _firebaseFirestore
              .collection("Administrator")
              .doc(_firebaseAuth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Row(
                          children: [
                            ///TODO pick image
                            Stack(
                              children: [
                                _picIsLoading
                                    ? CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        child: CircularProgressIndicator())
                                    : (CircleAvatar(
                                        backgroundImage: snapshot
                                                    .data['pictureUrl'] ==
                                                ""
                                            ? NetworkImage(
                                                'https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/no-profile-picture-icon.png?alt=media&token=d409142b-3d04-4567-97cb-8e498a21a9f9')
                                            : NetworkImage(
                                                snapshot.data['pictureUrl']),
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                      )),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => pickYourImageDialog(),
                                    child: Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(
                                  snapshot.data['role'],
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        snapshot.data['email'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      snapshot.data['building'] != ""
                          ? Text(
                              "Building: ${snapshot.data['building']}",
                              style: const TextStyle(fontSize: 20),
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      snapshot.data['office'] != ""
                          ? Text(
                              "Office: ${snapshot.data['office']}",
                              style: const TextStyle(fontSize: 20),
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Gender: ${snapshot.data['gender']}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Remote Work: ${snapshot.data['remoteProcentage']}%",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Birth date: ${snapshot.data['birthDate']}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Eroare'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Text('Ceva a mers rau');
          }),
    );
  }
}
