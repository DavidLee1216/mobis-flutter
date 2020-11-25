import 'package:mobispartsearch/common.dart' as common;
import 'package:mobispartsearch/model/notice_model.dart';

class NoticeRepository{

  Future<List<Notice>> getTitleNoticeStream({String title, int page=1, int limit=10}) async {
    return common.getTitleNoticeStream(title: title, page: page, limit: limit);
  }

  Future<List<Notice>> getContentNoticeStream({String keyword, int page=1, int limit=10}) async {
    return common.getContentNoticeStream(
        keyword: keyword, page: page, limit: limit);
  }
}
