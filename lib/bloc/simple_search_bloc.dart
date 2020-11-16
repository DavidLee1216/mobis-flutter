import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/model/simple_search_model.dart';
import 'package:hyundai_mobis/common.dart';
import 'package:hyundai_mobis/repository/simple_search_repository.dart';

const List<String> hkgb_list = ['H', 'K'];
const List<String> vtpy_list = ['P', 'R', 'C'];


abstract class SimpleSearchEvent{}

class InitSimpleSearchEvent extends SimpleSearchEvent{
}

class HKGBSimpleSearchEvent extends SimpleSearchEvent{
  final int idx;

  HKGBSimpleSearchEvent(this.idx);
}

class VTPYSimpleSearchEvent extends SimpleSearchEvent{
  final int idx;

  VTPYSimpleSearchEvent(this.idx);
}

class ModelSimpleSearchEvent extends SimpleSearchEvent{
  final String model;

  ModelSimpleSearchEvent(this.model);
}

class SearchSimpleSearchEvent extends SimpleSearchEvent{
  final searchWord;

  SearchSimpleSearchEvent(this.searchWord);
}

class SimpleSearchState{
  String hkgb;
  String vtpy;
  String model;
  String keyword;
  List<String> carModels;
  List<SimpleSearchResultModel> searchResult;
  bool isLoading;

  SimpleSearchState({this.hkgb='H', this.vtpy='P', this.model='', this.keyword='', this.carModels, this.searchResult, this.isLoading=false});


  factory SimpleSearchState.init()=>SimpleSearchState();

  SimpleSearchState _setProps({String hkgb,  String vtpy, String model, String keyword, List<String> carModels, List<SimpleSearchResultModel> searchResult, bool isLoading})=>
      SimpleSearchState(
          hkgb: hkgb??this.hkgb,
          vtpy: vtpy??this.vtpy,
          model: model??this.model,
          keyword: keyword??this.keyword,
          carModels:carModels??this.carModels??new List<String>(),
          searchResult:searchResult?? this.searchResult??new List<SimpleSearchResultModel>(),
          isLoading: isLoading??this.isLoading);

  SimpleSearchState submitting() => _setProps(isLoading: true);
  SimpleSearchState success({String hkgb, String vtpy, String model, String keyword, List<String> carModels, List<SimpleSearchResultModel> searchResult, bool isLoading}) =>
      _setProps(hkgb: hkgb, vtpy: vtpy, model: model, carModels: carModels, searchResult: searchResult, isLoading: false);
}

class SimpleSearchBloc extends Bloc<SimpleSearchEvent, SimpleSearchState> {
  SimpleSearchRepository simpleSearchRepository;
  SimpleSearchBloc({this.simpleSearchRepository}) : super(SimpleSearchState());

  @override
  Stream<SimpleSearchState> mapEventToState(SimpleSearchEvent event) async* {
    if(event is InitSimpleSearchEvent)
      yield* _mapInitEventToState();
    if(event is HKGBSimpleSearchEvent)
      yield* _mapHKGBEventToState(event.idx);
    if(event is VTPYSimpleSearchEvent)
      yield* _mapVTPYEventToState(event.idx);
    if(event is ModelSimpleSearchEvent)
      yield* _mapModelSelectEventToState(event.model);
    if(event is SearchSimpleSearchEvent)
      yield* _mapSearchEventToState(event.searchWord);
  }

  Stream<SimpleSearchState> _mapInitEventToState() async* {
    try{
      yield state.submitting();
      List<String> carModels = await simpleSearchRepository.getModels(hkgb:'H', vtpy:'P');
      List<SimpleSearchResultModel> searchResult = new List<SimpleSearchResultModel>();
      yield state.success(model: carModels[0], carModels: carModels, searchResult: searchResult);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapHKGBEventToState(int idx) async* {
    try{
      yield state.submitting();
      log('hkgb');
      List<String> carModels = await simpleSearchRepository.getModels(hkgb:hkgb_list[idx], vtpy:state.vtpy);
      yield state.success(hkgb: hkgb_list[idx], carModels: carModels);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapVTPYEventToState(int idx) async* {
    try{
      yield state.submitting();
      List<String> carModels = await simpleSearchRepository.getModels(hkgb:state.hkgb, vtpy:vtpy_list[idx]);
      yield state.success(vtpy: vtpy_list[idx], carModels: carModels);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapModelSelectEventToState(String model) async* {
    try{
      yield state.submitting();
      yield state.success(model: model);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapSearchEventToState(String keyword) async* {
    try{
      yield state.submitting();
      List<SimpleSearchResultModel> searchResult = await simpleSearchRepository.searchPart(hkgb: state.hkgb, vtpy: state.vtpy, catSeq: state.model, searchWord: state.keyword, firstIndex: 0, recordCountPerPage: globalRecordCountPerPage);
      yield state.success(searchResult: searchResult);
    } catch(e){
      yield state.success();
    }
  }

}