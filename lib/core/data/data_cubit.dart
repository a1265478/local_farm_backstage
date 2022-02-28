import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:local_farm_backstage/core/enumKey.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());

  void syncDataFromFirebase() async {
    emit(state.copyWith(status: Status.working));
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("data");
      final json = await ref.once();
      Map<String, dynamic> result = json.snapshot.value as Map<String, dynamic>;
      emit(state.copyWith(status: Status.success, data: result));
    } catch (ex) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void updateData(Map<String, dynamic> newData) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("data");
      await ref.update(newData);
      print("updated");
    } catch (ex) {
      print("failure");
    }
  }
}
