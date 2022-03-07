import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/user_search%20_screen.dart';
import 'package:the_office/screens/employee/user_search_screen.dart';
import 'admin/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class VerificareContSpecial extends StatefulWidget {

  @override
  State<VerificareContSpecial> createState() => _VerificareContSpecialState();
}

class _VerificareContSpecialState extends State<VerificareContSpecial> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<bool> esteAdmin() async {
    bool isAdmin = false;
    var colectieAdmini = await _firebaseFirestore.collection('Administrator').get();
      colectieAdmini.docs.forEach((element) {
        if(element['email'] == _firebaseAuth.currentUser!.email){
          isAdmin = true;
          print("$isAdmin");
        }
      });
    return isAdmin;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: esteAdmin(),
        builder: (context,snapshot){
        if(snapshot.hasData){
          if(snapshot.data == true){
            return NavigationScreen();
          }else{
            return EmployeeUserSearchScreen();
          }
        }else if(snapshot.hasError){
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
        }
    );
     // esteAdmin() == true ? :;

  }
}
