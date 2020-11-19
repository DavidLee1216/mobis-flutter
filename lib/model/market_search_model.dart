
class MarketSearchResultModel {

  String ptno;
  String mutual;
  String adr;
  String sigungu;
  String url;
  int totalCnt;
  String zipcd;
  String sido;
  String tel;
  String hkgb;
  int stype;
  String adr_dtl;
  int rnum;

  MarketSearchResultModel({this.ptno, this.mutual, this.adr, this.sigungu, this.url, this.totalCnt, this.zipcd, this.sido, this.tel, this.hkgb, this.stype, this.adr_dtl, this.rnum});

  factory MarketSearchResultModel.fromMap(Map<String, dynamic> map) => MarketSearchResultModel(
    ptno: map['ptno'],
    mutual: map['mutual'],
    adr: map['adr'],
    sigungu: map['sigungu'],
    url: map['url'],
    totalCnt: map['tot_cnt'],
    zipcd: map['zipcd'],
    sido: map['sido'],
    tel: map['tel'],
    hkgb: map['hkgb'],
    stype: map['stype'],
    adr_dtl: map['adr_dtl'],
    rnum: map['rnum'],
  );
}

class MarketSearchResultProductInfo{
  int seq;
  String hkgb;
  String ptno;
  String kr_name;
  String en_name;
  int price;

  MarketSearchResultProductInfo({this.seq, this.hkgb, this.ptno, this.kr_name, this.en_name, this.price});

  factory MarketSearchResultProductInfo.fromMap(Map<String, dynamic> map) => MarketSearchResultProductInfo(
    seq: map['seq'],
    hkgb: map['hkgb'],
    ptno: map['ptno'],
    kr_name: map['krnm'],
    en_name: map['ennm'],
    price: map['price'],
  );
}