import 'package:flutter/material.dart';

//text field custom

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.isPass = false,
    this.nextNode,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  final FocusNode? focusNode;
  final FocusNode? nextNode;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      ///fa hint textul sa se duca sus dupa ce e apasat
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      onEditingComplete: () => nextNode == null
          ? FocusManager.instance.primaryFocus?.unfocus()
          : nextNode!.requestFocus(),
    );
  }
}
