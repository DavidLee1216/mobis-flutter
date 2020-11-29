import 'dart:developer';

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

class CheckEvent extends CartEvent {
  int seq;
  bool checked;

  CheckEvent(int seq, bool checkState){
    this.seq = seq;
    this.checked = checkState;
  }
}

class ChangeCountEvent extends CartEvent {
  int seq;
  int count;

  ChangeCountEvent(int seq, int count){
    this.seq = seq;
    this.count = count;
  }
}

class CartState {
  bool checkAllState;
  List<CartModel> productList;
  int totalPrice;
  String errorMsg;
  bool isLoading;
  bool isAdded;

  CartState({
    this.productList,
    this.checkAllState = false,
    this.errorMsg = '',
    this.isLoading = false,
    this.isAdded = false,
    this.totalPrice = 0,
  });

  factory CartState.init() =>
      CartState(productList: new List<CartModel>(), checkAllState: false, errorMsg: '', isLoading: false, isAdded: false, totalPrice: 0);

  CartState submitting() => _setProps(isLoading: true);

  CartState _setProps(
          {bool checkAllState, List<CartModel> productList, String errorMsg, bool isLoading, bool isAdded}) =>
      CartState(
        checkAllState: checkAllState ?? false,
        productList: productList ?? this.productList,
        errorMsg: errorMsg ?? this.errorMsg,
        isLoading: isLoading ?? this.isLoading,
        isAdded: isAdded ?? false,
      )..totalPrice = getTotalPrice();

  CartState _setListProps({int seq, bool checkState, int count}) {
    for(int i = 0; i < productList.length; i++) {
      if(productList[i].seq == seq){
        productList[i].checked = checkState ?? productList[i].checked;
        productList[i].count = count ?? productList[i].count;
      }
    }
    return _setProps(productList: productList);
  }

  CartState removeProductItem(int seq) {
    int idx = -1;
    for(int i = 0; i < productList.length; i++) {
      if(productList[i].seq == seq){
        idx = i;
      }
    }
    if(idx > -1)
      productList.removeAt(idx);
    return _setProps(productList: productList, isLoading: false);
  }

  int getTotalPrice() {
    int val = 0;
    for(int i = 0; i < productList.length; i++) {
      val += productList[i].price*productList[i].count;
    }
    return val;
  }

  CartState success(
          {bool checkAllState, List<CartModel> productList, bool isAdded, int totalPrice}) =>
      _setProps(
        checkAllState: checkAllState,
        productList: productList,
        errorMsg: '',
        isLoading: false,
        isAdded: isAdded,
      );

  CartState unprocessed(String errorMsg) =>
      CartState.init()..errorMsg = errorMsg;

}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;

  CartBloc({this.cartRepository}) : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitCartEvent) yield* mapEventInitToState(event);
    if (event is AddCartEvent) yield* mapEventAddToState(event);
    if (event is DelCartEvent) yield* mapEventDelToState(event);
    if (event is DelAllEvent) yield* mapEventDelAllToState(event);
    if (event is LoadCartEvent) yield* mapEventLoadToState(event);
    if (event is CheckAllEvent) yield* mapEventCheckAllState(event);
    if (event is CheckEvent) yield* mapEventCheckState(event);
    if (event is ChangeCountEvent) yield* mapEventChangeCountState(event);
  }

  Stream<CartState> mapEventInitToState(InitCartEvent event) async* {
    yield CartState.init();
  }

  Stream<CartState> mapEventAddToState(AddCartEvent event) async* {
    yield state.submitting();
    if (await cartRepository.addToCart(event.product)) {
      yield state.success(isAdded: true);
    } else {
      yield state.unprocessed('장바구니 담기 실패');
    }
  }

  Stream<CartState> mapEventDelToState(DelCartEvent event) async* {
    yield state.submitting();
    if( await cartRepository.delFromCart(event.seq)) {
      yield state.removeProductItem(event.seq);
    } else {
      yield state.unprocessed('삭제 실패');
    }
  }

  Stream<CartState> mapEventDelAllToState(DelAllEvent event) async* {
//    yield state.submitting();
//    for (CartModel item in state.productList) {
//      if (item.checked) await cartRepository.delFromCart(item.seq);
//    }
//    List<CartModel> productList = await cartRepository.loadCart();
//    yield CartState(productList: productList);
  }

  Stream<CartState> mapEventLoadToState(LoadCartEvent event) async* {
    yield state.submitting();
    try{
      List<CartModel> productList = await cartRepository.loadCart();
      if(productList != null)
      {
        yield state.success(productList: productList,);
        yield state._setListProps();
        yield state.success();
      }
      else
        yield state.success();
    } catch (e) {
      log(e.toString());
      yield state.unprocessed('접속 실패');
    }
  }

  Stream<CartState> mapEventCheckAllState(CheckAllEvent event) async* {
    yield state._setProps(checkAllState: event.checked);
  }

  Stream<CartState> mapEventCheckState(CheckEvent event) async* {
    yield state._setListProps(seq: event.seq, checkState: event.checked);
  }

  Stream<CartState> mapEventChangeCountState(ChangeCountEvent event) async* {
    yield state._setListProps(seq: event.seq, count: event.count);
  }
}
