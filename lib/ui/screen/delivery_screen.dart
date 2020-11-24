import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/delivery_info_form.dart';

class ScreenArguments {
  final String productName;
  final String companyMark;
  final int count;

  ScreenArguments(this.productName, this.companyMark, this.count);
}

class DeliveryScreen extends StatelessWidget {
  static const routeName = '/delivery';

  final String productName;
  final String companyMark;
  final int count;

  const DeliveryScreen(
      {Key key, this.productName, this.companyMark, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('택배수령'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DeliveryInfoForm(
          productName: productName,
          companyMark: companyMark,
          count: count,
        ),
      ),
    );
  }
}
