import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/model/product_model.dart';

abstract class CartEvent{}

class AddCartEvent extends CartEvent{
  final Product product;

  AddCartEvent(this.product);

}

class DelCartEvent extends CartEvent{
  final int seq;

  DelCartEvent(this.seq);
}

class LoadCartEvent extends CartEvent{}

class CartState{
  List<Product> productList;
  CartState(){}
  factory CartState.init()=>CartState();
}

class CartBloc extends Bloc<CartEvent, CartState>{

  CartBloc():super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event){
    if(event is AddCartEvent)
      return mapEventAddToState(event);
    if(event is DelCartEvent)
      return mapEventDelToState(event);
    if(event is LoadCartEvent)
      return mapEventLoadToState(event);
  }

  Stream<CartState> mapEventAddToState(AddCartEvent event) {}

  Stream<CartState> mapEventDelToState(DelCartEvent event) {}

  Stream<CartState> mapEventLoadToState(LoadCartEvent event) {}
}