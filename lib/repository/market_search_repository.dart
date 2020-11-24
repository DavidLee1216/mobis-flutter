import 'dart:developer';

import 'package:mobispartsearch/model/market_search_model.dart';

import 'package:mobispartsearch/common.dart';

class MarketSearchRepository{

  Future<List<MarketSearchResultModel>> searchPart({String hkgb, String ptno, String sido, String sigungu, String stype, int firstIndex, int recordCountPerPage}) async {
    return await market_search_part(
        hkgb, ptno, sido, sigungu, stype, firstIndex, recordCountPerPage);
  }

  Future<MarketSearchResultProductInfo> getProductInfo({String ptno}) async {
    return await get_product_info_from_ptno(ptno);
  }
}