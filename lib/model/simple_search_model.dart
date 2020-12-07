class SimpleSearchResultModel {
  String ptno;
  String krname;
  String enname;
  int price;
  int seq;
  int totalCnt;
  String hkgb;
  int rnum;

  SimpleSearchResultModel(
      {this.ptno,
      this.krname,
      this.enname,
      this.price,
      this.seq,
      this.totalCnt,
      this.hkgb,
      this.rnum});

  factory SimpleSearchResultModel.fromMap(Map<String, dynamic> map) =>
      SimpleSearchResultModel(
        ptno: map['ptno'],
        krname: map['kr_nm'],
        enname: map['en_nm'],
        price: map['price'],
        seq: map['part_Price_seq'],
        totalCnt: map['tot_cnt'],
        hkgb: map['hkgb'],
        rnum: map['rnum'],
      );
}
