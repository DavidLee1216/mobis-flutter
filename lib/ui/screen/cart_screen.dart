import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/cart_bloc.dart';
import 'package:mobispartsearch/ui/widget/cart_product_form.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddToCartScreen(
    );
  }
}

class AddToCartScreen extends StatefulWidget {

  const AddToCartScreen({Key key,}) : super(key: key);

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  var checkAllState = false;
  CartBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CartBloc>(context);
    bloc.add(LoadCartEvent());
  }

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
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                      color: Colors.black),
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
                    style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 12,
                        color: kPrimaryColor),
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
              style: TextStyle(fontFamily: 'HDharmony', fontSize: 16),
            ),
            Expanded(
              child: SizedBox(
                width: 10,
              ),
            ),
            Text(
              '$price',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
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
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 12, color: Colors.white),
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
        title: Text(
          '장바구니',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
          cubit: BlocProvider.of<CartBloc>(context),
          builder: (BuildContext context, state) {
            return Stack(children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      '부품 구매는 방문 수령/택배를 이용할 수 있으며,\n 택배 수령시 택배비가 추가로 청구될 수 있으니\n판매점에 문의바랍니다.',
                      style: TextStyle(
                          fontFamily: 'HDharmony',
                          fontSize: 14,
                          color: Colors.black),
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
                  Divider(
                    color: Colors.black54,
                  ),
                  selectAllItem,
                  Divider(
                    color: Colors.black54,
                  ),
                  totalPrice(state.totalPrice),
                  SizedBox(
                    height: 30,
                  ),
                  buyItem,
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                child: LoadingIndicator(isLoading: state.isLoading),
              ),
            ]);
          }),
    );
  }
}
