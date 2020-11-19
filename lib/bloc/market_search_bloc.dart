import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/common.dart';
import 'package:hyundai_mobis/model/market_search_model.dart';
import 'package:hyundai_mobis/model/page_model.dart';
import 'package:hyundai_mobis/repository/market_search_repository.dart';

const List<String> hkgb_list = ['H', 'K'];
const List<String> market_list = ['All', 'DICT', 'N', 'Y'];


abstract class MarketSearchEvent{}

class InitMarketSearchEvent extends MarketSearchEvent{
}

class HKGBMarketSearchEvent extends MarketSearchEvent{
  final int idx;

  HKGBMarketSearchEvent(this.idx);
}

class SetMarketMarketSearchEvent extends MarketSearchEvent{
  final int idx;

  SetMarketMarketSearchEvent(this.idx);
}

class SearchMarketSearchEvent extends MarketSearchEvent{
  final sido;
  final sigungu;
  final ptno;
  int page;

  SearchMarketSearchEvent(this.ptno, this.sido, this.sigungu, this.page);
}

class MarketSearchState{
  String hkgb;
  String sido;
  String sigungu;
  String market;
  String ptno;
  String en_name;
  String kr_name;
  int price;
  List<MarketSearchResultModel> searchResult;
  PageModel pageModel;
  bool isLoading;

  MarketSearchState({this.hkgb='H', this.sido='', this.sigungu='', this.market='', this.ptno, this.searchResult, this.kr_name, this.en_name, this.price, this.isLoading=false, this.pageModel});


  factory MarketSearchState.init()=>MarketSearchState();

  MarketSearchState _setProps({String hkgb,  String sido, String sigungu, String market, String ptno, List<MarketSearchResultModel> searchResult, String kr_name, String en_name, int price, bool isLoading, PageModel pageModel})=>
      MarketSearchState(
          hkgb: hkgb??this.hkgb,
          sido: sido??this.sido,
          sigungu: sigungu??this.sigungu,
          market: market??this.market,
          ptno:ptno??this.ptno,
          searchResult:searchResult?? this.searchResult??new List<MarketSearchResultModel>(),
          kr_name: kr_name??this.kr_name,
          en_name: en_name??this.en_name,
          price: price??this.price,
          isLoading: isLoading??this.isLoading,
          pageModel: pageModel??this.pageModel??new PageModel()..init(),
  );

  MarketSearchState submitting() => _setProps(isLoading: true);
  MarketSearchState success({String hkgb, String sido, String sigungu, String market, String ptno, List<MarketSearchResultModel> searchResult, String kr_name, String en_name, int price, bool isLoading, PageModel pageModel}) =>
      _setProps(hkgb: hkgb, sido: sido, sigungu: sigungu, market: market, ptno: ptno, searchResult: searchResult, kr_name: kr_name, en_name: en_name, price: price, isLoading: false, pageModel: pageModel);
}

class MarketSearchBloc extends Bloc<MarketSearchEvent, MarketSearchState> {
  MarketSearchRepository marketSearchRepository;
  MarketSearchBloc({this.marketSearchRepository}) : super(MarketSearchState());

  @override
  Stream<MarketSearchState> mapEventToState(MarketSearchEvent event) async* {
    if(event is InitMarketSearchEvent)
      yield* _mapInitEventToState();
    if(event is HKGBMarketSearchEvent)
      yield* _mapHKGBEventToState(event.idx);
    if(event is SetMarketMarketSearchEvent)
      yield* _mapSetMarketEventToState(event.idx);
    if(event is SearchMarketSearchEvent)
      yield* _mapSearchEventToState(event.ptno, event.sido, event.sigungu, event.page);
  }

  Stream<MarketSearchState> _mapInitEventToState() async* {
    try{
      yield state.submitting();
      List<MarketSearchResultModel> searchResult = new List<MarketSearchResultModel>();
      yield state.success(searchResult: searchResult);
    } catch(e){
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapHKGBEventToState(int idx) async* {
    try{
      yield state.submitting();
      yield state.success(hkgb: hkgb_list[idx], );
    } catch(e){
      yield state.success();
    }
  }

  Stream<MarketSearchState> _mapSetMarketEventToState(int idx) async* {
    try{
      yield state.submitting();
      yield state.success(market: market_list[idx], );
    } catch(e){
      yield state.success();
    }
  }


  Stream<MarketSearchState> _mapSearchEventToState(String ptno, String sido, String sigungu, int page) async* {
    try{
      yield state.submitting();
      MarketSearchResultProductInfo productInfo = await marketSearchRepository.getProductInfo(ptno: state.ptno);
      if(productInfo==null) {
        yield state.success();
        return;
      }
      List<MarketSearchResultModel> searchResult = await marketSearchRepository.searchPart(hkgb: state.hkgb, ptno:state.ptno, sido:state.sido, sigungu:state.sigungu, stype: state.market, firstIndex:1 + (page-1)*globalRecordCountPerPage, recordCountPerPage: globalRecordCountPerPage);
      if(searchResult==null||searchResult.length==0)
        yield state.success();
      else{
        PageModel pageModel = new PageModel()..init();
        pageModel.setPageCnt(searchResult[0].totalCnt~/globalRecordCountPerPage + 1);
        pageModel.setCurPage(page);

        yield state.success(searchResult: searchResult, kr_name: productInfo.kr_name, en_name: productInfo.en_name, price: productInfo.price, pageModel: pageModel);

      }
    } catch(e){
      yield state.success();
    }
  }

}
