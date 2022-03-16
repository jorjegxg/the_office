import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/providers/role_provider.dart';
import 'package:the_office/screens/cont_dezactivat_screen.dart';
import 'admin/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerificareContSpecial extends StatefulWidget {
  @override
  State<VerificareContSpecial> createState() => _VerificareContSpecialState();
}

class _VerificareContSpecialState extends State<VerificareContSpecial> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> ceRolAre() async {
    String role;

    var refUser = await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    role = refUser['role'];
    Provider.of<RoleProvider>(context, listen: false).changeRole(role);
    return role;
  }

   Future<bool> eActiv() async {
    bool isActive;

    var refUser = await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    isActive = refUser['isActive'];
    return isActive;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ceRolAre(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {         
                   return FutureBuilder(
                     future: eActiv(),
                     builder: (context, snapshot2) {
                       if(!snapshot2.hasData){
                         return Center(child: CircularProgressIndicator(),);
                       }else{
                         if(snapshot2.data == true){
                          return NavigationScreen();                       
                         }else{
                           return ContDezactivatScreen();
                         }
                       }
                      
                     }
                   ); 
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Eroare"),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
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
