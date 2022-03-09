import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/user_profile_view.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.rol});

  final String nume, imagine, rol, id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey[300],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserProfileView(
                        id: id,
                      )),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                imagine,
              ),
            ),
            title: Text(nume),
            subtitle: Text(rol),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
