import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/core/firebase_repository.dart';
import 'package:local_farm_backstage/modules/info/model/info.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitial());
  final FirebaseRepository _firebaseRepository = FirebaseRepository();
  static const String _key = "info";
  void loadData() async {
    try {
      final data = _firebaseRepository.originData[_key] as Map<String, dynamic>;
      emit(state.copyWith(info: Info.fromJson(data)));
    } catch (ex) {
      print(ex.toString());
    }
  }

  void changeSendEmail(String value) =>
      emit(state.copyWith(info: state.info.copyWith(sendEmail: value)));

  void changeEmail(String value) =>
      emit(state.copyWith(info: state.info.copyWith(email: value)));

  void changeSendAddress(String value) =>
      emit(state.copyWith(info: state.info.copyWith(address: value)));

  void changeSendPhone(String value) =>
      emit(state.copyWith(info: state.info.copyWith(phone: value)));

  void changeSendMobilePhone(String value) =>
      emit(state.copyWith(info: state.info.copyWith(mobilePhone: value)));

  void save() async {
    emit(state.copyWith(saveStatus: Status.working));
    try {
      await _firebaseRepository.updateData(<String, dynamic>{
        _key: state.info.toMap(),
      });
      emit(state.copyWith(saveStatus: Status.success));
    } catch (ex) {
      emit(state.copyWith(saveStatus: Status.failure));
    }
  }
}
