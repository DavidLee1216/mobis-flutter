import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/cart_bloc.dart';
import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/model/product_model.dart';
import 'package:mobispartsearch/ui/screen/delivery_screen.dart';
import 'package:mobispartsearch/ui/screen/visit_screen.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'package:mobispartsearch/common.dart' as common;

class CartProductsForm extends StatefulWidget {
  @override
  _CartProductsFormState createState() => _CartProductsFormState();
}

class _CartProductsFormState extends State<CartProductsForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        cubit: BlocProvider.of<CartBloc>(context),
        builder: (BuildContext context, state) {
          if (state.productList == null || state.productList.length == 0) {
            return Container();
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: state.productList.length,
              itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              CartProductForm(
                cartItem: state.productList[index],
                checkedAll: state.checkAllState,
              ),
              Divider(
                color: Colors.black54,
              ),
            ]);
          });
        });
  }
}

class CartProductForm extends StatefulWidget {
  final CartModel cartItem;
  final checkedAll;

  const CartProductForm(
      {Key key,
      this.cartItem,
      this.checkedAll,
      })
      : super(key: key);
  @override
  _CartProductFormState createState() => _CartProductFormState();
}

class _CartProductFormState extends State<CartProductForm> {
  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);

    var productNameItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Checkbox(
          onChanged: (bool value) {
            setState(() {
            });
            bloc.add(CheckEvent(widget.cartItem.seq, value));
          },
          tristate: false,
          value: widget.checkedAll ? widget.checkedAll : widget.cartItem.checked,
          activeColor: kPrimaryColor,
        ),
        Text(
          widget.cartItem.krname,
          style: TextStyle(
              fontFamily: 'HDharmony', fontSize: 14, color: Colors.black),
        ),
        Expanded(
            child: SizedBox(
          width: 2,
        )),
        GestureDetector(
          child: Icon(Icons.clear),
          onTap: () {
            bloc.add(DelCartEvent(widget.cartItem.seq));
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
                  if (widget.cartItem.count > 1)
                    bloc.add(ChangeCountEvent(widget.cartItem.seq, widget.cartItem.count-1));
                });
              },
            ),
          ),
          Container(
              child: Text(
            widget.cartItem.count.toString(),
            style: TextStyle(
                fontFamily: 'HDharmony', fontSize: 12, color: Colors.black),
          )),
          Container(
            child: IconButton(
              icon: Icon(Icons.add_circle),
              color: Colors.black26,
              onPressed: () {
                setState(() {
                  bloc.add(ChangeCountEvent(widget.cartItem.seq, widget.cartItem.count+1));
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
            '${widget.cartItem.price}원',
            style: TextStyle(
              fontFamily: 'HDharmony',
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
              fontFamily: 'HDharmony',
              fontSize: 14,
            ),
          ),
          Expanded(
              child: SizedBox(
            width: 1,
          )),
          Text(
            '${widget.cartItem.price * widget.cartItem.count}원',
            style: TextStyle(
              fontFamily: 'HDharmony',
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
            widget.cartItem.mutual,
            style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
          ),
          widget.cartItem.deliveryCode=='P'
              ? Expanded(
                  child: Row(
                  children: [
                    Text(' | '),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          '택배로 받기',
                          style:
                              TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        if (widget.cartItem.checked) {
                          pushTo(
                              context,
                              DeliveryScreen(
                                item: widget.cartItem,
                                count: widget.cartItem.count,
                              ));
//                            Navigator.pushNamed(context, DeliveryScreen.routeName, arguments: ScreenArguments(widget.productName, widget.companyMark, count));
                        }
                      },
                    )
                  ],
                ))
              : Expanded(
                  child: Row(
                  children: [
                    Text(' | '),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          '방문 수령',
                          style:
                              TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        if (widget.cartItem.checked) {
                          pushTo(
                              context,
                              VisitScreen(
                                item: widget.cartItem,
                                count: widget.cartItem.count,
                              ));
//                              Navigator.pushNamed(context, VisitScreen.routeName, arguments: ScreenArguments(widget.productName, widget.companyMark, count));
                        }
                      },
                    )
                  ],
                )),
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
