import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/tiles_view/user_profile_view.dart';

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

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //tileColor: Color(0xFF398AB9),
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage("imagini/no-profile-picture-icon.png"),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(imagine),
                ),
              ],
            ),
            title: Text(nume),//,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
            subtitle: Text(rol)//,style: TextStyle(color: Colors.white),),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
