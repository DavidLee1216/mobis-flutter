import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/cart_bloc.dart';
import 'package:mobispartsearch/ui/widget/cart_product_form.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';

class CartScreenArguments {
  final bool deliveryKind; //true: 택배, false:방문

  CartScreenArguments(this.deliveryKind);
}

class CartScreen extends StatelessWidget {
  static const routeName = '/addToCart';
  final deliveryKind;

  const CartScreen({Key key, this.deliveryKind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final CartScreenArguments args = ModalRoute.of(context).settings.arguments;
//    return AddToCartScreen(deliverKind: args.deliveryKind,);
    return AddToCartScreen(
      deliverKind: deliveryKind,
    );
  }
}

class AddToCartScreen extends StatefulWidget {
  final bool deliverKind;

  const AddToCartScreen({Key key, this.deliverKind}) : super(key: key);

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  var checkAllState = false;
  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);

    void _delCart() {
      bloc.add(DelAllEvent());
    }

    var selectAllItem = Container(
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(children: [
                Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      checkAllState = value;
                    });
                    bloc.add(CheckAllEvent(checkAllState));
                  },
                  tristate: false,
                  value: checkAllState,
                  activeColor: kPrimaryColor,
                ),
                Text(
                  '전체 선택',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ])),
          Expanded(
              child: SizedBox(
            width: 10,
          )),
          Container(
            height: 30,
            padding: EdgeInsets.only(right: 20),
            child: OutlineButton(
              borderSide: BorderSide(
                color: kPrimaryColor, //Color of the border
                style: BorderStyle.solid, //Style of the border
                width: 1, //width of the border
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.clear,
                    color: kPrimaryColor,
                  ),
                  Text(
                    '선택 상품 삭제',
                    style: TextStyle(fontSize: 12, color: kPrimaryColor),
                  ),
                ],
              ),
              onPressed: () {
                _delCart();
              },
            ),
          ),
        ],
      ),
    );

    totalPrice(int price) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Text(
              '총 주문 금액',
              style: TextStyle(fontSize: 16),
            ),
            Expanded(
              child: SizedBox(
                width: 10,
              ),
            ),
            Text(
              '$price',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    var buyItem = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            buttonColor: kPrimaryColor,
            child: RaisedButton(
              child: Text(
                '구매요청',
                style: TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
//                Navigator.of(context).pushNamed('/purchase');
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('장바구니'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '부품 구매는 방문 수령/택배를 이용할 수 있으며,\n 택배 수령시 택배비가 추가로 청구될 수 있으니\n판매점에 문의바랍니다.',
                style: TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.black54,
            ),
            selectAllItem,
            Divider(
              color: Colors.black54,
            ),
            CartProductsForm(),
//              CartProductForm(productName:'플레이트 & 그로메트－에어컨 쿨러 라인', price: 1870, companyMark:'강원부품(주)', delivery: widget.deliverKind, checked: checkAllState,),
//              Divider(color: Colors.black54,),
//              CartProductForm(productName:'필터 앗세이－오일', price: 101640, companyMark:'강원부품(주)', delivery: widget.deliverKind, checked: checkAllState,),
            Divider(
              color: Colors.black54,
            ),
            selectAllItem,
            Divider(
              color: Colors.black54,
            ),
            totalPrice(5610),
            SizedBox(
              height: 30,
            ),
            buyItem,
            SizedBox(
              height: 30,
            ),
          ],
        ), //
      ),
    );
  }
}
