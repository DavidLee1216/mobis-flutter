import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/simple_search_model.dart';

class SimpleSearchRepository {
  Future<List<String>> getModels({String hkgb, String vtpy}) async {
    return await getModelsFromRemote(hkgb, vtpy);
  }

  Future<List<SimpleSearchResultModel>> searchPartPtno(
      {String hkgb,
      String ptno,
      int firstIndex,
      int recordCountPerPage}) async {
    return await simpleSearchPartPtno(
        hkgb, ptno, firstIndex, recordCountPerPage);
  }

  Future<List<SimpleSearchResultModel>> searchPartGeneral(
      {String hkgb,
      String catSeq,
      String vtpy,
      String searchWord,
      int firstIndex,
      int recordCountPerPage}) async {
    return await simpleSearchPart(
        hkgb, catSeq, vtpy, searchWord, firstIndex, recordCountPerPage);
  }
}
