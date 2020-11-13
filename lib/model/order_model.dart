
import 'package:hyundai_mobis/model/product_model.dart';

class Order{
  final String username;
  final String name;
  final String mobile;
  final String zipcode;
  final String addressExtended;
  final String pickupTime;
  final String address;
  final Product product;

  Order(this.username, this.name, this.mobile, this.zipcode, this.addressExtended, this.pickupTime, this.address, this.product);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'mobile': mobile,
      'zipcode': zipcode,
      'addressExtended': addressExtended,
      'address': address,
      'products': [product.toMap()],
    };
  }
}