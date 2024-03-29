import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/common.dart';

class MarketSearchRepository {
  Future<List<MarketSearchResultModel>> searchPart(
      {String hkgb,
      String ptno,
      String sido,
      String sigungu,
      String stype,
      int firstIndex,
      int recordCountPerPage}) async {
    return await marketSearchPart(
        hkgb, ptno, sido, sigungu, stype, firstIndex, recordCountPerPage);
  }

  Future<MarketSearchResultProductInfo> getProductInfo({String ptno}) async {
    return await getProductInfoFromPtno(ptno);
  }
}
