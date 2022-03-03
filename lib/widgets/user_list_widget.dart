import 'dart:ffi';

import 'package:flutter/material.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    required this.corp,
    required this.etaj,
    required this.nume,
    required this.sala,
  });

  final String nume, corp;
  final int etaj, sala;

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
            leading: const CircleAvatar(
              backgroundImage: AssetImage(
                "imagini/imagine.jpeg",
              ),
            ),
            title: Text(nume),
            subtitle: Text('Corp $corp ,etaj $etaj ,sala $sala'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
