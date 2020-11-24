import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/product_model.dart';
import 'package:mobispartsearch/repository/cart_repository.dart';

abstract class CartEvent {}

class InitCartEvent extends CartEvent {}

class AddCartEvent extends CartEvent {
  final Product product;

  AddCartEvent(this.product);
}

class DelCartEvent extends CartEvent {
  final int seq;

  DelCartEvent(this.seq);
}

class DelAllEvent extends CartEvent {}

class LoadCartEvent extends CartEvent {}

class CheckAllEvent extends CartEvent {
  bool checked;

  CheckAllEvent(bool checkAllState) {
    checked = checkAllState;
  }
}

class CartState {
  bool checkAllState;
  List<CartModel> productList;
  CartState({this.productList, this.checkAllState = false});
  factory CartState.init() =>
      CartState(productList: new List<CartModel>(), checkAllState: false);

  CartState _setProps({bool checkAllState, List<CartModel> productList}) =>
      CartState(
        checkAllState: checkAllState ?? false,
        productList: productList ?? new List<CartModel>(),
      );
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;

  CartBloc({CartRepository cartRepository}) : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitCartEvent) yield* mapEventInitToState(event);
    if (event is AddCartEvent) yield* mapEventAddToState(event);
    if (event is DelCartEvent) yield* mapEventDelToState(event);
    if (event is DelAllEvent) yield* mapEventDelAllToState(event);
    if (event is LoadCartEvent) yield* mapEventLoadToState(event);
    if (event is CheckAllEvent) yield* mapEventCheckAllState(event);
  }

  Stream<CartState> mapEventInitToState(InitCartEvent event) async* {
    yield CartState.init();
  }

  Stream<CartState> mapEventAddToState(AddCartEvent event) async* {
    if (await cartRepository.addToCart(event.product)) {
      add(LoadCartEvent());
      yield CartState(productList: state.productList);
    }
  }

  Stream<CartState> mapEventDelToState(DelCartEvent event) async* {
    await cartRepository.delFromCart(event.seq);
    add(LoadCartEvent());
    yield CartState(productList: state.productList);
  }

  Stream<CartState> mapEventDelAllToState(DelAllEvent event) async* {
    for (CartModel item in state.productList) {
      if (item.checked) await cartRepository.delFromCart(item.seq);
    }
    add(LoadCartEvent());
    yield CartState(productList: state.productList);
  }

  Stream<CartState> mapEventLoadToState(LoadCartEvent event) async* {
    state.productList = await cartRepository.loadCart();
    yield CartState(productList: state.productList);
  }

  Stream<CartState> mapEventCheckAllState(CheckAllEvent event) async* {
    for (CartModel item in state.productList) {
      item.checked = event.checked;
    }
    yield state._setProps(checkAllState: event.checked);
  }
}
