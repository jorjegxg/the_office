import 'package:flutter/material.dart';
import 'package:the_office/widgets/text_field_input.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {

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
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create user",
          style: TextStyle(fontSize: 27),
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
            SizedBox(height: 20,),
            TextFieldInput(
              textEditingController: _lastNameController,
              hintText: 'Last name',
              focusNode: _lastNameFocusNode,
              nextNode: _emailFocusNode,
            ),
            SizedBox(height: 20,),
            TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Email',
              focusNode: _emailFocusNode,
              nextNode: _passwordFocusNode,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20,),
            TextFieldInput(
              isPass: true,
              textEditingController: _passwordController,
              hintText: 'Password',
              focusNode: _passwordFocusNode,
              nextNode: _nationalityFocusNode,
            ),
            SizedBox(height: 20,),
            TextFieldInput(
              textEditingController: _nationalityController,
              hintText: 'Nationality',
              focusNode: _nationalityFocusNode,
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
