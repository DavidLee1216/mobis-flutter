import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/widget/purchase_request_form.dart';

class PurchaseRequestScreen extends StatefulWidget {
  @override
  _PurchaseRequestScreenState createState() => _PurchaseRequestScreenState();
}

class _PurchaseRequestScreenState extends State<PurchaseRequestScreen> {
  var partNumber = '97651B2000';
  var koreanPartName = '플레이트 & 그로메트－에어컨 쿨러 라인';
  var englishPartName = 'PLATE & GROMMET-A/C COOLER LIN';
  var price = '1,870원';
  var companyMark = '강원부품(주)';

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
            PurchaseRequestForm(partNumber: '97651B2000', koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인', englishPartName: 'PLATE & GROMMET-A/C COOLER LIN', price: 1870, companyMark: '강원부품(주)',),
          ],
        ), //
      ),
    );
  }
}
