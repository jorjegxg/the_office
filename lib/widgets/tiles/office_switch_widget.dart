import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/tiles_view/office_view_screen.dart';
import 'package:the_office/screens/admin/tiles_view/user_profile_view.dart';

class OfficeSwitchWidget extends StatelessWidget {
  const OfficeSwitchWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.count});

  final String nume, imagine, id;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        count != 0
            ? RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                fillColor: Colors.grey[300],
                onPressed: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(imagine),
                  ),
                  title: Text(nume),
                ),
              )
            : SizedBox(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
