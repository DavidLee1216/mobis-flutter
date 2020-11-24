import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/screen/delivery_screen.dart';
import 'package:mobispartsearch/ui/widget/visit_info_form.dart';

class VisitScreen extends StatelessWidget {

  static const routeName = '/visit';

  final productName;
  final companyMark;
  final count;

  const VisitScreen({Key key, this.productName, this.companyMark, this.count}) : super(key: key);


  @override
  Widget build(BuildContext context) {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('방문수령'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: VisitInfoForm(productName: productName, companyMark: companyMark, count: count,),
      ),

    );
  }
}
