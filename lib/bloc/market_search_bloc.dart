import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/app_config.dart';
import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/model/page_model.dart';
import 'package:mobispartsearch/repository/market_search_repository.dart';

const List<String> hkgb_list = ['H', 'K'];
const List<String> market_list = ['ALL', 'DICT', 'N', 'Y'];

abstract class MarketSearchEvent {}

class InitMarketSearchEvent extends MarketSearchEvent {}

class HKGBMarketSearchEvent extends MarketSearchEvent {
  final int idx;

  HKGBMarketSearchEvent(this.idx);
}

class SetPtnoMarketSearchEvent extends MarketSearchEvent {
  final String ptno;

  SetPtnoMarketSearchEvent(this.ptno);
}

class SetMarketMarketSearchEvent extends MarketSearchEvent {
  final int idx;

  SetMarketMarketSearchEvent(this.idx);
}

class SearchMarketSearchEvent extends MarketSearchEvent {
  final sido;
  final sigungu;
  final ptno;
  SearchMarketSearchEvent(this.ptno, this.sido, this.sigungu);
}

class SearchMarketSearchMoreEvent extends MarketSearchEvent {
}

class MarketSearchState {
  String hkgb;
  String sido;
  String sigungu;
  String market;
  String ptno;
  String enname;
  String krname;
  int price;
  List<MarketSearchResultModel> searchResult;
  int page;
  bool nomore;
  bool isLoading;

  MarketSearchState(
      {this.hkgb = 'H',
      this.sido = '',
      this.sigungu = '',
      this.market = 'ALL',
      this.ptno,
      this.searchResult,
      this.krname = '',
      this.enname = '',
      this.price = 0,
      this.isLoading = false,
      this.nomore = false,
      this.page = 0});

  factory MarketSearchState.init() => MarketSearchState();

  MarketSearchState _setProps(
          {String hkgb,
          String sido,
          String sigungu,
          String market,
          String ptno,
          List<MarketSearchResultModel> searchResult,
          String krname,
          String enname,
          int price,
          bool isLoading,
          bool nomore,
          int page}) =>
      MarketSearchState(
        hkgb: hkgb ?? this.hkgb,
        sido: sido ?? this.sido,
        sigungu: sigungu ?? this.sigungu,
        market: market ?? this.market,
        ptno: ptno ?? this.ptno,
        searchResult: searchResult ?? this.searchResult,
        krname: krname ?? this.krname ?? '',
        enname: enname ?? this.enname ?? '',
        price: price ?? this.price ?? 0,
        isLoading: isLoading ?? this.isLoading,
        nomore: nomore ?? false,
        page: page ?? this.page,
      );

  MarketSearchState submitting() => _setProps(isLoading: true);
  MarketSearchState success(
          {String hkgb,
          String sido,
          String sigungu,
          String market,
          String ptno,
          List<MarketSearchResultModel> searchResult,
          String krname,
          String enname,
          int price,
          bool isLoading,
          bool nomore,
          int page}) =>
      _setProps(
          hkgb: hkgb,
          sido: sido,
          sigungu: sigungu,
          market: market,
          ptno: ptno,
          searchResult: searchResult,
          krname: krname,
          enname: enname,
          price: price,
          isLoading: false,
          nomore: nomore,
          page: page);
}

class MarketSearchBloc extends Bloc<MarketSearchEvent, MarketSearchState> {
  MarketSearchRepository marketSearchRepository;
  MarketSearchBloc({this.marketSearchRepository}) : super(MarketSearchState());

  @override
  Stream<MarketSearchState> mapEventToState(MarketSearchEvent event) async* {
    if (event is InitMarketSearchEvent) yield* _mapInitEventToState();
    if (event is HKGBMarketSearchEvent) yield* _mapHKGBEventToState(event.idx);
    if (event is SetPtnoMarketSearchEvent)
      yield* _mapSetPtnoEventToState(event.ptno);
    if (event is SetMarketMarketSearchEvent)
      yield* _mapSetMarketEventToState(event.idx);
    if (event is SearchMarketSearchEvent)
      yield* _mapSearchEventToState(
          event.ptno, event.sido, event.sigungu);
    if (event is SearchMarketSearchMoreEvent)
      yield* _mapSearchMoreEventToState();
  }

  Stream<MarketSearchState> _mapInitEventToState() async* {
    try {
      yield state.submitting();
      List<MarketSearchResultModel> searchResult =
          new List<MarketSearchResultModel>();
      yield state.success(searchResult: searchResult, hkgb: 'H', ptno: '', market: 'ALL', sido: '', sigungu: '', page: 1);
    } catch (e) {
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapHKGBEventToState(int idx) async* {
    try {
      yield state.submitting();
      yield state.success(
        hkgb: hkgb_list[idx],
      );
    } catch (e) {
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapSetPtnoEventToState(String ptno) async* {
    try {
      yield state.submitting();
      yield state.success(
        ptno: ptno,
      );
    } catch (e) {
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapSetMarketEventToState(int idx) async* {
    try {
      yield state.submitting();
      yield state.success(
        market: market_list[idx],
      );
    } catch (e) {
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapSearchEventToState(
      String ptno, String sido, String sigungu) async* {
    try {
      yield state.submitting();
      MarketSearchResultProductInfo productInfo =
      await marketSearchRepository.getProductInfo(ptno: ptno);
      if (productInfo == null) {
        yield state.success(ptno: ptno);
        return;
      }
      List<MarketSearchResultModel> searchResult =
          await marketSearchRepository.searchPart(
              hkgb: state.hkgb,
              ptno: ptno,
              sido: sido,
              sigungu: sigungu,
              stype: state.market,
              firstIndex: 0,
              recordCountPerPage: globalRecordCountPerPage);
      if (searchResult == null || searchResult.length == 0)
      {
        yield state.success(ptno: ptno, searchResult: state.searchResult, nomore: true);
      }
      else{
        bool nomore = false;
        if(searchResult.length < globalRecordCountPerPage)
          nomore = true;
        yield state.success(
            searchResult: searchResult,
            krname: productInfo.krname,
            enname: productInfo.enname,
            price: productInfo.price,
            sido: sido,
            sigungu: sigungu,
            ptno: ptno,
            nomore: nomore,
            page: 1,
            );
      }

    } catch (e) {
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapSearchMoreEventToState() async* {
    try {
      yield state.submitting();
      List<MarketSearchResultModel> searchResult =
        await marketSearchRepository.searchPart(
            hkgb: state.hkgb,
            ptno: state.ptno,
            sido: state.sido,
            sigungu: state.sigungu,
            stype: state.market,
            firstIndex: state.page * globalRecordCountPerPage,
            recordCountPerPage: globalRecordCountPerPage);
      if (searchResult == null || searchResult.length == 0)
      {
        yield state.success(searchResult: state.searchResult, nomore: true);
      }
      else{
        state.searchResult.addAll(searchResult);
        yield state.success(
          searchResult: state.searchResult,
          nomore: false,
          page: state.page + 1,
        );
      }

    } catch (e) {
      yield state.success();
    }
  }

}
