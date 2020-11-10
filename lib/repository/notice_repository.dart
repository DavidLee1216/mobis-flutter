import 'dart:convert';

import 'package:hyundai_mobis/common.dart';
import 'package:http/http.dart' as http;

class Notice {

  String title;
  String content;
  String seq;
  DateTime date;

  Notice({this.title, this.content, this.seq, this.date});
}

class NoticeRepository{

  Future<List<Notice>> getTitleNoticeStream(String title) async {
    final response = await http.get(API+'/notice?search=$title&page=3&limit=10');
    if(response.statusCode==200){
      final data = json.decode(response.body) as List;
      return data.map((e) {
        return Notice(
          title: e['title'],
          content: e['content'],
          seq: e['seq'],
          date: e['createdDate'],
        );
      });
    }
  }

  Future<List<Notice>> getContentNoticeStream(String keyword) async {
    final response = await http.get(API+'/notice?search=$keyword&page=3&limit=10');
    if(response.statusCode==200){
      final data = json.decode(response.body) as List;
      return data.map((e) {
        return Notice(
          title: e['title'],
          content: e['content'],
          seq: e['seq'],
          date: e['createdDate'],
        );
      });
    }
  }
}