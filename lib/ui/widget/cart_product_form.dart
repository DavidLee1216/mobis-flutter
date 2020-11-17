import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/bloc/cart_bloc.dart';
import 'package:hyundai_mobis/ui/screen/delivery_screen.dart';
import 'package:hyundai_mobis/ui/screen/visit_screen.dart';
import 'package:hyundai_mobis/ui/screen/home_screen.dart';
import 'package:hyundai_mobis/utils/navigation.dart';

class CartProductsForm extends StatefulWidget {

  @override
  _CartProductsFormState createState() => _CartProductsFormState();
}

class _CartProductsFormState extends State<CartProductsForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        cubit: BlocProvider.of<CartBloc>(context),
        builder: (BuildContext context, state){
          return ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                    CartProductForm(productName: state.productList[index].krname, companyMark: state.productList[index].mutual, price: state.productList[index].price,
                      delivery: state.productList[index].deliveryCode, checked: state.productList[index].checked, seq: state.productList[index].seq,),
                    Divider(color: Colors.black54,),
                  ]
                );
              });
        });
  }
}

class CartProductForm extends StatefulWidget {
  final price;
  final productName;
  final companyMark;
  final delivery;
  final checked;
  final seq;

  const CartProductForm(
      {Key key, this.price, this.productName, this.companyMark, this.delivery, this.checked, this.seq})
      : super(key: key);
  @override
  _CartProductFormState createState() => _CartProductFormState();
}

class _CartProductFormState extends State<CartProductForm> {
  bool checkState = false;
  var count = 1;
  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);
    checkState = widget.checked?true:checkState;

    var productNameItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Checkbox(
          onChanged: (bool value) {
            setState(() {
              checkState = value;
            });
          },
          tristate: false,
          value: checkState,
          activeColor: kPrimaryColor,
        ),
        Text(
          widget.productName,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        Expanded(
            child: SizedBox(
          width: 2,
        )),
        GestureDetector(
          child: Icon(Icons.clear),
          onTap: () {
            bloc.add(DelCartEvent(widget.seq));
          },
        ),
      ]),
    );

    var countItem = Container(
      child: Row(
        children: [
          Container(
            child: IconButton(
              icon: Icon(Icons.remove_circle),
              color: Colors.black26,
              onPressed: () {
                setState(() {
                  if (count > 1) count--;
                });
              },
            ),
          ),
          Container(
//              width: 12,
//              height: 12,
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 12, color: Colors.black),
              )),
          Container(
            child: IconButton(
              icon: Icon(Icons.add_circle),
              color: Colors.black26,
              onPressed: () {
                setState(() {
                  count++;
                });
              },
            ),
          ),
        ],
      ),
    );

    var priceItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            '${widget.price}원',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Expanded(
              child: SizedBox(
            width: 1,
          )),
          countItem,
        ],
      ),
    );

    var totalPriceItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            '상품 금액',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Expanded(
              child: SizedBox(
            width: 1,
          )),
          Text(
            '${widget.price * count}원',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );

    var companyMarkItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            widget.companyMark,
            style: TextStyle(fontSize: 14),
          ),
          widget.delivery
              ? Expanded(
                  child: Row(
                    children: [
                      Text(' | '),
                      GestureDetector(
                        child: Container(
                          child: Text(
                            '택배로 받기',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        onTap: () {
                          if(checkState) {
                            pushTo(context, DeliveryScreen(productName: widget.productName, companyMark: widget.companyMark, count: count,));
//                            Navigator.pushNamed(context, DeliveryScreen.routeName, arguments: ScreenArguments(widget.productName, widget.companyMark, count));
                          }
                        },
                      )
                    ],
                  )
                )
              : Expanded(
                    child: Row(
                      children: [
                        Text(' | '),
                        GestureDetector(
                          child: Container(
                            child: Text(
                              '방문 수령',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          onTap: () {
                            if(checkState) {
                              pushTo(context, VisitScreen(productName: widget.productName, companyMark: widget.companyMark, count: count,));
//                              Navigator.pushNamed(context, VisitScreen.routeName, arguments: ScreenArguments(widget.productName, widget.companyMark, count));
                            }
                          },
                        )
                      ],
                    )
                ),
        ],
      ),
    );

    return Container(
      child: Column(
        children: [
          productNameItem,
          priceItem,
          totalPriceItem,
          SizedBox(
            height: 10,
          ),
          companyMarkItem,
        ],
      ),
    );
  }
}
