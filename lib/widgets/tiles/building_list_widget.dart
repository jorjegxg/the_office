import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/tiles_view/office_search_screen.dart';

class BuildingListWidget extends StatelessWidget {
  const BuildingListWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.adress});

  final String nume, imagine, adress, id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OfficeSearchScreen(idBuilding: id, buildingName: nume);
                },
              ),
            );
          },
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.all(1.0),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
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
            adress,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ), //,style: TextStyle(color: Colors.white),),
        ),
         Divider(
          height:0,
          //color: Color.fromARGB(255, 180, 180, 180),
        ),
      ],
    );
  }
}
/* Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OfficeSearchScreen(idBuilding: id,buildingName: nume);
          })),*/
