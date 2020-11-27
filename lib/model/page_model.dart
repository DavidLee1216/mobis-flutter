import 'dart:developer';

class PageModel {
  List<int> pages;
  int curPage; //is not index, 1, 2, 3,...
  int pageCnt;
  PageModel({this.curPage = 1, this.pages});

  void setCurPage(int page) {
    curPage = page;
    if (pageCnt > 3) {
      if (page < 3) {
        pages.clear();
        pages.addAll([1, 2, 3]);
      } else if (page > pageCnt - 2) {
        pages.clear();
        pages.addAll([pageCnt - 2, pageCnt - 1, pageCnt]);
      } else {
        pages.clear();
        pages.addAll([page - 1, page, page + 1]);
      }
    }
  }

  void init() {
    pages = new List<int>();
    curPage = 1;
  }

  void setPageCnt(int cnt) {
    pageCnt = cnt;
    curPage = 1;
    init();
    if (cnt == 2) {
      pages.addAll([1, 2]);
    } else if (cnt > 2) {
      pages.addAll([1, 2, 3]);
    }
  }
}
