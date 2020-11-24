import 'dart:convert';
import 'dart:developer';

import 'package:hyundai_mobis/common.dart';
import 'package:http/http.dart' as http;
import 'package:hyundai_mobis/model/notice_model.dart';

class NoticeRepository{

  Future<List<Notice>> getTitleNoticeStream({String title, int page=1, int limit=10}) async {
    return get_title_notice_stream(title: title, page: page, limit: limit);
  }

  Future<List<Notice>> getContentNoticeStream({String keyword, int page=1, int limit=10}) async {
    return get_content_notice_stream(
        keyword: keyword, page: page, limit: limit);
  }
}