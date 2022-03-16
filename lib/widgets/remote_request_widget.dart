import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/view_remote_request_screen.dart';

class RemoteRequestWidget extends StatelessWidget {
  RemoteRequestWidget({
    required this.nume,
    required this.imagine,
    required this.message,
    required this.remoteProcentage,
    required this.requestStatus,
    required this.role,
    required this.id,
    required this.mine,
    required this.adminMessage,
  });

  final String nume, imagine, message, role, id, adminMessage;
  String remoteProcentage;
  bool requestStatus, mine;

  @override
  Widget build(BuildContext context) {
    if (role == 'Administrator') {
      return requestStatus == true
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                child: ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
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
                          "Remote work procentage: $remoteProcentage%",
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
                        child: Text(
                          message,
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
                      builder: (context) => ViewRemoteRequest(
                        nume: nume,
                        imagine: imagine,
                        remoteProcentage: remoteProcentage,
                        message: message,
                        id: id,
                        adminMessage: adminMessage,
                      ),
                    ),
                  );
                },
              ),
            )
          : SizedBox();
    } else {
      if (mine == true && requestStatus == true) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
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
                      "Remote work procentage: $remoteProcentage%",
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
                    child: Text(
                      message,
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
                    builder: (context) => ViewRemoteRequest(
                          nume: nume,
                          imagine: imagine,
                          remoteProcentage: remoteProcentage,
                          message: message,
                          id: id,
                          adminMessage: adminMessage,
                        )),
              );
            },
          ),
        );
      } else {
        return const SizedBox();
      }
    }
  }
}
