
class Sido{
  int seq;
  String sido;
  List<Sigungu> sigungus;
  Sido({this.seq, this.sido, this.sigungus});

  factory Sido.fromMap(Map<String, dynamic> map) => Sido(
    seq: map['seq'],
    sido: map['sido'],
  );
}

class Sigungu{
  int seq;
  String sigungu;
  Sigungu({this.seq, this.sigungu});

  factory Sigungu.fromMap(Map<String, dynamic> map) => Sigungu(
    seq: map['seq'],
    sigungu: map['sigungu'],
  );
}