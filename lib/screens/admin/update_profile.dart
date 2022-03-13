import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:the_office/services/auth_methods.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/text_field_input.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key ,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    required this.nationality,
    required this.role,
    required this.pictureUrl,required this.id,}) : super(key: key);

    final String name;
    final String lastName;
    final String gender;
    final String birthDate;
    final String nationality;
    final String role;
    final String pictureUrl;
    final String id;

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool _isLoading = false;

  Future<void> updateUser() async {
    setState(() {
      _isLoading = true;
    });
    String statusMessage = await AuthMethods().updateUser(
      name: _nameController.text,
      lastName: _lastNameController.text,
      gender: selectedGender,
      ///todo vezi la data ca poate fi ""
      birthDate:
      _date != null ? '${_date!.year}-${_date!.month}-${_date!.day}' : widget.birthDate,
      nationality: _nationalityController.text,
      role: selectedRole,
      id: widget.id,
      pictureUrl: widget.pictureUrl,
    );
    setState(() {
      _isLoading = false;
    });
    if (statusMessage == 'success') {
      _nameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _nationalityController.clear();
      setState(() {
        _date = null;
      });
    }
    showSnackBar(context, statusMessage);
  }

  DateTime? _date;
  String selectedRole = "Employee";
  List<DropdownMenuItem<String>> roleItems = [
    const DropdownMenuItem(child: Text("Employee"), value: "Employee"),
    const DropdownMenuItem(
        child: Text("Office Administrator"), value: "Office Administrator"),
    const DropdownMenuItem(
        child: Text("Administrator"), value: "Administrator"),
  ];
  String selectedGender = "Male";
  List<DropdownMenuItem<String>> genderItems = [
    const DropdownMenuItem(child: Text("Male"), value: "Male"),
    const DropdownMenuItem(child: Text("Female"), value: "Female"),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();


  late FocusNode _nameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _nationalityFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _nationalityFocusNode = FocusNode();

    _nameController.text =  widget.name;
    _lastNameController.text = widget.lastName;
    _nationalityController.text = widget.nationality;
    selectedGender = widget.gender;
    selectedRole = widget.role;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nationalityController.dispose();

    _nameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nationalityFocusNode.dispose();
  }

  ///birth date picker + role + gender
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: const Text(
          "Update user",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView(
          children: [
            TextFieldInput(
              textEditingController: _nameController,
              hintText: 'Name',
              focusNode: _nameFocusNode,
              nextNode: _lastNameFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _lastNameController,
              hintText: 'Last name',
              focusNode: _lastNameFocusNode,
              nextNode: _emailFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _nationalityController,
              hintText: 'Nationality (optional)',
              focusNode: _nationalityFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              color: Colors.white60,
              circularCorners: 12,
              text: _date == null
                  ? widget.birthDate
                  : 'Date picked : ${_date!.year}-${_date!.month}-${_date!.day}',
              fontSize: 14,
              onPressed: () async {
                var datePicked = await DatePicker.showSimpleDatePicker(
                  context,
                  initialDate: DateTime(1994),
                  firstDate: DateTime(1960),
                  lastDate: DateTime(2012),
                  dateFormat: "dd-MMMM-yyyy",
                  locale: DateTimePickerLocale.ro,
                  // looping: true,
                );
                setState(() {
                  _date = datePicked;
                });
              },
            ),

            ///fa-l sa arate bine
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectedRole,
                    items: roleItems,
                    onChanged: (String? value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButton(
                    isExpanded: true,
                    focusColor: Colors.grey,
                    value: selectedGender,
                    items: genderItems,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                  ),
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
              onPressed: () {
                updateUser();
                Navigator.pop(context);
              } ,
            ),
          ],
        ),
      ),
    );
  }
}
