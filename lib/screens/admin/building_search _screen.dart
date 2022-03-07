import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_building.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:the_office/widgets/text_field_input.dart';

class BuildingSearchScreen extends StatefulWidget {
  const BuildingSearchScreen({Key? key}) : super(key: key);

  @override
  State<BuildingSearchScreen> createState() => _BuildingSearchScreenState();
}

class _BuildingSearchScreenState extends State<BuildingSearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Buildings")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnBuilding",
        child: const Icon(Icons.domain_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateBuilding()),
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
        ],
      ),
    );
  }
}
