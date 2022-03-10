import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/main_screens/view_remote_request_screen.dart';

class RemoteRequestWidget extends StatelessWidget {
  RemoteRequestWidget({required this.nume, required this.imagine});

  final String nume, imagine;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Theme.of(context).primaryColor,
      child: ListTile(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                imagine,
              ),
              radius: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              nume,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                "Remote work procentage: 200%",
                style: TextStyle(fontSize: 15),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Remote work procentage: 20%",
                style: TextStyle(fontSize: 15),
                maxLines: 3,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewRemoteRequest(nume: nume, imagine: imagine)),
        );
      },
    );
  }
}
