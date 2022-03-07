import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:the_office/services/auth_methods.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/text_field_input.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  bool _isLoading = false;

  Future<void> createUser() async {
    setState(() {
      _isLoading = true;
    });
    String statusMessage = await AuthMethods().signUpUser(
      name: _nameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      gender: selectedGender,
      birthDate: _date != null ? '${_date!.year}-${_date!.month}-${_date!.day}' : null,
      nationality: _nationalityController.text,
      role: selectedRole,
    );
    setState(() {
      _isLoading = false;
    });
    if(statusMessage == 'success'){
      _nameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _nationalityController.clear();
    }else{
    showSnackBar(context, statusMessage);
    }


  }

  DateTime? _date;
  String selectedRole = "User";
  List<DropdownMenuItem<String>> roleItems = [
    DropdownMenuItem(child: Text("User"), value: "User"),
    DropdownMenuItem(
        child: Text("Office Administrator"), value: "Office Administrator"),
    DropdownMenuItem(child: Text("Administrator"), value: "Administrator"),
  ];
  String selectedGender = "Male";
  List<DropdownMenuItem<String>> genderItems = [
    DropdownMenuItem(child: Text("Male"), value: "Male"),
    DropdownMenuItem(child: Text("Female"), value: "Female"),
  ];

  final TextEditingController _nameController        = TextEditingController();
  final TextEditingController _lastNameController    = TextEditingController();
  final TextEditingController _emailController       = TextEditingController();
  final TextEditingController _passwordController    = TextEditingController();
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
        title: Text(
          "Create user",
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
            SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _lastNameController,
              hintText: 'Last name',
              focusNode: _lastNameFocusNode,
              nextNode: _emailFocusNode,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Email',
              focusNode: _emailFocusNode,
              nextNode: _passwordFocusNode,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldInput(
              isPass: true,
              textEditingController: _passwordController,
              hintText: 'Password',
              focusNode: _passwordFocusNode,
              nextNode: _nationalityFocusNode,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _nationalityController,
              hintText: 'Nationality (optional)',
              focusNode: _nationalityFocusNode,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              color: Colors.white60,
              circularCorners: 12,
              text: _date == null
                  ? 'Pick birth date (optional)'
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
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
              ),
              onPressed: () => createUser(),
            ),
          ],
        ),
      ),
    );
  }
}
