import 'package:flutter/material.dart';
import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/ui/widget/purchase_request_form.dart';

class PurchaseRequestScreen extends StatefulWidget {
  final String partNumber;
  final String koreanPartName;
  final String englishPartName;
  final int price;
  final MarketSearchResultModel result;
  final bool canSale;

  PurchaseRequestScreen({
    Key key,
    this.partNumber,
    this.koreanPartName,
    this.englishPartName,
    this.price,
    this.result,
    this.canSale,
  }) : super(key: key);

  @override
  _PurchaseRequestScreenState createState() => _PurchaseRequestScreenState();
}

class _PurchaseRequestScreenState extends State<PurchaseRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '구매요청',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            PurchaseRequestForm(
              partNumber: widget.partNumber,
              koreanPartName: widget.koreanPartName,
              englishPartName: widget.englishPartName,
              price: widget.price,
              result: widget.result,
            ),
          ],
        ), //
      ),
    );
  }
}
