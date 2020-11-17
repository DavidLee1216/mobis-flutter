

class CartModel{
  final String mutual;
  final String agentCode;
  final String deliveryCode;
  final String partNumber;
  final String krname;
  final String enname;
  final int seq;
  final int price;
  final int count;
  bool checked;

  CartModel({this.mutual, this.deliveryCode, this.seq, this.price, this.krname, this.partNumber, this.enname, this.count, this.agentCode, this.checked=false,});

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
    mutual: map['mutual'],
    deliveryCode: map['deliveryCode'],
    seq: map['seq'],
    price: map['price'],
    krname: map['krname'],
    partNumber: map['ptno'],
    enname: map['enname'],
    count: map['qty'],
    agentCode: map['agentCode'],
  );

}