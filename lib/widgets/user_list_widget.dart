import 'package:flutter/material.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({required this.nume, required this.imagine});

  final String nume, imagine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey[300],
          onPressed: () {},
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                imagine,
              ),
            ),
            title: Text(nume),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
