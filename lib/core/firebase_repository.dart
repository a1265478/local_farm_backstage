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
      rethrow;
    }
  }

  Future<List<String>> loadImage(String id) async {
    try {
      DatabaseReference imageRef = FirebaseDatabase.instance.ref("image_set");
      final json = await imageRef.child(id).once();
      final result = json.snapshot.value as List;
      return result.cast<String>();
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> uploadImage(String id, List<String> base64List) async {
    try {
      DatabaseReference imageRef = FirebaseDatabase.instance.ref("image_set");
      await imageRef.update(<String, dynamic>{
        id: [...base64List]
      });
    } catch (ex) {
      rethrow;
    }
  }
}
