import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/purchase_request_form.dart';

class PurchaseRequestScreen extends StatefulWidget {
  final partNumber;
  final koreanPartName;
  final englishPartName;
  final price;
  final companyMark;

  PurchaseRequestScreen(
      {Key key,
      this.partNumber,
      this.koreanPartName,
      this.englishPartName,
      this.price,
      this.companyMark})
      : super(key: key);

  @override
  _PurchaseRequestScreenState createState() => _PurchaseRequestScreenState();
}

class _PurchaseRequestScreenState extends State<PurchaseRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('구매요청'),
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
              companyMark: widget.companyMark,
            ),
          ],
        ), //
      ),
    );
  }
}
