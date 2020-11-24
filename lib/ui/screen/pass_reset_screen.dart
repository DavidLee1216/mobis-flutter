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
        title: Text(''),
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
