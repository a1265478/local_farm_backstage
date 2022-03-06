import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/core/firebase_repository.dart';
import 'package:local_farm_backstage/modules/service/model/service.dart';
import 'package:uuid/uuid.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  final FirebaseRepository _firebaseRepository = FirebaseRepository();
  static const String _key = "service";

  void loadServiceList() async {
    try {
      final List<Service> list = [];
      final data = _firebaseRepository.originData[_key] as Map;
      data.forEach((key, value) {
        list.add(Service.fromJson(value));
      });

      emit(state.copyWith(serviceList: list));
    } catch (ex) {
      print(ex.toString());
    }
  }

  void setEditService(Service service) {
    emit(state.copyWith(editService: service));
  }

  void updateServiceType(String value) {
    emit(state.copyWith(editService: state.editService.copyWith(type: value)));
  }

  void updateServiceTitle(String value) {
    emit(state.copyWith(editService: state.editService.copyWith(title: value)));
  }

  void updateServiceContent(String value) {
    emit(state.copyWith(
        editService: state.editService.copyWith(content: value)));
  }

  void updateServicePrice(String value) {
    emit(state.copyWith(
        editService: state.editService.copyWith(price: int.tryParse(value))));
  }

  void submitService() async {
    emit(state.copyWith(saveStatus: Status.working));
    try {
      final isEdit = state.editService.id.isNotEmpty;
      final id = state.editService.id.isEmpty
          ? const Uuid().v1()
          : state.editService.id;

      final editService = state.editService.copyWith(id: id);

      await _firebaseRepository.ref
          .child(_key)
          .update(<String, dynamic>{id: editService.toMap()});
      emit(state.copyWith(
          saveStatus: Status.success,
          serviceList: isEdit
              ? state.serviceList
                  .map((e) => e.id == state.editService.id ? editService : e)
                  .toList()
              : [editService, ...state.serviceList]));
    } catch (ex) {
      emit(state.copyWith(saveStatus: Status.failure));
    }

    emit(state.copyWith(saveStatus: Status.init));
  }

  void deleteService(String id) async {
    try {
      await _firebaseRepository.ref.child(_key).child(id).remove();
      emit(state.copyWith(
          serviceList:
              state.serviceList.where((element) => element.id != id).toList()));
    } catch (ex) {}
  }
}
