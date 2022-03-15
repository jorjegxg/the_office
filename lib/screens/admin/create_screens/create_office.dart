import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:the_office/services/auth_methods.dart';
import 'package:the_office/services/firebase_firestore_functions.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/text_field_input.dart';

class CreateOffice extends StatefulWidget {
  const CreateOffice({Key? key,required this.id}) : super(key: key);

  final String id;
  @override
  _CreateOfficeState createState() => _CreateOfficeState();
}

class _CreateOfficeState extends State<CreateOffice> {
  bool _isLoading = false;
  var idAdmin = 'jSd08lygQOeeMmfufeKg9l1eXtz2';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Future<void> createUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String statusMessage = await AuthMethods().signUpUser(
  //     name: _nameController.text,
  //     lastName: _lastNameController.text,
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //     gender: selectedGender,
  //     birthDate:
  //     _date != null ? '${_date!.year}-${_date!.month}-${_date!.day}' : null,
  //     nationality: _nationalityController.text,
  //     role: selectedRole,
  //   );
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   if (statusMessage == 'success') {
  //     _nameController.clear();
  //     _lastNameController.clear();
  //     _emailController.clear();
  //     _passwordController.clear();
  //     _nationalityController.clear();
  //     setState(() {
  //       _date = null;
  //     });
  //   }
  //   showSnackBar(context, statusMessage);
  // }

  Future<void> createOffice() async {
    setState(() {
      _isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    String statusMessage;
    statusMessage = await FirebaseFirestoreFunctions().createOffice(
      name: _nameController.text,
      floorNumber: _floorsNumberController.text.isNotEmpty ? int.parse(_floorsNumberController.text) : -1,
      totalDeskCount:_totalDesksController.text.isNotEmpty ? int.parse(_totalDesksController.text) : -1,
      usableDeskCount:_usableDesksController.text.isNotEmpty ? int.parse(_usableDesksController.text) : -1,
      idAdmin: idAdmin,
      idBuilding: widget.id
    );
    setState(() {
      _isLoading = false;
    });

    if(statusMessage == 'success'){
      _nameController.clear();
      _floorsNumberController.clear();
      _totalDesksController.clear();
      _usableDesksController.clear();
      idAdmin = 'jSd08lygQOeeMmfufeKg9l1eXtz2';
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
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title:  FutureBuilder(
            future : _firebaseFirestore.collection('Buildings').doc(widget.id).get(),
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return Text("Create office in ${snapshot.data['name']}");
                }else if(snapshot.hasError){
                  return Text("Create office");
                }
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              return Text("Office");
            }
        ),
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
                                ConnectionState.done) if (snapshot.hasData) {
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
                                print(value);
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
                        'Create',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
              ),
              onPressed: () => createOffice(),
            ),
          ],
        ),
      ),
    );
  }
}
