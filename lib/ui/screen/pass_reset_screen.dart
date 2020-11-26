import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/pass_reset_form.dart';

class GetPassScreen extends StatefulWidget {
  @override
  _GetPassScreenState createState() => _GetPassScreenState();
}

class _GetPassScreenState extends State<GetPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '아이디 및 비밀번호 찾기',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GetPassForm(),
          ],
        ), //
      ),
    );
  }
}
