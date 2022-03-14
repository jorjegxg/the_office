import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/switch_user_office_screen.dart';
import 'package:the_office/widgets/tiles/office_list_widget.dart';

class BuildingSwitchWidget extends StatelessWidget {
  const BuildingSwitchWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.userID});

  final String nume, imagine, id, userID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey[300],
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SwitchUsersOffice(
              id: id,
              userID: userID,
              buildingName: nume,
            );
          })),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
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
