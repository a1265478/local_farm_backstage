import 'package:firebase_database/firebase_database.dart';

class FirebaseRepository {
  static final FirebaseRepository _singleton = FirebaseRepository._internal();

  factory FirebaseRepository() {
    return _singleton;
  }

  FirebaseRepository._internal();

  Map<String, dynamic> get originData => _originData;
  Map<String, dynamic> _originData = {};

  DatabaseReference ref = FirebaseDatabase.instance.ref("data");

  Future<bool> isSyncDataFromFirebase() async {
    try {
      final json = await ref.once();
      Map<String, dynamic> result = json.snapshot.value as Map<String, dynamic>;
      _originData = result;
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<void> updateData(Map<String, dynamic> data) async {
    try {
      await ref.update(data);
    } catch (ex) {
      throw ex;
    }
  }
}
