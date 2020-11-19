

class PageModel{
  List<int> pages;
  int curr_page; //is not index, 1, 2, 3,...
  int page_cnt;
  PageModel({this.curr_page=1, this.pages});

  void setCurPage(int page){
    curr_page = page;
    if(page_cnt > 3){
      if(page < 3)
     {
       pages.clear();
       pages.addAll([1, 2, 3]);
     }
      else if(page > page_cnt-2){
        pages.clear();
        pages.addAll([page_cnt-2, page_cnt-1, page_cnt]);
      }
      else {
        pages.clear();
        pages.addAll([page-1, page, page+1]);
      }
    }
  }

  void init(){
    pages = new List<int>();
    curr_page = 1;
  }

  void setPageCnt(int cnt){
    page_cnt = cnt;
    curr_page = 1;
    init();
    if(cnt==2){
      pages.addAll([1, 2]);
    }
    else if(cnt > 2){
      pages.addAll([1, 2, 3]);
    }
  }


}