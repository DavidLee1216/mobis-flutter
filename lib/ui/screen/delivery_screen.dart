import 'package:flutter/material.dart';
import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/ui/widget/delivery_info_form.dart';

class DeliveryScreen extends StatelessWidget {
  static const routeName = '/delivery';

  final CartModel item;
  final int count;

  const DeliveryScreen(
      {Key key, this.item, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '택배수령',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DeliveryInfoForm(
          item: item,
          count: count,
        ),
      ),
    );
  }
}
