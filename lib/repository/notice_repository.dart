import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeRepository{
  final FirebaseFirestore _firestore;
  NoticeRepository({
    FirebaseFirestore firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTitleNoticeStream(String title) {
    return _firestore
        .collection('notices')
        .doc()
        .collection('items')
        .snapshots();
  }

  Stream<QuerySnapshot> getContentNoticeStream(String keyword) {
    return _firestore
        .collection('notices')
        .doc()
        .collection('items')
        .snapshots();
  }
}