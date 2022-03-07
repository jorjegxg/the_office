import 'package:flutter/material.dart';

class EmployeeUserSearchScreen extends StatefulWidget {
  const EmployeeUserSearchScreen({Key? key}) : super(key: key);

  @override
  _EmployeeUserSearchScreenState createState() => _EmployeeUserSearchScreenState();
}

class _EmployeeUserSearchScreenState extends State<EmployeeUserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Employeee"),
      ),
    );
  }
}
