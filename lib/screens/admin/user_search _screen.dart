import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_user.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/widgets/text_field_input.dart';
class UserSearchScreen extends StatefulWidget {
  UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {

  final TextEditingController _textController = TextEditingController();
  final List<Widget> user_list = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Users")),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateUser()),);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: TextFieldInput(
              textEditingController: _textController,
              hintText: "Search users",
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 30),
              child: ListView.builder(
                itemCount: user_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserListWidget(
                    nume: 'nume',
                    imagine: "imagini/imagine.jpeg",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
