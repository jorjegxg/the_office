import 'package:flutter/material.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:the_office/widgets/text_field_input.dart';

class BuildingSearchScreen extends StatefulWidget {
  const BuildingSearchScreen({Key? key}) : super(key: key);

  @override
  State<BuildingSearchScreen> createState() => _BuildingSearchScreenState();
}

class _BuildingSearchScreenState extends State<BuildingSearchScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Widget> building_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Buildings")),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "btnBuilding",
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     setState(() {
      //       building_list.add(
      //         const UserListWidget(
      //           nume: 'nume',
      //           imagine: "imagini/profile.jpeg",
      //         ),
      //       );
      //     });
      //   },
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: TextFieldInput(
              textEditingController: _textController,
              hintText: "Search buildings",
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 30),
              child: ListView.builder(
                itemCount: building_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return building_list[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
