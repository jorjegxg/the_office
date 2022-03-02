import 'package:flutter/material.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/widgets/text_field_input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //cotrollere pentru text field //gen controller.clear //copntroller.text
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _passwordFocusNode;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //spatiu
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                //titlu
                const Text(
                  'The office',
                  style: TextStyle(fontSize: 45),
                ),
                //spatiu
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                //primul text field
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  nextNode: _passwordFocusNode,
                ),
                //spatiu
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0075,
                ),
                //al doilea text field
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                  focusNode: _passwordFocusNode,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                CustomButton(
                  color: Colors.white38,
                  circularCorners: 12,
                  text: 'Login',
                  fontSize: 19,
                  onPressed: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
