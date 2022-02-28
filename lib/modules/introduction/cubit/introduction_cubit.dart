import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/core/firebase_repository.dart';
import 'package:local_farm_backstage/core/model/introduction.dart';
part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit() : super(IntroductionInitial());

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  static const String _key = "introduction";

  getData() async {
    try {
      final data = _firebaseRepository.originData[_key] as List;
      List<Introduction> list =
          data.map((e) => Introduction.fromJson(e)).toList();
      emit(state.copyWith(introductionList: list));
    } catch (ex) {
      print(ex.toString());
    }
  }

  updateTitle(String id, String value) {
    emit(state.copyWith(
        introductionList: state.introductionList
            .map((introduction) => introduction.id == id
                ? introduction.copyWith(title: value)
                : introduction)
            .toList()));
  }

  updateItem(String id, String value) {
    emit(state.copyWith(
        introductionList: state.introductionList
            .map((introduction) => introduction.id == id
                ? introduction.copyWith(items: value)
                : introduction)
            .toList()));
  }

  submitIntroduction() async {
    emit(state.copyWith(updateStatus: Status.working));
    try {
      await _firebaseRepository.updateData(<String, dynamic>{
        "introduction": [...state.introductionList.map((e) => e.toJson())]
      });
      emit(state.copyWith(updateStatus: Status.success));
    } catch (ex) {
      emit(state.copyWith(updateStatus: Status.failure));
    }
  }
}
