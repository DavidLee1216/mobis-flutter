import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/product_model.dart';

class CartRepository {
  Future<bool> addToCart(Product product) async {
    if (await addToCart(product) == true) {
      return true;
    } else
      return false;
  }

  Future<List<CartModel>> loadCart() async {
    return await loadCart();
  }

  Future<bool> delFromCart(int seq) async {
    return await delFromCart(seq);
  }
}
