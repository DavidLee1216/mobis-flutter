
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