import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/switch_user_building_screen.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({required this.id});
  final String id;
  final String titlu = "dadasda";
  final String nume = "Admin adin";
  final String statut = "Administrator";
  final String email = "admin@gmail.com";
  final String cladire = "Corp A";
  final String birou = "301";
  final int remote = 38;
  final String gen = "Male";
  final String data = "01/21/2020";
  final GlobalKey _scaffold = GlobalKey();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: StreamBuilder(
          stream: _firebaseFirestore.collection("Users").doc(id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
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
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'imagini/no-profile-picture-icon.png'),
                                      radius: 40,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot.data['pictureUrl']),
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${snapshot.data['name']} ${snapshot.data['lastName']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
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
                                fontWeight: FontWeight.bold, fontSize: 22),
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
                                : "Birth date: --------",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data['building'] != ""
                                ? "Building: ${snapshot.data['building']}"
                                : "Building: --------",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data['office'] != ""
                                ? "Office: ${snapshot.data['office']}"
                                : "Office: --------",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            minWidth: MediaQuery.of(context).size.width * 0.25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Center(
                                child: Text(
                                  "Assign office",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SwitchUsersBuilding(),
                                ),
                              );
                            },
                            //"De-assign office"
                            color: Color(0xFF398AB9),
                          ),
                          _firebaseAuth.currentUser!.uid != id
                              ? MaterialButton(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.25,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Center(
                                      child: Text(
                                        "De-assign office",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF398AB9),
                                )
                              : Container(),
                          MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            minWidth: MediaQuery.of(context).size.width * 0.25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Center(
                                    child: Text(
                                  "Deactivate account",
                                  style: TextStyle(color: Colors.white),
                                ))),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      title: const Center(
                                          child: Text(
                                        "Are you sure?",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      )),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Deactivate account",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              (state) =>
                                                                  Colors.white),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              (state) =>
                                                                  Colors.white),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                            color: Color(0xFF398AB9),
                          ),
                        ],
                      ),
                    ),
                  ],
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
