
class ModelSeq{
  final int seq;
  final String modelname;

  ModelSeq({this.seq, this.modelname});

  factory ModelSeq.fromMap(Map<String, dynamic> map) => ModelSeq(
    seq: map['seq'],
    modelname: map['cpnm'],
  );

}