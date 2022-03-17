import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/screens/admin/switch_user_building_screen.dart';
import 'package:the_office/screens/admin/update_profile.dart';

import '../../../providers/role_provider.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({
    required this.id,
  });

  final String id;
  final GlobalKey _scaffold = GlobalKey();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String name = "";
  String lastName = "";
  String gender = "";
  String birthDate = "";
  String nationality = "";
  String role = "";
  String pictureUrl = "";
  String buildingId = "";
  String officeId = "";
  late DocumentSnapshot refB, refO;

  bool isActive = true;

  void deAssignUsersOffice() async {
    DocumentSnapshot ref =
        await _firebaseFirestore.collection('Users').doc(id).get();
    var building = await ref['building'];
    if (building != "") {
      await _firebaseFirestore
          .collection('Buildings')
          .doc(ref['building'])
          .collection('Offices')
          .doc(ref['office'])
          .update({
        'usersId': FieldValue.arrayRemove([id]),
        'numberOfOccupiedDesks': FieldValue.increment(-1),
      });
      await _firebaseFirestore
          .collection('Users')
          .doc(id)
          .update({'building': '', 'office': ''});
    }
  }
  Future<void> deactivateActivateAccount() async{
   var user = _firebaseFirestore.collection("Users").doc(id);
   var userData = await user.get();
   if(userData['isActive'] == true){
     user.update({'isActive' : false});
   }else{
      user.update({'isActive' : true});
   }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        centerTitle: true,
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          Provider.of<RoleProvider>(context).getRole() == 'Administrator'
              ? GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateProfile(
                          name: name,
                          lastName: lastName,
                          gender: gender,
                          birthDate: birthDate,
                          nationality: nationality,
                          role: role,
                          pictureUrl: pictureUrl,
                          id: id,
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _firebaseFirestore.collection("Users").doc(id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                name = snapshot.data['name'];
                lastName = snapshot.data['lastName'];
                gender = snapshot.data['gender'];
                birthDate = snapshot.data['birthDate'];
                nationality = snapshot.data['nationality'];
                role = snapshot.data['role'];
                pictureUrl = snapshot.data['pictureUrl'];
                buildingId = snapshot.data['building'];
                officeId = snapshot.data['office'];

                isActive = snapshot.data['isActive'];
                print(isActive);

                return SingleChildScrollView(
                  child: Column(
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
                                  ///TODO fa sa poata da pick image adminul
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
                                          '$name $lastName',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        child: Text(
                                          '$role',
                                          style: const TextStyle(fontSize: 25),
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
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Gender: $gender",
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
                              birthDate != ""
                                  ? "Birth date: $birthDate"
                                  : "Birth date: unknown",
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot2.data['name'] != ""
                                                  ? "Building: ${snapshot2.data['name']}"
                                                  : "Building: no building",
                                              style:
                                                  const TextStyle(fontSize: 20),
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
                                                      style: const TextStyle(
                                                          fontSize: 20),
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
                             const SizedBox(
                              height: 20,
                            ),
                           Text(
                              "Active account : $isActive",
                             style: const TextStyle(fontSize: 20,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
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
                                child: Text(
                                  "Assign a \n office",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SwitchUsersBuilding(
                                      userID: id,
                                    ),
                                  ),
                                );
                              },
                              //"De-assign office"
                              color: Color(0xFF398AB9),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              minWidth: MediaQuery.of(context).size.width * 0.25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Center(
                                  child: Text(
                                    "De-assign a office",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: deAssignUsersOffice,
                              color: Color(0xFF398AB9),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              minWidth: MediaQuery.of(context).size.width * 0.25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                      child: Text( isActive ?
                                    "Deactivate account" : "Activate account",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                              onPressed: _firebaseAuth.currentUser!.uid != id
                                  ? () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(

                                              title: const Center(
                                                  child: Text(
                                                "Are you sure?",

                                              )),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          deactivateActivateAccount();
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          isActive ?
                                                          "Deactivate account" :
                                                           "Activate account",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (state) =>
                                                                          Colors
                                                                              .white),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
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
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (state) =>
                                                                          Colors
                                                                              .white),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
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
                                    }
                                  : () {},
                              color: _firebaseAuth.currentUser!.uid != id
                                  ? Color(0xFF398AB9)
                                  : Colors.grey,
                            )
                          ],
                        ),
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
