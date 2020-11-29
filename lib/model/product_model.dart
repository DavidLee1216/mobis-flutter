
class Product{
  final String agentCode;
  final String sapCode;
  final String deliveryCode;
  final String partNumber;
  final String username;
  final String session;
  final int count;

  Product({this.agentCode, this.sapCode, this.deliveryCode, this.partNumber, this.username, this.session, this.count});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'session': session,
      'agentCode': agentCode,
      'sapCode' : sapCode,
      'deliveryCode': deliveryCode,
      'ptno': partNumber,
      'qty': count,
    };
  }
}