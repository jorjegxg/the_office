import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:the_office/services/auth_methods.dart';
import 'package:the_office/services/firebase_firestore_functions.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/text_field_input.dart';

class UpdateOffice extends StatefulWidget {
  const UpdateOffice({
    Key? key,
    required this.officeName,
    required this.floorNumber,
    required this.totalDeskCount,
    required this.usableDeskCount,
    required this.idAdmin, 
    required this.idOffice, 
    required this.idBuilding,
    required this.occupiedDeskCount
  }) : super(key: key);

  final String officeName;
  final int floorNumber;
  final int totalDeskCount;
  final int usableDeskCount;
  final int occupiedDeskCount;
  final String idAdmin;
  final String idOffice;
  final String idBuilding;

  @override
  _UpdateOfficeState createState() => _UpdateOfficeState();
}

class _UpdateOfficeState extends State<UpdateOffice> {
  bool _isLoading = false;
  var idAdmin = 'GRzHoyaXc2WzB9AcHK41caRSYtI3';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


   Future<void> updateOffice() async {
    setState(() {
      _isLoading = true;
    });

    
    String statusMessage = await FirebaseFirestoreFunctions().updateOffice(
      name: _nameController.text, 
      floorNumber: _floorsNumberController.text.isNotEmpty ? int.parse(_floorsNumberController.text) : -1,
      totalDeskCount:_totalDesksController.text.isNotEmpty ?  int.parse(_totalDesksController.text) : -1,
      usableDeskCount:_usableDesksController.text.isNotEmpty ? int.parse(_usableDesksController.text) : -1,
      occupiedDeskCount:widget.occupiedDeskCount,
      idAdmin: idAdmin,
      idBuilding: widget.idBuilding,
      idOffice: widget.idOffice
    );
    setState(() {
      _isLoading = false;
    });
    if (statusMessage == 'success') {
     Navigator.pop(context);
    }
    showSnackBar(context, statusMessage);
  }

  String selectedRole = "Employee";
  List<DropdownMenuItem<String>> roleItems = [
    DropdownMenuItem(child: Text("Employee"), value: "Employee"),
    DropdownMenuItem(
        child: Text("Office Administrator"), value: "Office Administrator"),
    const DropdownMenuItem(
        child: Text("Administrator"), value: "Administrator"),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _floorsNumberController = TextEditingController();
  final TextEditingController _totalDesksController = TextEditingController();
  final TextEditingController _usableDesksController = TextEditingController();

  late FocusNode _nameFocusNode;
  late FocusNode _floorsNumberFocusNode;
  late FocusNode _totalDesksFocusNode;
  late FocusNode _usableDesksFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _floorsNumberFocusNode = FocusNode();
    _totalDesksFocusNode = FocusNode();
    _usableDesksFocusNode = FocusNode();

    _nameController.text = widget.officeName;
    _floorsNumberController.text = widget.floorNumber.toString();
    _totalDesksController.text = widget.totalDeskCount.toString();
    _usableDesksController.text = widget.usableDeskCount.toString();

    idAdmin = widget.idAdmin;

  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _floorsNumberController.dispose();
    _totalDesksController.dispose();
    _usableDesksController.dispose();

    _nameFocusNode.dispose();
    _floorsNumberFocusNode.dispose();
    _totalDesksFocusNode.dispose();
    _usableDesksFocusNode.dispose();
  }

  ///birth date picker + role + gender
  @override
  Widget build(BuildContext context) {
    // print(widget.floorNumber);
    // print(widget.totalDeskCount);
    // print(widget.usableDeskCount);
  

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Text("Update office : ${widget.officeName}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView(
          children: [
            TextFieldInput(
              textEditingController: _nameController,
              hintText: 'Office name',
              focusNode: _nameFocusNode,
              nextNode: _floorsNumberFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _floorsNumberController,
              hintText: 'Floor number',
              focusNode: _floorsNumberFocusNode,
              nextNode: _totalDesksFocusNode,
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _totalDesksController,
              hintText: 'Total desk count',
              focusNode: _totalDesksFocusNode,
              nextNode: _usableDesksFocusNode,
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _usableDesksController,
              focusNode: _usableDesksFocusNode,
              decoration: InputDecoration(
                hintText: 'Usable desks count',
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                filled: true,
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.number,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),

            ///fa-l sa arate bine
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState ==
                                ConnectionState.done)
                                 if (snapshot.hasData) {
                          print(idAdmin);
                          return DropdownButton(
                            isExpanded: true,
                            value: idAdmin,
                            items: snapshot.data!.docs
                                .map(
                                  (element) => DropdownMenuItem<String>(
                                    value: element['id'],
                                    child: Text(element['name'] +
                                        ' ' +
                                        element['lastName']),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                idAdmin = value!;
                              });
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Row(
                            children: [
                              DropdownButton(items: [
                                DropdownMenuItem(
                                  child: Text("Cred ca nu ai net"),
                                  value: "",
                                ),
                              ], onChanged: (value) {}),
                              // CircularProgressIndicator(),
                            ],
                          ));
                        }
                        return Container();
                      }),
                ),
              ),
            ),
            const SizedBox(
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
                          'Update',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                ),
                onPressed: () => updateOffice() // createOffice(),
                ),
          ],
        ),
      ),
    );
  }
}
