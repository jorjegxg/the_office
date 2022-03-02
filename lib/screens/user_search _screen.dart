import 'package:flutter/material.dart';
import 'package:the_office/widgets/user_list_widget.dart';

class UserSearchScreen extends StatelessWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: const Center(child: Text("Users")),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
        child: ListView(
          children: const [
            UserListWidget(corp: 'corp', etaj: 1, nume: 'nume', sala: 321),
            SizedBox(
              height: 20,
            ),
            UserListWidget(corp: 'corp', etaj: 1, nume: 'nume', sala: 321),
            SizedBox(
              height: 20,
            ),
            UserListWidget(corp: 'corp', etaj: 1, nume: 'nume', sala: 321),
          ],
        ),
      ),
    );
  }
}
