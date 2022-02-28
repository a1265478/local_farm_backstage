import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/core/firebase_repository.dart';
import 'package:local_farm_backstage/core/model/image_file.dart';

part 'line_content_state.dart';

class LineContentCubit extends Cubit<LineContentState> {
  LineContentCubit() : super(LineContentInitial());
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  static const String _key = "line_content";

  void getData() async {
    try {
      final data = _firebaseRepository.originData[_key] as List;
      List<ImageFile> list = data.map((e) => ImageFile.fromJson(e)).toList();
      emit(state.copyWith(imageList: list));
    } catch (ex) {
      print(ex.toString());
    }
  }

  void chooseFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      if (result == null) return;
      if (state.imageList
          .where((element) => element.filename == result.files.first.name)
          .toList()
          .isNotEmpty) return;

      emit(
        state.copyWith(
          imageList: [
            ImageFile(
              base64: base64Encode(result.files.first.bytes!),
              filename: result.files.first.name,
            ),
            ...state.imageList,
          ],
        ),
      );
    } catch (ex) {}
  }

  void deleteImage(String name) {
    emit(
      state.copyWith(
          imageList: state.imageList
              .where((element) => element.filename != name)
              .toList()),
    );
  }

  void submitImageFile() async {
    emit(state.copyWith(updateStatus: Status.working));
    try {
      await _firebaseRepository.updateData(<String, dynamic>{
        _key: [...state.imageList.map((e) => e.toJson())]
      });
      emit(state.copyWith(updateStatus: Status.success));
    } catch (ex) {
      emit(state.copyWith(updateStatus: Status.failure));
    }
  }
}
