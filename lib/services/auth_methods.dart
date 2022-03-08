import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:the_office/models/user_model.dart';

class AuthMethods {
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

    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    final FirebaseAuth _auth = FirebaseAuth.instanceFor(app: app);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    
    try {
      if (name.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          gender.isNotEmpty &&
          role.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel _user = UserModel(
            name: name,
            lastName: lastName,
            email: email,
            gender: gender,
            birthDate: birthDate ?? "",
            nationality: nationality ?? "",
            role: role,
            pictureUrl: "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/no-profile-picture-icon.png?alt=media&token=d409142b-3d04-4567-97cb-8e498a21a9f9",
            remoteProcentage : '0',
            building : "",
            office : "",
            requestStatus : false,
            id: _auth.currentUser!.uid,
        );

        // adding user in our database
        await _firestore
            .collection("Users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    app.delete();
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    
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

  void logout(){
    FirebaseAuth.instance.signOut();
  }
}
