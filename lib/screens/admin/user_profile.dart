import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);
  final String titlu = "Profil";
  final String nume = "Admin adin";
  final String statut = "Administrator";
  final String email = "admin@gmail.com";
  final String cladire = "Corp A";
  final String birou = "301";
  final int remote = 38;
  final String gen = "Male";
  final String data = "01/21/2020";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
        title: const Text(
          "Profile",
        ),
        actions: const [
          Icon(Icons.logout),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("imagini/imagine.jpeg"),
              radius: 50,
            ),
            title: Text(
              nume,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            subtitle: Text(
              statut,
              style: const TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              email,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Building: $cladire",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Office: $birou",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Remote Work: $remote%",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Birth date: $data",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Gender: $gen",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
