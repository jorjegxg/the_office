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
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      fillColor: Colors.grey[300],
      padding: const EdgeInsets.all(10),
      onPressed: () {},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              width: 60,
              height: 60,
              child: ClipOval(
                child: Image.asset(
                  "imagini/imagine.jpeg",
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nume),
              Text('Corp $corp ,etaj $etaj ,sala $sala'),
            ],
          ),
        ],
      ),
    );
  }
}
