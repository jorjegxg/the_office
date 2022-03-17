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
  String buildingId = "";
  String officeId = "";
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
          .collection('Users')
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
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
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
              .collection("Users")
              .doc(_firebaseAuth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              buildingId = snapshot.data['building'];
              officeId = snapshot.data['office'];

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
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'imagini/no-profile-picture-icon.png'),
                                radius: 40,
                              ),
                              _picIsLoading
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                      child: CircularProgressIndicator())
                                  : (CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot.data['pictureUrl']),
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                    )),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => pickYourImageDialog(),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                  ),
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
                              Container(
                                width: 150,
                                child: Text(
                                  '${snapshot.data['name']} ${snapshot.data['lastName']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  snapshot.data['role'],
                                  style: const TextStyle(fontSize: 24),
                                ),
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
                          fontWeight: FontWeight.bold, fontSize: 23),
                    ),
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
                      snapshot.data['birthDate'] != ""
                          ? "Birth date: ${snapshot.data['birthDate']}"
                          : "Birth date: not specified",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildingId.isNotEmpty
                        ? StreamBuilder(
                            stream: _firebaseFirestore
                                .collection('Buildings')
                                .doc(buildingId)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot2) {
                              if (!snapshot2.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot2.data['name'] != ""
                                          ? "Building: ${snapshot2.data['name']}"
                                          : "Building: no building",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    StreamBuilder(
                                        stream: _firebaseFirestore
                                            .collection('Buildings')
                                            .doc(buildingId)
                                            .collection("Offices")
                                            .doc(officeId)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot3) {
                                          if (!snapshot3.hasData) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return Text(
                                              snapshot3.data['name'] != ""
                                                  ? "Office: ${snapshot3.data['name']}"
                                                  : "Office: no office",
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            );
                                          }
                                        }),
                                  ],
                                );
                              }
                            })
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Building: no building",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Office: no office",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
