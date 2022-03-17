import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/tiles_view/user_profile_view.dart' as  profile;

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
        ListTile(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => profile.UserProfileView(
                    id: id,
                  )),
            );
          },
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.all(1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //tileColor: Color(0xFF398AB9),
          leading: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Stack(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  backgroundImage:
                      AssetImage("imagini/no-profile-picture-icon.png"),
                ),
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(imagine),
                ),
              ],
            ),
          ),
          title: Text(
            nume,
            style: TextStyle(
              color: Colors.black,
              //fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          //,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          subtitle: Text(
            rol,
            style: TextStyle(
              color: Color.fromARGB(255, 41, 41, 41),
              fontSize: 16,
            ),
          ), //,style: TextStyle(color: Colors.white),),
        ),
        Divider(
          height:0,
         // color: Color.fromARGB(255, 211, 211, 211),
        ),
        // SizedBox(
        //   height: 15,
        // ),
      ],
    );
  }
}
