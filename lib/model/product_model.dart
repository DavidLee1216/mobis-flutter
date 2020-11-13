
class Product{
  final String agentCode;
  final String deliveryCode;
  final String partNumber;
  final String username;
  final int count;

  Product(this.agentCode, this.deliveryCode, this.partNumber, this.username, this.count);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'agentCode': agentCode,
      'deliveryCode': deliveryCode,
      'ptno': partNumber,
      'qty': count,
    };
  }
}