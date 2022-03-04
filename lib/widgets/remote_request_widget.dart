import 'package:flutter/material.dart';
import 'user_list_widget.dart';

class RemoteRequestWidget extends StatelessWidget {
  const RemoteRequestWidget({required this.nume, required this.imagine});

  void onPressed() {}
  final String nume, imagine;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.grey[300],
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            imagine,
          ),
        ),
        title: Text(nume),
        subtitle: const Text("Reason" "asdasd"),
      ),
      onPressed: onPressed,
    );
  }
}
