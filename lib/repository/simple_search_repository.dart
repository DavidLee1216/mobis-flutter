import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/carModel_model.dart';
import 'package:mobispartsearch/model/simple_search_model.dart';

class SimpleSearchRepository {

  Future<List<SimpleSearchResultModel>> searchPartPtno(
      {String hkgb,
      String ptno,
      int firstIndex,
      int recordCountPerPage}) async {
    return await simpleSearchPartByPtno(
        hkgb, ptno, firstIndex, recordCountPerPage);
  }

  Future<List<SimpleSearchResultModel>> searchPartGeneral(
      {String hkgb,
      int catSeq,
      String vtpy,
      String searchWord,
      int firstIndex,
      int recordCountPerPage}) async {
    return await simpleSearchPartByName(
        hkgb, catSeq, vtpy, searchWord, firstIndex, recordCountPerPage);
  }
}
