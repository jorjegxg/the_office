import 'package:flutter/material.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({required this.nume, required this.imagine, required this.id,required this.adress});

  final String nume, imagine,adress,id;

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
              backgroundImage: NetworkImage(
                imagine,
              ),
            ),
            title: Text(nume),
            subtitle: Text(adress),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
