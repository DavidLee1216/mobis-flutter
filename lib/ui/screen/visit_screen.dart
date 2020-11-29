import 'package:flutter/material.dart';
import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/ui/widget/visit_info_form.dart';

class VisitScreen extends StatelessWidget {
  static const routeName = '/visit';

  final CartModel item;
  final count;

  const VisitScreen({Key key, this.item, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '방문수령',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: VisitInfoForm(
          item: item,
          count: count,
        ),
      ),
    );
  }
}
