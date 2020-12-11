

class CartModel{
  final String mutual;
  final String agentCode;
  final String sapCode;
  final String deliveryCode;
  final String partNumber;
  final String krname;
  final String enname;
  final int seq;
  final int price;
  int count;
  bool checked;

  CartModel({this.mutual, this.deliveryCode, this.seq, this.price, this.krname, this.partNumber, this.enname, this.count, this.agentCode, this.sapCode, this.checked=false,});

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
    mutual: map['mutual'],
    deliveryCode: map['delivery_cd'],
    seq: map['seq'],
    price: map['price'],
    krname: map['kr_nm'],
    partNumber: map['ptno'],
    enname: map['en_nm'],
    count: map['qty'],
    agentCode: map['agent_cd'],
    sapCode: map['sap_code'],
  );
}

class DelCartModel{
  int seq;

  DelCartModel({this.seq});

  Map<String, dynamic> toMap() {
    return {
      'seq': seq,
    };
  }
}