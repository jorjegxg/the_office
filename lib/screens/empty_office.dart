import 'package:flutter/material.dart';

class EmptyOffice extends StatelessWidget {
  const EmptyOffice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No Office"),
        centerTitle: true,
      ),
    );
  }
}
