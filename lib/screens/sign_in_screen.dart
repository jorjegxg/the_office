import 'package:flutter/material.dart';
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


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 32),
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
                ),
                //spatiu
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.0075,
                ),
                //al doilea text field
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                MaterialButton(
                  //elevation: 0,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                    child: Text('Login',style: TextStyle(fontSize: 24),),
                  ),
                  onPressed: () {  },///adauga login
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
