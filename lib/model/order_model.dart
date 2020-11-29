import 'package:mobispartsearch/model/product_model.dart';

class Order {
  final String username;
  final String session;
  final String name;
  final String mobile;
  final String zipcode;
  final String addressExtended;
  final String pickupTime;
  final String address;
  final List<Product> products;

  Order({this.username, this.session, this.name, this.mobile, this.zipcode,
      this.addressExtended, this.pickupTime, this.address, this.products});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'session': session,
      'name': name,
      'mobile': mobile,
      'zipcode': zipcode,
      'addressExtended': addressExtended,
      'pickupTime': pickupTime,
      'address': address,
      'products': products.map((e) => e.toMap()),
    };
  }
}
