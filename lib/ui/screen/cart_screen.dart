import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/widget/cart_product_form.dart';

class CartScreenArguments {
  final bool delivery_kind; //true: 택배, false:방문

  CartScreenArguments(this.delivery_kind);
}

class CartScreen extends StatelessWidget {
  static const routeName = '/addToCart';

  @override
  Widget build(BuildContext context) {
    final CartScreenArguments args = ModalRoute.of(context).settings.arguments;
    return AddToCartScreen(deliver_kind: args.delivery_kind,);
  }
}

class AddToCartScreen extends StatefulWidget {

  final bool deliver_kind;

  const AddToCartScreen({Key key, this.deliver_kind}) : super(key: key);

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  var checkAllState = false;
  @override
  Widget build(BuildContext context) {
    var selectAllItem = Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      checkAllState = value;
                    });
                  },
                  tristate: false,
                  value: checkAllState,
                  activeColor: Color.fromRGBO(0, 63, 114, 1),
                ),
                Text(
                  '전체 선택',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ]
            )
          ),
          Expanded(child: SizedBox(width: 10,)),
          Container(
            height: 30,
            padding: EdgeInsets.only(right: 20),
            child: OutlineButton(
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 63, 114, 1), //Color of the border
                style: BorderStyle.solid, //Style of the border
                width: 1, //width of the border
              ),
              child: Row(
                children: [
                  Icon(Icons.clear, color: Color.fromRGBO(0, 63, 114, 1),),
                  Text('선택 상품 삭제', style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 63, 114, 1)),),
                ],
              ),
              onPressed: (){

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
            Text('총 주문 금액', style: TextStyle(fontSize: 16),),
            Expanded(child: SizedBox(width: 10,),),
            Text('$price', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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
            buttonColor: Color.fromRGBO(0, 63, 114, 1),
            child: RaisedButton(
              child: Text('구매요청', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center,),
              onPressed: (){
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
                child: Text('부품 구매는 방문 수령/택배를 이용할 수 있으며,\n 택배 수령시 택배비가 추가로 청구될 수 있으니\n판매점에 문의바랍니다.',
                  style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.center,),
              ),
              Divider(color: Colors.black54,),
              selectAllItem,
              Divider(color: Colors.black54,),
              CartProductForm(productName:'플레이트 & 그로메트－에어컨 쿨러 라인', price: 1870, companyMark:'강원부품(주)', delivery: widget.deliver_kind, checked: checkAllState,),
              Divider(color: Colors.black54,),
              CartProductForm(productName:'필터 앗세이－오일', price: 101640, companyMark:'강원부품(주)', delivery: widget.deliver_kind, checked: checkAllState,),
              Divider(color: Colors.black54,),
              selectAllItem,
              Divider(color: Colors.black54,),
              totalPrice(5610),
              SizedBox(height: 30,),
              buyItem,
              SizedBox(height: 30,),
            ],
          ), //
        ),

      );
    }

}
