import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_office/models/user_model.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Signing Up User

  Future<String> signUpUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String role,
    String? birthDate,
    String? nationality,
  }) async {
    String res = "Some error Occurred";
    try {
      if (name.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          gender.isNotEmpty &&
          role.isNotEmpty
      ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel _user = UserModel(
          name: name,
          lastName: lastName,
          email: email,
          gender: gender ,
          birthDate: birthDate ?? "",
          nationality: nationality ?? "",
          role: role,
          pictureUrl : ""
        );

        // adding user in our database
        await _firestore
            .collection(role)
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
