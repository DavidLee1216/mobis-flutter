

import 'package:hyundai_mobis/model/cart_model.dart';
import 'package:hyundai_mobis/model/product_model.dart';
import 'package:hyundai_mobis/common.dart';

class CartRepository{
  Future<bool> addToCart(Product product) async{
    if(await add_to_cart(product)==true)
    {
      return true;
    }
    else
      return false;
  }

  Future<List<CartModel>> loadCart() async{
    return await load_cart();
  }

  Future<bool> delFromCart(int seq) async{
    return await del_from_cart(seq);
  }
}