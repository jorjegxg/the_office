import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/providers/role_provider.dart';
import 'package:the_office/screens/admin/main_screens/view_remote_request_screen.dart';
import 'admin/navigation_bar.dart';
import 'package:the_office/screens/admin/tiles_view/office_search_screen.dart';
import 'package:the_office/screens/employee/employee_user_search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_office/screens/admin/tiles_view/office_view_screen.dart';
import 'package:the_office/screens/admin/switch_user_building_screen.dart';

class VerificareContSpecial extends StatefulWidget {
  @override
  State<VerificareContSpecial> createState() => _VerificareContSpecialState();
}

class _VerificareContSpecialState extends State<VerificareContSpecial> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> ceRolAre() async {
    // bool isAdmin = false;
    // var colectieAdmini =
    //     await _firebaseFirestore.collection('Administrator').get();
    // colectieAdmini.docs.forEach((element) {
    //   if (element['email'] == _firebaseAuth.currentUser!.email) {
    //     isAdmin = true;
    //     print("$isAdmin");
    //   }
    // });
    // return isAdmin;

    String role;

    var refUser = await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

      role = refUser['role'];
      print('$role');
      Provider.of<RoleProvider>(context, listen: false).changeRole(role);

    return role;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ceRolAre(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
              return NavigationScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Eroare"),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        });
    // esteAdmin() == true ? :;
  }
}
