import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_building.dart';
import 'package:the_office/widgets/text_field_input.dart';

class BuildingSearchScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  final List<Widget> building_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Center(child: Text("Buildings")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnBuilding",
        child: const Icon(Icons.domain_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateBuilding()),
          );
        },
      ),
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
