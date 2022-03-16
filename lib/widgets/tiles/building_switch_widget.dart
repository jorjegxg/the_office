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
    return Column(children: [
      Divider(
        height: 0,
        color: Color.fromARGB(255, 153, 153, 153),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SwitchUsersOffice(
              id: id,
              userID: userID,
              buildingName: nume,
            );
          }));
        },
        leading: Padding(
          padding: const EdgeInsets.only(left : 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              imagine,
            ),
          ),
        ),
        title: Text(nume),
      ),
      // SizedBox(
      //   height: 10,
      // ),
      Divider(
        height: 0,
        color: Color.fromARGB(255, 153, 153, 153),
      ),
    ]);
  }
}
