
class SimpleSearchResultModel {

  String ptno;
  String kr_name;
  String en_name;
  int price;
  int seq;
  int totalCnt;
  String hkgb;
  int rnum;

  SimpleSearchResultModel({this.ptno, this.kr_name, this.en_name, this.price, this.seq, this.totalCnt, this.hkgb, this.rnum});

  factory SimpleSearchResultModel.fromMap(Map<String, dynamic> map) => SimpleSearchResultModel(
    ptno: map['ptno'],
    kr_name: map['kr_nm'],
    en_name: map['en_nm'],
    price: map['price'],
    seq: map['seq'],
    totalCnt: map['tot_cnt'],
    hkgb: map['hkgb'],
    rnum: map['rnum'],
  );
}

