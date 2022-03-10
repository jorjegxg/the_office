import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/tiles_view/office_view_screen.dart';
import 'package:the_office/screens/admin/tiles_view/user_profile_view.dart';

class OfficeListWidget extends StatelessWidget {
  const OfficeListWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.building});

  final String nume, imagine, building, id;

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
                  builder: (context) => OfficeViewScreen()),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                imagine
              ),
            ),
            title: Text(nume),
            subtitle: Text(building),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
