import 'package:flutter/material.dart';

class RoleProvider extends ChangeNotifier{

  String role = 'User';

  String getRole()  =>  role;

  void changeRole(String newRole){
    role = newRole;
    notifyListeners();
  }
}