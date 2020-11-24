import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('회원가입'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          RegisterForm(), //
        ],
      ),
    );
  }
}
