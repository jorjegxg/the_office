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
        RawMaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey[300],
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OfficeSearchScreen(id: id,numeBulding: nume);
          })),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
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
