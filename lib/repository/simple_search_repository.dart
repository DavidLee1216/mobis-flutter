

import 'dart:developer';

import 'package:hyundai_mobis/model/simple_search_model.dart';

import 'package:hyundai_mobis/common.dart';

class SimpleSearchRepository{

  Future<List<String>> getModels({String hkgb, String vtpy}) async {
    log('model');
    return await get_models(hkgb, vtpy);
  }

  Future<List<SimpleSearchResultModel>> searchPart({String hkgb, String catSeq, String vtpy, String searchWord, int firstIndex, int recordCountPerPage}) async {
    return await simple_search_part(
        hkgb, '아토스 98', vtpy, searchWord, firstIndex, recordCountPerPage);
  }
}