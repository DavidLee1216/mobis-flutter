import 'package:flutter/material.dart';

class CartProductForm extends StatefulWidget {
  final price;
  final productName;
  final companyMark;
  final delivery;

  const CartProductForm({Key key, this.price, this.productName, this.companyMark, this.delivery}) : super(key: key);
  @override
  _CartProductFormState createState() => _CartProductFormState();
}

class _CartProductFormState extends State<CartProductForm> {
  bool checkState = false;
  var count = 1;
  @override
  Widget build(BuildContext context) {

    var productNameItem = Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
            children: [
              Checkbox(
                onChanged: (bool value) {
                  setState(() {
                    checkState = value;
                  });
                },
                tristate: false,
                value: checkState,
                activeColor: Color.fromRGBO(0, 63, 114, 1),
              ),
              Text(
                widget.productName,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Expanded(child: SizedBox(width: 2,)),
              GestureDetector(
                child: Icon(Icons.clear),
                onTap: () {

                },
              ),
            ]
        ),
    );

    var countItem = Container(
      child: Row(
        children: [
          Container(
            child: IconButton(
              icon: Icon(Icons.remove_circle),
              color: Colors.black26,
              onPressed: (){
                setState(() {
                  if(count > 1)
                    count--;
                });
              },
            ),
          ),
          Container(
              width: 12,
              height: 12,
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 12, color: Colors.black),
              )),
          Container(
            child: IconButton(
              icon: Icon(Icons.add_circle),
              color: Colors.black26,
              onPressed: (){
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
          SizedBox(width: 10,),
          Text('${widget.price}원', style: TextStyle(fontSize: 14,),),
          Expanded(child: SizedBox(width: 1,)),
          countItem,
        ],
      ),
    );

    var totalPriceItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Text('상품 금액', style: TextStyle(fontSize: 14,),),
          Expanded(child: SizedBox(width: 1,)),
          Text('${widget.price*count}원', style: TextStyle(fontSize: 14,),),
        ],
      ),
    );

    var companyMarkItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Text(widget.companyMark, style: TextStyle(fontSize: 14),),
          widget.delivery?Expanded(child: Text(' | 택배로 받기', style: TextStyle(fontSize: 14),)):Container(),
        ],
      ),
    );

    return Container(
      child: Column(
        children: [
          productNameItem,
          priceItem,
          totalPriceItem,
          SizedBox(height: 10,),
          companyMarkItem,
        ],
      ),
    );
  }
}
