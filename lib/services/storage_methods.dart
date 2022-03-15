import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadFile({
    required String name,
    required File file,
  }) async {
    //name = office_admin sau building sau office
    Reference ref = _storage.ref().child(name).child(_auth.currentUser!.uid);

    TaskSnapshot uploadData = await ref.putFile(file);

    String downloadUrl = await uploadData.ref.getDownloadURL();

    return downloadUrl;
  }
}
