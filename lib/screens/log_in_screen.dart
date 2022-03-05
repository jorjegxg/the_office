import 'package:flutter/material.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/services/auth_methods.dart';
import 'package:the_office/widgets/custom_button.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/text_field_input.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //cotrollere pentru text field //gen controller.clear //copntroller.text
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _passwordFocusNode;
  late FocusNode _emailFocusNode;
  bool isLoading = false;

  //primul lucru
  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  //atunci cand se trece pe alta pagina sa strice widgeturile
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  //logheaza userul
  void loginUser(String email, String password) async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isLoading = true;
    });
    String statusMessage =
        await AuthMethods().loginUser(email: email, password: password);


    showSnackBar(context, statusMessage);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //VARIABILA PENTRU TEXT FIELD - UL PASSWORD
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: Divider.createBorderSide(context),
    );
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
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                filled: true,
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.text,
                obscureText: true,

              //atunci cand termini de scris in password se logheaza
              onEditingComplete: () => loginUser(_emailController.text, _passwordController.text) ,
            ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                //buton login

                MaterialButton(
                  color: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: isLoading
                        ? CircularProgressIndicator(
                      color: Colors.black,
                    )
                        : Text(
                            'Login',
                            style: TextStyle(fontSize: 19),
                          ),
                  ),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    loginUser(_emailController.text, _passwordController.text);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
