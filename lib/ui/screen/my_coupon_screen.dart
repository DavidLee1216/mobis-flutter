import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCouponScreen extends StatefulWidget {
  @override
  _MyCouponScreenState createState() => _MyCouponScreenState();
}

class _MyCouponScreenState extends State<MyCouponScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    couponItem(String couponSubject, String fromDate, String toDate,
        String target, String couponNumber) {
      return Container(
        width: screenWidth * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$couponSubject 쿠폰 ',
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                      color: const Color(0xFF074B88),
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Icon(Icons.clear),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '(유효기간: $fromDate ~ $toDate)',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '대상품목 : $target',
              style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '쿠폰 번호 : $couponNumber',
              style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('My 쿠폰'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                couponItem('소모품 할인', '2020년 10월', '2020년 11월',
                    '워셔액, 와이퍼, 에어컨 필터', '0000-0000-0000-0000'),
                SizedBox(
                  height: 10,
                ),
                couponItem('미세먼지 이겨내요', ' 2020년 10월', '2020년 11월', '에어컨 필터',
                    '0000-0000-0000-0000'),
                SizedBox(
                  height: 20,
                ),
                couponItem('소모품 할인', '2020년 10월', '2020년 11월',
                    '워셔액, 와이퍼, 에어컨 필터', '0000-0000-0000-0000'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
