import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);
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
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        title: const Text(
          "Profile",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Role: $statut",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: const Text("Assign office"),
                  onPressed: () {
                    ///TODO assign office
                  },
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: const Text("De-assign office"),
                  onPressed: () {
                    ///TODO deassign office
                  },
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: const Text("Deactivate account"),
                  onPressed: () {
                    ///TODO deactivate acount
                  },
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
