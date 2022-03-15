import 'package:flutter/material.dart';
import 'package:the_office/services/firebase_firestore_functions.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/text_field_input.dart';

class CreateBuilding extends StatefulWidget {
  const CreateBuilding({Key? key}) : super(key: key);

  @override
  _CreateBuildingState createState() => _CreateBuildingState();
}

class _CreateBuildingState extends State<CreateBuilding> {
  bool _isLoading = false;

  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _floorsCountController = TextEditingController();
  final TextEditingController _buildingAddressController =
      TextEditingController();

  late FocusNode _buildingNameFocusNode;
  late FocusNode _floorsCountFocusNode;
  late FocusNode _buildingAddressFocusNode;

  @override
  void initState() {
    super.initState();
    _buildingNameFocusNode = FocusNode();
    _floorsCountFocusNode = FocusNode();
    _buildingAddressFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _buildingNameController.dispose();
    _floorsCountController.dispose();
    _buildingAddressController.dispose();

    _buildingNameFocusNode.dispose();
    _floorsCountFocusNode.dispose();
    _buildingAddressFocusNode.dispose();
  }

  void createBuilding() async {
    setState(() {
      _isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    String statusMessage = await FirebaseFirestoreFunctions().createBuilding(
      buildingName: _buildingNameController.text,
      floorsCount: int.parse(_floorsCountController.text),
      buildingAddress: _buildingAddressController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (statusMessage == 'success') {
      _buildingNameController.clear();
      _floorsCountController.clear();
      _buildingAddressController.clear();
    }
    showSnackBar(context, statusMessage);
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Text(
          "Create building",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFieldInput(
              textEditingController: _buildingNameController,
              hintText: 'Building name',
              focusNode: _buildingNameFocusNode,
              nextNode: _floorsCountFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _floorsCountController,
              hintText: 'Floors count',
              focusNode: _floorsCountFocusNode,
              nextNode: _buildingAddressFocusNode,
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(

                ///fa hint textul sa se duca sus dupa ce e apasat
                controller: _buildingAddressController,
                focusNode: _buildingAddressFocusNode,
                decoration: InputDecoration(
                  hintText: 'Building adress',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.text,
                obscureText: false,
                onEditingComplete: () {
                  createBuilding();
                  FocusManager.instance.primaryFocus?.unfocus();
                }),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: _isLoading == true
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
              ),
              onPressed: () => createBuilding(),
            ),
          ],
        ),
      ),
    );
  }
}
