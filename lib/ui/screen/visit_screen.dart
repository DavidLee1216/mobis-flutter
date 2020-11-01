import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/screen/delivery_screen.dart';
import 'package:hyundai_mobis/ui/widget/visit_info_form.dart';

class VisitScreen extends StatelessWidget {

  static const routeName = '/visit';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('방문수령'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: VisitInfoForm(productName: args.productName, companyMark: args.companyMark, count: args.count,),
      ),

    );
  }
}
