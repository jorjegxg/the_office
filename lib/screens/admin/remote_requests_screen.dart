import 'package:flutter/material.dart';
import 'package:the_office/widgets/remote_request_widget.dart';

class RemoteRequestScreen extends StatelessWidget {
  const RemoteRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Center(child: Text("Remote Requests")),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          RemoteRequestWidget(
            nume: 'Popescu Ions',
            imagine: "imagini/profile.jpeg",
          ),
        ],
      ),
    );
  }
}
