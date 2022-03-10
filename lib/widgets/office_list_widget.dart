import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/tiles_view/office_view_screen.dart';

class OfficeListWidget extends StatelessWidget {
  const OfficeListWidget(
      {required this.nume,
      required this.imagine,
      required this.id,
      required this.floorNumber});

  final String nume, imagine, id;
  final int floorNumber;
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
                builder: (context) => OfficeViewScreen(),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                imagine,
              ),
            ),
            title: Text(nume),
            subtitle: Text('Etajul $floorNumber'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
