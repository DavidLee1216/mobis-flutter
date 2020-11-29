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
  String stype;
  String adrdtl;
  String agentCode;
  String sapCode;
  int rnum;

  MarketSearchResultModel(
      {this.ptno,
      this.mutual,
      this.adr,
      this.sigungu,
      this.url,
      this.totalCnt,
      this.zipcd,
      this.sido,
      this.tel,
      this.hkgb,
      this.stype,
      this.adrdtl,
      this.agentCode,
      this.sapCode,
      this.rnum});

  factory MarketSearchResultModel.fromMap(Map<String, dynamic> map) =>
      MarketSearchResultModel(
        ptno: map['ptno'],
        mutual: map['mutual'],
        adr: map['adr'],
        sigungu: map['sigungu'],
        url: map['url'],
        totalCnt: map['tot_CNT'],
        zipcd: map['zipcd'],
        sido: map['sido'],
        tel: map['tel'],
        hkgb: map['hkgb'],
        stype: map['stype'],
        adrdtl: map['adr_dtl'],
        agentCode: map['agent_cd'],
        sapCode: map['sap_code'],
        rnum: map['rnum'],
      );
}

class MarketSearchResultProductInfo {
  int seq;
  String hkgb;
  String ptno;
  String krname;
  String enname;
  int price;

  MarketSearchResultProductInfo(
      {this.seq, this.hkgb, this.ptno, this.krname, this.enname, this.price});

  factory MarketSearchResultProductInfo.fromMap(Map<String, dynamic> map) =>
      MarketSearchResultProductInfo(
        seq: map['seq'],
        hkgb: map['hkgb'],
        ptno: map['ptno'],
        krname: map['krnm'],
        enname: map['ennm'],
        price: map['price'],
      );
}
