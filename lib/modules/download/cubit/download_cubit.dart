import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:local_farm_backstage/modules/download/model/download.dart';
import 'package:uuid/uuid.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  void uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );
      if (result == null) return;
      for (int i = 0; i < result.files.length; i++) {
        final id = const Uuid().v1();

        try {
          FirebaseStorage storage = FirebaseStorage.instance;
          await storage.ref("/download/$id").putData(result.files[i].bytes!);

          emit(state.copyWith(downloadList: [
            Download(id: id, filename: result.files[i].name),
            ...state.downloadList
          ]));
        } catch (ex) {
          emit(
            state.copyWith(
              downloadList: [
                Download(id: id, filename: "失敗檔案"),
                ...state.downloadList
              ],
            ),
          );
        }
      }
    } catch (ex) {}
  }

  void removeFile(String id) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      await storage.ref("/download/$id").delete();

      emit(
        state.copyWith(
          downloadList:
              state.downloadList.where((element) => element.id != id).toList(),
        ),
      );
    } catch (ex) {}
  }
}
