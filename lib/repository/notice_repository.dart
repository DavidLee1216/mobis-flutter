import 'dart:convert';
import 'dart:developer';

import 'package:mobispartsearch/common.dart';
import 'package:http/http.dart' as http;
import 'package:mobispartsearch/model/notice_model.dart';

class NoticeRepository {
  Future<List<Notice>> getTitleNoticeStream(
      {String title, int page = 1, int limit = 10}) async {
    log('page=$page&limit=$limit');
    final response = await http
        .get(API + '/notice?kind=title&limit=$limit&page=$page&search=$title');
    if (response.statusCode == 200) {
      log('notice success');
      log(response.body);
      final data = json.decode(response.body) as List;
      return data.map((e) {
        return Notice(
          title: e['title'],
          content: e['content'],
          seq: e['seq'],
          date: e['createdDate'],
        );
      });
    } else {
      log('notice' + response.statusCode.toString());
      return null;
    }
  }

  Future<List<Notice>> getContentNoticeStream(
      {String keyword, int page = 1, int limit = 10}) async {
    final response = await http.get(
        API + '/notice?kind=content&limit=$limit&page=$page&search=$keyword');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) {
        return Notice(
          title: e['title'],
          content: e['content'],
          seq: e['seq'],
          date: e['createdDate'],
        );
      });
    } else {
      throw Exception('error');
    }
  }
}
