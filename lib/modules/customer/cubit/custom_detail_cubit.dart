import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/modules/customer/model/customer.dart';
import 'package:uuid/uuid.dart';
import '../../../core/firebase_repository.dart';

part 'custom_detail_state.dart';

class CustomDetailCubit extends Cubit<CustomDetailState> {
  CustomDetailCubit() : super(CustomDetailInitial());
  final FirebaseRepository _firebaseRepository = FirebaseRepository();
  static const String _key = "customer";
  static const String _image = "image_set";

  void loadList() {
    emit(state.copyWith(loadStatus: Status.working));
    try {
      final List<Customer> list = [];
      final data = _firebaseRepository.originData[_key] as Map;
      data.forEach((key, value) {
        list.add(Customer.fromJson(value));
      });

      emit(state.copyWith(loadStatus: Status.success, customerList: list));
    } catch (ex) {
      emit(state.copyWith(loadStatus: Status.failure));
    }
  }

  void assignEditCustomer(Customer customer) async {
    try {
      emit(state.copyWith(editCustomer: customer));
      final imageList = await _firebaseRepository.loadImage(customer.id);
      emit(state.copyWith(
          editCustomer: state.editCustomer.copyWith(imageList: imageList)));
    } catch (ex) {
      print(ex.toString());
    }
  }

  void changeName(String value) => emit(
      state.copyWith(editCustomer: state.editCustomer.copyWith(name: value)));

  void changeBrandIntroduction(String value) => emit(state.copyWith(
      editCustomer: state.editCustomer.copyWith(brandIntroduction: value)));

  void changeDesignIntroduction(String value) => emit(state.copyWith(
      editCustomer: state.editCustomer.copyWith(designIntroduction: value)));

  void changeWebURL(String value) => emit(
      state.copyWith(editCustomer: state.editCustomer.copyWith(webUrl: value)));

  void appendImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: true,
      );
      if (result == null) return;

      for (int i = 0; i < result.files.length; i++) {
        try {
          emit(
            state.copyWith(
              editCustomer: state.editCustomer.copyWith(
                imageList: [
                  ...state.editCustomer.imageList,
                  base64Encode(result.files[i].bytes!),
                ],
              ),
            ),
          );
        } catch (pex) {
          print(pex.toString());
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  void removeImage(int index) {
    emit(
      state.copyWith(
        editCustomer: state.editCustomer.copyWith(
          imageList: List.from(state.editCustomer.imageList)..removeAt(index),
        ),
      ),
    );
  }

  void save() async {
    emit(state.copyWith(uploadStatus: Status.working));
    try {
      final newCustomer = state.editCustomer.copyWith(
          id: state.editCustomer.id.isEmpty ? const Uuid().v1() : null);
      await _firebaseRepository.ref.child(_key).update(<String, dynamic>{
        newCustomer.id: newCustomer.toMap(),
      });

      await _firebaseRepository.uploadImage(
          newCustomer.id, state.editCustomer.imageList);
      emit(state.copyWith(uploadStatus: Status.success));
      emit(state.copyWith(
          uploadStatus: Status.init, editCustomer: Customer.empty));
    } catch (ex) {
      emit(state.copyWith(uploadStatus: Status.failure));
    }
  }

  void delete(String id) async {
    try {
      await _firebaseRepository.ref.child(_key).child(id).remove();
      emit(state.copyWith(
          customerList: state.customerList
              .where((element) => element.id != id)
              .toList()));
    } catch (ex) {}
  }
}
