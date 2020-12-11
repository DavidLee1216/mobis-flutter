
import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/product_model.dart';
import 'package:mobispartsearch/common.dart' as common;

class CartRepository {
  Future<bool> addToCart(Product product) async {
    if (await common.addToCart(product) == true) {
      return true;
    } else
      return false;
  }

  Future<List<CartModel>> loadCart() async {
    return await common.loadCart();
  }

  Future<bool> delFromCart(int seq) async {
    return await common.delFromCart(seq);
  }

  Future<bool> delAllFromCart(List<Map<String, dynamic>> seqs) async{
    return await common.delAllFromCart(seqs);
  }
}
